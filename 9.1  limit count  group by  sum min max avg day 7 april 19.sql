-- Create Database
CREATE DATABASE company_db1;
USE company_db1;

-- Create Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    fname VARCHAR(30),
    lname VARCHAR(30),
    desig VARCHAR(30),
    dept VARCHAR(30),
    salary INT
);

-- Insert Data
INSERT INTO employees VALUES
(101, 'Raju', 'Rastogi', 'Manager', 'Loan', 37000),
(102, 'Sham', 'Mohan', 'Cashier', 'Cash', 32000),
(103, 'Baburao', 'Apte', 'Associate', 'Loan', 25000),
(104, 'Paul', 'Philip', 'Accountant', 'Account', 45000),
(105, 'Alex', 'Watt', 'Associate', 'Deposit', 35000),
(106, 'Rick', 'Watt', 'Manager', 'Account', 65000),
(107, 'Leena', 'Jhonson', 'Lead', 'Cash', 25000),
(108, 'John', 'Paul', 'Manager', 'IT', 75000),
(109, 'Alex', 'Watt', 'Probation', 'Loan', 40000);

-- Display Table
SELECT * FROM employees;
/*
101	Raju	Rastogi	Manager	Loan	37000
102	Sham	Mohan	Cashier	Cash	32000
103	Baburao	Apte	Associate	Loan	25000
104	Paul	Philip	Accountant	Account	45000
105	Alex	Watt	Associate	Deposit	35000
106	Rick	Watt	Manager	Account	65000
107	Leena	Jhonson	Lead	Cash	25000
108	John	Paul	Manager	IT	75000
109	Alex	Watt	Probation	Loan	40000

*/

select * from employees limit 5;
/*
101	Raju	Rastogi	Manager	Loan	37000
102	Sham	Mohan	Cashier	Cash	32000
103	Baburao	Apte	Associate	Loan	25000
104	Paul	Philip	Accountant	Account	45000
105	Alex	Watt	Associate	Deposit	35000
*/

select * from employees order by salary  limit 5; # top 5 salaries in ascending order
/*
103	Baburao	Apte	Associate	Loan	25000
107	Leena	Jhonson	Lead	Cash	25000
102	Sham	Mohan	Cashier	Cash	32000
105	Alex	Watt	Associate	Deposit	35000
101	Raju	Rastogi	Manager	Loan	37000
*/

select * from employees order by salary desc limit 5; # # top 5 salaries in descending order

/*
108	John	Paul	Manager	IT	75000
106	Rick	Watt	Manager	Account	65000
104	Paul	Philip	Accountant	Account	45000
109	Alex	Watt	Probation	Loan	40000
101	Raju	Rastogi	Manager	Loan	37000
*/

# we can also get some range of records from certain rows here
select * from employees  limit 5,3; # after 5th record give me 3 records 
/*
106	Rick	Watt	Manager	Account	65000
107	Leena	Jhonson	Lead	Cash	25000
108	John	Paul	Manager	IT	75000
*/

# count

# gives total no of records in the table 
select count(*) from employees; #9 

select count(*) from employees where  desig="Manager"; # total 3 managers are there 
select count(emp_id) from employees where  desig="Manager"; # total 3 managers are there 

select  distinct desig from employees ;
/*
Manager
Cashier
Associate
Accountant
Lead
Probation
*/


select count( distinct desig) from employees ; # total 6 designations are present 

select count( distinct  dept) from employees; # total 5  distinct dept are present




select count(fname) from employees; #9


# groupby
# when we observe the dept and desig then we can clealry see that there are different groups present such as
# loans cash account IT Deposit ..
# we can group them and perform different operations here ....


select dept from employees group by dept;

/*
It shows unique department names from the employees table.

It groups all same departments together and returns one row per department.

*/

/*
Loan
Cash
Account
Deposit
IT
*/

# we need to find how many people are present in every dept 
select dept, count(fname) from employees group by dept;

/*
Loan	3
Cash	2
Account	2
Deposit	1
IT	1
*/


select desig from employees group by desig;

/*
Manager
Cashier
Associate
Accountant
Lead
Probation
*/





select desig, count(emp_id) from employees group by desig;

/*
Manager	3
Cashier	1
Associate	2
Accountant	1
Lead	1
Probation	1

*/


# min and max 

select max(salary) from employees; # 75000

select  max(salary) from employees; # 75000

select min(salary) from employees; # 25000

select dept, max(salary) from employees group by dept;

/*
Loan	40000
Cash	32000
Account	65000
Deposit	35000
IT	75000
*/

select fname,salary from employees where salary=(select max(salary) from employees); # John	75000


# sum and avg

select sum(salary) from employees; # 379000

select avg(salary) from employees; # 42111

select  dept,sum(salary) from employees group by dept;
/*
Loan	102000
Cash	57000
Account	110000
Deposit	35000
IT	75000

*/






select  desig,avg(salary) from employees group by desig;
/*
Manager	59000.0000
Cashier	32000.0000
Associate	30000.0000
Accountant	45000.0000
Lead	25000.0000
Probation	40000.0000

*/


select  dept,count(emp_id),sum(salary) from employees group by dept;

/*
Loan	3	102000
Cash	2	57000
Account	2	110000
Deposit	1	35000
IT	1	75000
*/







