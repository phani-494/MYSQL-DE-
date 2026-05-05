-- let's see some other functions which are more useful to us

-- case 

use retail_db2;
show tables;

select * from employees;

-- here we have salary column . add extra column such that 
/* when salary<45000 then 'LOW'
   when salary between 45000 and 55000 then "Medium"
   else "HIGH"
*/
select * ,
CASE
   when salary<45000 then 'LOW'
   when salary between 45000 and 55000 then "Medium"
   else "HIGH" # if no above criteria matches this will takes place -- if else not given then null takes place when condition is not met 
END  as Salary_Type
 from employees;
 
 
 /*
 employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, email, phone_number, job_title, Salary_Type
 1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager	Medium
2	Emma	Johnson	102	42000.00	2023-02-10	1	emma.j@email.com	9876543211	Analyst	LOW
3	Michael	Brown	103	46000.00	2023-03-05	1	michael.b@email.com	9876543212	Developer	Medium
4	Sophia	Davis	101	39000.00	2023-04-12	1	sophia.d@email.com	9876543213	HR Executive	LOW

*/


-- when none of the criteria is matched, then null will takes place.
-- the conditions will takes priority from the first itself only..

select *,
case 
  when salary<45000 then "HIGH" -- shows everything high when this condition itself satisfies - this has first priority
  # when the first condition matches then it go to second condition
  when salary<35000 then "HIGH"
when salary<20000 then "HIGH"
end as salry_type 
 from employees;
 /*
employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, email, phone_number, job_title, salry_type
1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager	
2	Emma	Johnson	102	42000.00	2023-02-10	1	emma.j@email.com	9876543211	Analyst	HIGH
3	Michael	Brown	103	46000.00	2023-03-05	1	michael.b@email.com	9876543212	Developer null	
4	Sophia	Davis	101	39000.00	2023-04-12	1	sophia.d@email.com	9876543213	HR Executive	HIGH
5	Daniel	Wilson	104	60000.00	2023-05-20		daniel.w@email.com	9876543214	Director	null

*/

-- let's give else here :

select *,
case 
  when salary<45000 then "HIGH" -- shows everything high when this condition itself satisfies - this has first priority
  # when the first condition matches then it  won't go to second condition
  when salary<35000 then "HIGH"
when salary<20000 then "HIGH"
else "Cannot say"
end as salry_type 
 from employees;

/*

1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager	Cannot say
2	Emma	Johnson	102	42000.00	2023-02-10	1	emma.j@email.com	9876543211	Analyst	HIGH
3	Michael	Brown	103	46000.00	2023-03-05	1	michael.b@email.com	9876543212	Developer	Cannot say
4	Sophia	Davis	101	39000.00	2023-04-12	1	sophia.d@email.com	9876543213	HR Executive	HIGH
5	Daniel	Wilson	104	60000.00	2023-05-20		daniel.w@email.com	9876543214	Director	Cannot say

*/


-- when the conditions are given properly , then it will work fine here


select *,
case 
  when salary<20000 then "Low" 
 
  when salary<50000 then "Medium"
when salary<80000 then "HIGH"
else "Cannot say"
end as salry_type 
 from employees;

/*
1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager	HIGH
2	Emma	Johnson	102	42000.00	2023-02-10	1	emma.j@email.com	9876543211	Analyst	Medium
3	Michael	Brown	103	46000.00	2023-03-05	1	michael.b@email.com	9876543212	Developer	Medium
4	Sophia	Davis	101	39000.00	2023-04-12	1	sophia.d@email.com	9876543213	HR Executive	Medium
5	Daniel	Wilson	104	60000.00	2023-05-20		daniel.w@email.com	9876543214	Director	HIGH
6	Olivia	Taylor	102	43000.00	2023-06-18	2	olivia.t@email.com	9876543215	Analyst	Medium
7	su	Anderson	103	47000.00	2023-07-01	3	phani&%@gmail.com	9876543216	Developer	Medium
8	Ava	Thomas	101	38000.00	2023-07-15	1	ava.t@email.com	9876543217	Recruiter	Medium
9	William	Jackson	104	52000.00	2023-08-10	5	william.j@email.com	9876543218	Finance Analyst	HIGH
10	Mia	White	105	41000.00	2023-09-05		mia.w@email.com	9876543219	Team Lead	Medium
*/


-- cast: casting from one datatype to another datatype  (if and only if they are compatible)

show create table employees;


-- let's create a table here with some changes in the datatype here  hiredate and salary changed to the varchar type here

CREATE TABLE `employees_new` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `department_id` int DEFAULT NULL,
  `salary` varchar(30) DEFAULT NULL,
  `hire_date` varchar(30) DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ;

-- data in the employees table will be inserted into the employees_new table
 
 insert into employees_new  select * from employees;
 
 
 desc employees_new ;
 
 /*
Field, Type, Null,
 employee_id	int	NO
first_name	varchar(50)	NO
last_name	varchar(50)	NO
department_id	int	YES
salary	varchar(30)	YES   # observe here : both are varchar 
hire_date	varchar(30)	YES # it is a string here 
manager_id	int	YES
email	varchar(100)	YES
phone_number	varchar(20)	YES
job_title	varchar(50)	YES
*/

 
 -- we need to change their datatypes again 
 
 select year(hire_date) from employees_new; # this works here 
 
 /* What happens internally
YEAR() expects a DATE/DATETIME
If hire_date is VARCHAR, MySQL will try implicit conversion
If the string looks like a valid date → it works ✅
*/

 select cast(hire_date as datetime) from employees_new;
 /*
 2023-01-15 00:00:00
2023-02-10 00:00:00
2023-03-05 00:00:00
2023-04-12 00:00:00
2023-05-20 00:00:00
2023-06-18 00:00:00
*/

-- we can perform timedate function by using cast on varchar  
 
  select month(cast(hire_date as datetime)) from employees_new;
 /*
 1
2
3
4
5
6
*/

select cast( salary as decimal(10,2) )* 1.1  as renewed_salary from employees_new;

/*
renewed_salary
60500.000
46200.000
50600.000
42900.000
66000.000
47300.000

*/



-- coalesce : It returns the first non-NULL value from the list.
-- a very useful function when u want to handle the null values 

SELECT COALESCE(NULL, NULL, 10, 20); # 10

CREATE TABLE products (
    product_name VARCHAR(50),
    discount_price DECIMAL(10, 2),
    regular_price DECIMAL(10, 2)
);

INSERT INTO products (product_name, discount_price, regular_price) VALUES
('Laptop', NULL, 1200.00),
('Smartphone', 800.00, 1000.00),
('Tablet', NULL, 300.00);

-- here we want the best price to be shown which is discount_price
-- suppose if the discount_price is null, then it will go for the regular_price which is given here 

select product_name, coalesce(discount_price,regular_price)  as best_price from products;


/*
product_name, best_price
product_name, best_price
Laptop	1200.00
Smartphone	800.00
Tablet	300.00

*/

-- if the discount price is null  then take 1000 

SELECT COALESCE(discount_price, 1000)+coalesce(regular_price,200) as total_price FROM products;
/*
2200.00
1800.00
1300.00
*/


/*
SELECT COALESCE(salary, 0) FROM employees;
👉 If salary is NULL, it returns 0
*/



