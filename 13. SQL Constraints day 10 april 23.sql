# SQL constraints
-- suppose we define a table called employees with one of the column name as "Age" with datatype as int, then it must be >21 here
-- we can also enter age as -5 but it is invalid data .so we need to put some constraint for not entering the invalid data .
-- or in voting cases , let's say for age , it must be  > 18 .  
-- like these ,we need to add the constraints here for inserting the qualitative data.
-- we can specify the rules for a table .

# when we give constraints, we can maintain accuracy and reliability in data.

# when to specify the constraints ?-- there are 2 cases:
# 1. while creating the table   2. after creation later alter the table definition and add constraint...alter

# let's create the new database here


create database retail_db4;
use retail_db4;

# let's create a table named orders here

create table orders(order_id int, order_item_id int, customer_id int,order_status varchar(20),product_id int, quantity int,product_price float);

# for the valid order status , we need to  have only 4 values as:
# CLOSED COMPLETE PROCESSED PENDING 
# if any other value is given then it is not valid for order_status . it should be from that 4 values only.
# since order_status is varchar ,we can also enter other values but it should give error.

insert into orders values(1,2,3,"DONE",3,2,100); # see here we entered wrong value for the order_status and it is accepted.

# so we need to enforce some constraint and add some condition for not inserting the  invalid values ..

alter table orders add check (order_status in ( 'CLOSED', 'COMPLETE', 'PROCESSED', 'PENDING' ));

# we get error here as: Error code: 3819. check constraint 'orders_chk_1 ' is violated here
# since already data is present with some invalid value for order_status  and DONE present which is not in the constraint
--   ... so it given error here since constraint here is not matching with the already existing data.

# so we delete that record first and then add the constarint

delete from orders where order_status="DONE";

select * from orders; # gives empty table
# now add the constraint 


alter table orders add check (order_status in ( 'CLOSED', 'COMPLETE', 'PROCESSED', 'PENDING' )); # now successful
# now the table will accept only above values for order_status 


insert into orders values(1,2,3,"DONE",3,2,100); # see here we entered wrong value for the order_status and it is not accepted.
# this gives error as : Error code: 3819. check constraint 'orders_chk_1 ' is violated here
insert into orders values(1,2,3,"COMPLETE",3,2,100); # successful here 

# we can check how the constraint was created and what is it's name 
# observe that constraint name is orders_chk_1 here which is be default.
# we can also give our own name to the constraint here.
show create table orders; # this helps us to show how the table orders was created .

/*
CREATE TABLE `orders` (
   `order_id` int DEFAULT NULL,
   `order_item_id` int DEFAULT NULL,
   `customer_id` int DEFAULT NULL,
   `order_status` varchar(20) DEFAULT NULL,
   `product_id` int DEFAULT NULL,
   `quantity` int DEFAULT NULL,
   `product_price` float DEFAULT NULL,
   CONSTRAINT `orders_chk_1` CHECK ((`order_status` in (_utf8mb4'CLOSED',_utf8mb4'COMPLETE',_utf8mb4'PROCESSED',_utf8mb4'PENDING')))
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
 
 */
 
 --  we can drop the constraint here by using the alter
 # give the default name of the constraint.
 alter table orders drop check orders_chk_1 ; # success and no constraint is present now 
 
# we can give our own name to the constraints instead of the default ones here
# Condition_1 is name of the constraint 
alter table orders add constraint Condition_1 check  (order_status in ( 'CLOSED', 'COMPLETE', 'PROCESSED', 'PENDING' )); # success

insert into orders values(1,2,3,"DONE",3,2,100);
# gives error as :Error Code: 3819. Check constraint 'Condition_1' is violated.	0.000 sec

 
 -- the second way to see the constraints is in the information_schema here
 use information_schema;
 show tables; # we have table named check_constraints which have the list of constraints in all databases.
 select * from check_constraints; 
 -- Condition_1	(`order_status` in (_utf8mb4\'CLOSED\',_utf8mb4\'COMPLETE\',_utf8mb4\'PROCESSED\',_utf8mb4\'PENDING\'))
 
 use retail_db4;
 
 drop table orders;
 
 # let's add the constraint during the table creation  time here.
create table orders(order_id int check (order_id >0), order_item_id int, customer_id int, 
order_status varchar(20) check  (order_status in ( 'CLOSED', 'COMPLETE', 'PROCESSED', 'PENDING' )),
product_id int, quantity int,product_price float);
 
# entered invalid id which is viollation of constraint 1 
insert into orders values(-1,2,3,"COMPLETE",3,2,100);  # Error Code: 3819. Check constraint 'orders_chk_1' is violated.
# entered invalid order_status which is viollation of constraint 2 
insert into orders values(1,2,3,"COMP",3,2,100);  # Error Code: 3819. Check constraint 'orders_chk_2' is violated.

 # let's add one more constraint that  quantity cannot be more than 50 here
 
 alter table orders add check (quantity <50);
 
insert into orders values(10,2,3,"COMPLETE",52,76,100); # Error Code: 3819. Check constraint 'orders_chk_3' is violated

# we can also write constraint at the end here

create table peoples(age int,fname varchar(10),lname varchar(10), check (age>0)); # no error 
drop table peoples;

create table peoples(age int,fname varchar(10),lname varchar(10), email varchar(30) check (email like "%@gmail.%")); # no error 

insert into peoples values(1,"Indra","sena","mahismathi"); # error as email pattern is not matching here 

insert into peoples values(1,"Indra","sena","mahismathi@gmail.com"); #  no error as email pattern is  matching here 

# we can add the constraint to check the 2 columns here 
# we know that end date > start date of any proj

create table project( start_date date, end_date date,check(end_date>start_date));
insert into project values("2026-04-22","2026-04-25"); # no error
insert into project values("2026-04-22","2026-04-5"); #  error  arises here 
















