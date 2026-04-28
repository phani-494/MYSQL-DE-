# SELECT 

show databases;
use retail_db2;
show tables;
-- to display all columns with all records
-- here * refers to all columns
select * from orders_now;

# if u want  some specific columns ,then mention the column names

select customer_id,quantity from  orders_now; # displays only those 2 columns

# if we want some specific columns we can use 'where' clause

select * from orders_now where quantity=4;
/*
id, order_item_id, order_date, customer_id, product_id, quantity, product_price, order_status
4	8	2013-07-25	8827	1014	4	50	null
8	19	2013-07-25	2911	1014	4	50	null
*/


select count(*) from orders_now where quantity=1; # no of records with quantity=1 is 11.

select  * from orders_now where customer_id>10000;
/*
1	1	2013-07-25	11599	957	1	300
5	9	2013-07-25	11318	957	1	300
5	10	2013-07-25	11318	365	5	60
5	11	2013-07-25	11318	1014	2	50
5	12	2013-07-25	11318	957	1	300
5	13	2013-07-25	11318	403	1	130
*/


# let's assume we created a employees table here and see some examples here 

select count(*) from employees;  # 30 records in the employees table

 -- get employee details where employee first name is John
 SELECT * FROM employees WHERE first_name = 'John'; # gives all records  where first_name is  John 

  -- all employees whose salary is more than 60000
  
  SELECT * FROM employees WHERE salary > 60000;
  
  
SELECT count(*) FROM employees WHERE salary > 60000;

SELECT * FROM employees WHERE first_name > 'John' ; # gives  the names which are greater than John as per dictionary order

SELECT * FROM employees WHERE department_id = 3; 

-- get all the employees who hired after year 2025

select * from employees  where hire_date> '2025-12-31';

# till now we have applied one condition here
-- let's apply more conditions (multiple filters) using the logical operators

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,salary DECIMAL(10,2),hire_date DATE,
    manager_id INT,email VARCHAR(100),phone_number VARCHAR(20),job_title VARCHAR(50)
);


INSERT INTO employees 
(employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, email, phone_number, job_title)
VALUES
(1, 'John', 'Smith', 101, 55000.00, '2023-01-15', NULL, 'john.smith@email.com', '9876543210', 'Manager'),
(2, 'Emma', 'Johnson', 102, 42000.00, '2023-02-10', 1, 'emma.j@email.com', '9876543211', 'Analyst'),
(3, 'Michael', 'Brown', 103, 46000.00, '2023-03-05', 1, 'michael.b@email.com', '9876543212', 'Developer'),
(4, 'Sophia', 'Davis', 101, 39000.00, '2023-04-12', 1, 'sophia.d@email.com', '9876543213', 'HR Executive'),
(5, 'Daniel', 'Wilson', 104, 60000.00, '2023-05-20', NULL, 'daniel.w@email.com', '9876543214', 'Director'),
(6, 'Olivia', 'Taylor', 102, 43000.00, '2023-06-18', 2, 'olivia.t@email.com', '9876543215', 'Analyst'),
(7, 'James', 'Anderson', 103, 47000.00, '2023-07-01', 3, 'james.a@email.com', '9876543216', 'Developer'),
(8, 'Ava', 'Thomas', 101, 38000.00, '2023-07-15', 1, 'ava.t@email.com', '9876543217', 'Recruiter'),
(9, 'William', 'Jackson', 104, 52000.00, '2023-08-10', 5, 'william.j@email.com', '9876543218', 'Finance Analyst'),
(10, 'Mia', 'White', 105, 41000.00, '2023-09-05', NULL, 'mia.w@email.com', '9876543219', 'Team Lead'),
(11, 'Benjamin', 'Harris', 105, 39000.00, '2023-09-15', 10, 'ben.h@email.com', '9876543220', 'Support Engineer'),
(12, 'Charlotte', 'Martin', 102, 44000.00, '2023-10-01', 2, 'charlotte.m@email.com', '9876543221', 'Data Analyst'),
(13, 'Lucas', 'Thompson', 103, 49000.00, '2023-10-10', 3, 'lucas.t@email.com', '9876543222', 'Backend Dev'),
(14, 'Amelia', 'Garcia', 101, 37000.00, '2023-11-01', 1, 'amelia.g@email.com', '9876543223', 'HR Assistant'),
(15, 'Henry', 'Martinez', 104, 58000.00, '2023-11-20', 5, 'henry.m@email.com', '9876543224', 'Accountant'),
(16, 'Evelyn', 'Robinson', 102, 45000.00, '2023-12-01', 2, 'evelyn.r@email.com', '9876543225', 'BI Analyst'),
(17, 'Alexander', 'Clark', 103, 51000.00, '2024-01-05', 3, 'alex.c@email.com', '9876543226', 'Software Engineer'),
(18, 'Harper', 'Rodriguez', 105, 40000.00, '2024-01-12', 10, 'harper.r@email.com', '9876543227', 'Support Exec'),
(19, 'Sebastian', 'Lewis', 104, 56000.00, '2024-02-01', 5, 'seb.lewis@email.com', '9876543228', 'Auditor'),
(20, 'Ella', 'Lee', 101, 39500.00, '2024-02-18', 1, 'ella.lee@email.com', '9876543229', 'HR Executive'),
(21, 'Jack', 'Walker', 103, 50000.00, '2024-03-05', 3, 'jack.w@email.com', '9876543230', 'Frontend Dev'),
(22, 'Scarlett', 'Hall', 102, 43000.00, '2024-03-15', 2, 'scarlett.h@email.com', '9876543231', 'Analyst'),
(23, 'David', 'Allen', 105, 42000.00, '2024-04-01', 10, 'david.a@email.com', '9876543232', 'System Admin'),
(24, 'Grace', 'Young', 101, 38500.00, '2024-04-20', 1, 'grace.y@email.com', '9876543233', 'Recruiter'),
(25, 'Joseph', 'King', 104, 61000.00, '2024-05-05', 5, 'joseph.k@email.com', '9876543234', 'Finance Manager'),
(26, 'Chloe', 'Wright', 102, 46000.00, '2024-05-15', 2, 'chloe.w@email.com', '9876543235', 'Reporting Analyst'),
(27, 'Matthew', 'Scott', 103, 53000.00, '2024-06-01', 3, 'matthew.s@email.com', '9876543236', 'Senior Developer'),
(28, 'Lily', 'Green', 101, 37500.00, '2024-06-12', 1, 'lily.g@email.com', '9876543237', 'HR Coordinator'),
(29, 'Samuel', 'Baker', 105, 44000.00, '2024-07-01', 10, 'sam.b@email.com', '9876543238', 'Tech Support'),
(30, 'Zoey', 'Adams', 104, 59000.00, '2024-07-15', 5, 'zoey.a@email.com', '9876543239', 'Accounts Lead');



