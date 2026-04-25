use retail_db4;
drop table orders;
-- FOREIGN KEY CONSTRAINT
# Used to enforce link between 2 tables.
# we can relate 2 tables together using the foreign key constraint 
# in one table a column will acts as PK and in another table same column will be treated as FK.


-- let's create 2 tables  customers and orders 
-- one customer can place many orders . so customer_id will be stored in orders table.
-- to join these 2 tables, we have customer_id here 
-- in customers table customer_id is unique and acts as PK because we have only unique customers
-- in orders table we have customer_id as we need details of order placed by customer and 
-- there will be so many orders placed by a same customer . so here customer_id allows duplicates also and acts as FK in orders table.

# suppose u create both tables and data looks like this;


create table customers (customer_id int primary key,fname varchar(20),lname varchar(20));

insert into customers values (1, "indra" ,"sena");

create table orders (order_id int primary key, order_date date,customer_id int); # FK constraint  is not mentioned here 
-- customer_id 2 doesn't exists in customers table..
insert into orders values (101 ,"2026-09-08" ,1),(102, "2026-09-08", 2); # works fine this since FK constraint is not mentioned 

 -- here we haven't mentioned  customer_id in orders table as FK in orders table

 /*
 for example u  entered data in customers table as :    1 "indra" "sena"
 
 and in orders table we have
 
 101 "2026-09-08" 1
 102 "2026-09-08" 2  # this cannot be allowed here as there is no customer_id 2  in the customers table.
 
 how he can there be order placed by customer_id 2 where he is not present in the customers table
 
 we need to mention the foreign key here for orders table column customer_id 
 
 */
 
 
-- let' drop both the tables and create again
drop table customers,orders;

create table customers (customer_id int primary key,fname varchar(20),lname varchar(20));
insert into customers values (1, "indra" ,"sena");

# we are giving FK here 
create table orders (order_id int primary key, order_date date,customer_id int, Foreign key (customer_id) references customers(customer_id));
insert into orders values (101 ,"2026-09-08" ,1); #works fine here 
insert into orders values (102, "2026-09-08", 2); # gives error as below  since customer_id 2 is not present in customers table
-- Error Code: 1452. Cannot add or update a child row: a foreign key    ... continued below  
-- constraint fails (`retail_db4`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))

-- we cannot insert orders if the customer_id is not present in the customers table


# let's see FK with on delete cascade 
-- suppose in both tables we have customer_id 2  and we can enter orders only for the customers who are existing in the customers table

-- if we delete the customer_id 2 in customers table then orders placed by customer_id 2 are
-- also (non -relevant) useless as there is no need of them in orders table and constraint will be violated.
-- customers are removed but still their orders are present which is not logical 
-- so we need to delete all that orders for customer id in  orders table

# let' drop these 2 tables here  first we need to drop the orders table as it uses referencing   and then customers table need to be dropped
-- if u delete customers table first then orders table needs reference which is not present so it gives error 
# suppose if u try to drop first customers table then we get error as :
-- Error Code: 3730. Cannot drop table 'customers' referenced by a foreign key constraint 'orders_ibfk_1' on table 'orders'.

-- first we need to  delete the child here and then the parent here 
drop table orders; # so first we need to drop this 
drop table customers;

-- so what we want here is : if I delete a customer from customer  table then all the related information should be deleted 
-- from the customers in orders table. so we need to give on  delete cascade to FK  in orders 
-- if on delete cascade is not given , then if u try to delete customer_id then it will not allow as it is referenced by orders table column

delete from customers where customer_id=1;
-- Error Code: 1451. Cannot delete or update a parent row: 
-- a foreign key constraint fails (`retail_db4`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))


# if we use on delete cascade, then  automatically if we delete customer in customers table, then they will be removed from orders table also

-- and again create here
create table customers (customer_id int primary key,fname varchar(20),lname varchar(20));

insert into customers values(1,"siva","raj");
insert into customers values(2,"vishnu","reddy");


create table orders (order_id int primary key, order_date date,customer_id int,
 Foreign key (customer_id) references customers(customer_id) on delete cascade);