select * from employees;

-- get all the employees whose department_id=1 and whose salary> 35000  (both criteria should be satisfied)

select * from employees where department_id=101   and  salary>35000;

/*
employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, email, phone_number, job_title
1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager
4	Sophia	Davis	101	39000.00	2023-04-12	1	sophia.d@email.com	9876543213	HR Executive
8	Ava	Thomas	101	38000.00	2023-07-15	1	ava.t@email.com	9876543217	Recruiter
14	Amelia	Garcia	101	37000.00	2023-11-01	1	amelia.g@email.com	9876543223	HR Assistant
20	Ella	Lee	101	39500.00	2024-02-18	1	ella.lee@email.com	9876543229	HR Executive
24	Grace	Young	101	38500.00	2024-04-20	1	grace.y@email.com	9876543233	Recruiter
28	Lily	Green	101	37500.00	2024-06-12	1	lily.g@email.com	9876543237	HR Coordinator

*/

-- get the employees who are working in any of  the departments 
select * from employees where department_id=101   or  department_id=105 ; # 12 employees exists

-- get the employees who are working for both the departments 
select * from employees where department_id=101   and  department_id=105 ; # 0 as both cannot work in same department


select * from employees where department_id=101  or  department_id=102 and job_title="Manager" ; 

/*
1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager
4	Sophia	Davis	101	39000.00	2023-04-12	1	sophia.d@email.com	9876543213	HR Executive
8	Ava	Thomas	101	38000.00	2023-07-15	1	ava.t@email.com	9876543217	Recruiter
14	Amelia	Garcia	101	37000.00	2023-11-01	1	amelia.g@email.com	9876543223	HR Assistant
20	Ella	Lee	101	39500.00	2024-02-18	1	ella.lee@email.com	9876543229	HR Executive
24	Grace	Young	101	38500.00	2024-04-20	1	grace.y@email.com	9876543233	Recruiter
28	Lily	Green	101	37500.00	2024-06-12	1	lily.g@email.com	9876543237	HR Coordinator

*/

/*
In SQL:
AND is evaluated first
OR is evaluated second
So SQL reads your query as:
WHERE department_id = 101
   OR (department_id = 102 AND job_title = 'Manager')
Meaning in Simple Terms
It returns:
All employees in department 101
OR
Employees in department 102 whose job_title = 'Manager'
-- get all the employees whose department is 1 and 5
*/

-- what we want actually is  to get all the managers from dept 101 and 102
-- we need to use () here 

-- it returns only managers from 101 and 102.
-- first bracket cell will be evaluated 
select * from employees where (department_id=101  or  department_id=102 ) and job_title="Manager" ; 
-- actually there are no managers from dept_id 102
/*
1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager
*/

#   and have more precedence than  or 


select * from employees where department_id=101 and salary>30000 and hire_date > '2023-12-31';

/*
20	Ella	Lee	101	39500.00	2024-02-18	1	ella.lee@email.com	9876543229	HR Executive
24	Grace	Young	101	38500.00	2024-04-20	1	grace.y@email.com	9876543233	Recruiter
28	Lily	Green	101	37500.00	2024-06-12	1	lily.g@email.com	9876543237	HR Coordinator
*/


select * from employees where salary between 35000 and 50000; # gives the list of all records whose salary ranges from 35000 to 50000

-- get all the employees who hired in between 2023-2023 december 

select * from employees where hire_date between  '2023-01-01' and '2023-12-31' ; 

-- suppose we want some random department id here which is not in some exact range 
-- in that case we use 'in' here

select * from employees where department_id in (101,103,107); # it works as department_id =101 or department_id=103 or department_id=107


# u want employees who are not in the above departments

select * from employees where department_id  not in (101,103,107); 
-- the above statement is equivalent to : where not  (department_id =101 or department_id=103 or department_id=107)

select * from employees where job_title  not in ('Director','Data Analyst','Director','BI Analyst','Manager'); 


-- get all the employees who do not have manager;
select * from employees  where manager_id is NULL;
/*
1	John	Smith	101	55000.00	2023-01-15	null 	john.smith@email.com	9876543210	Manager
5	Daniel	Wilson	104	60000.00	2023-05-20	null 	daniel.w@email.com	9876543214	Director
10	Mia  	White	105	41000.00	2023-09-05	null	mia.w@email.com	9876543219	Team Lead
*/

-- we cannot give as  department_id= Null since null is not comparable with anything here

-- give all employees who have manager 
select * from employees  where manager_id is not NULL;