insert into orders values (101 ,"2026-09-08" ,1); #works fine here 
insert into orders values (102, "2026-09-08", 2);


select * from orders,customers;
/*
order_id, order_date, customer_id, customer_id, fname, lname
102	2026-09-08	2	1	siva	raj
101	2026-09-08	1	1	siva	raj
102	2026-09-08	2	2	vishnu	reddy
101	2026-09-08	1	2	vishnu	reddy

*/

select * from orders,customers;
/*
delete from customers where customer_id=1; # allowed as on delete cascade is given

-- after deleting we have data left only this:
select * from orders,customers
102	2026-09-08	2	2	vishnu	reddy

*/
-- for more clarity see here

select * from orders ;# 102	2026-09-08	2    - only this left 

-- on update cascade

-- if we make any changes in the parent table, then those changes also must be reflected in the child table also.
-- for example if we change customer_id 1 to 15 in customers table, then it must be reflected back in the orders table also.as

-- drop both tables again and start from fresh

drop table orders; # so first we need to drop this 
drop table customers;

create table customers (customer_id int primary key,fname varchar(20),lname varchar(20));

insert into customers values(1,"siva","raj");
insert into customers values(2,"vishnu","reddy");


create table orders (order_id int primary key, order_date date,customer_id int,
 Foreign key (customer_id) references customers(customer_id) on update cascade);

insert into orders values (101 ,"2026-09-08" ,1); #works fine here 
insert into orders values (102, "2026-09-08", 2);


update customers set customer_id=15 where customer_id=1;

select * from customers;
/*
2	vishnu	reddy
15	siva	raj
*/

select * from orders;

/*
101	2026-09-08	15
102	2026-09-08	2
*/



# let's say we have 3 tables - students, courses ,enrollments  tables
# a student can enroll to multiple courses 
-- for example: one student can purchase multiple courses and one course can be enrolled by multiple students 
-- which is like many-many relations
-- in such cases we take help of one more table here and find out the relations between them.


-- let's drop the tables again and create them
drop table orders;
drop table customers;
drop table students;


create table students (student_id int primary key, fname varchar(50), lname varchar(50));

create table courses (course_id int primary key, course_name varchar(20));


create table enrollments(student_id int,course_id int, enrollment_date date,
   primary key(student_id, course_id),
   foreign key (student_id) references students (student_id),
   foreign key (course_id) references courses (course_id));
   

insert into students values (1, "Thani","reddy");
insert into students values(2,"Narsi","babu");


insert into courses values (101, "JAVA");
insert into courses values(102,"Python");   
   

insert into  enrollments values (1,101,current_date);
insert into  enrollments values (1,102,current_date);
insert into  enrollments values (2,101,current_date);
insert into  enrollments values (2,102,current_date);

-- SELF REFERENCING FOREIGN KEY 

drop table employees;
-- let' say we have employees table here : here manager is also one of the employee and he should refer to the employee id 
-- so manager_id should be referenced to the emp_id in the table

-- SELF REFERENCING FOREIGN KEY
# for understanding purpose we are not giving any key constraints 
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    manager_id INT
);
-- since no constraints are given here , so this will works fine here 
INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (1, 'John', 'Doe', NULL); # john is a manager here with emp_id as 1 . since he is a manager so he no need to report to any  manager_id 

INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (2, 'Jane', 'Smith', 1); # jane is a employee who reports to manager John whose emp_id is 1 

INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (3, 'Alice', 'Johnson', 99); # alice is a employee who reports to manager with emp_id 99 but here it is not present


# now the manager_id column will refer to the employee_id in the same table;

drop table employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    manager_id INT,
    foreign key (manager_id) references employees(employee_id));
    

INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (1, 'John', 'Doe', NULL); # john is a manager here with emp_id as 1 . since he is a manager so he no need to report to any  manager_id 

INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (2, 'Jane', 'Smith', 1); 

# now we get the error here as 99  employee_id is not present

INSERT INTO employees (employee_id, first_name, last_name, manager_id)
VALUES (3, 'Alice', 'Johnson', 99); # where is manager_id with employee_id 99 here 

# Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`retail_db4`.`employees`, CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `employees` (`employee_id`))




