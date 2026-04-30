show databases;
use retail_db2;
show tables;


-- gives the total no of records in employees table
select count(*) from employees; # total 30 are present 

-- count the total no of developers 
select count(*) from employees where job_title="Developer"; # 2

select * from employees;

select "INDIA" from employees where department_id=101; # it gives INDIA name in all columns where it matches

select count("INDIA") from employees where department_id=101; # 7
-- since total 7 rows INDIA is the result of above , so count is 7

/*
How MySQL Thinks
Filter rows where department_id = 101
For each matching row → print "INDIA"

🔁 Equivalent Thinking

For each employee in department 101:
    print "INDIA"
    */
    

SELECT first_name, "INDIA" AS country FROM employees;
# here "INDIA" is a constant value and for every row it will be displayed
/* here we displayed some records for understanding purpose 
first_name, country
John	INDIA
Emma	INDIA
Michael	INDIA
Sophia	INDIA
Daniel	INDIA
Olivia	INDIA
su	INDIA
*/


/*
Summary
name → actual column
'INDIA' → constant value
AS country → column alias

👉 Result = original data + new fixed column
*/

/*
| Query            | What it Counts                |
| ---------------- | ----------------------------- |
| `COUNT(*)`       | All rows                      |
| `COUNT(1)`       | All rows                      |
| `COUNT('INDIA')` | All rows (constant, non-null) |
| `COUNT(column)`  | Only non-null values          |
*/

-- when we give the column name then it counts only non-null values 
select count(manager_id) from employees; # 27 total non null values will be the result here 


select 1  as ID from employees where department_id=104;  #  6 times 1 will be displayed
/*
ID 
1
1
1
1
1
1
*/

select count(1)  as ID from employees where department_id=104;  # 6 

-- get salaries of employees whose salary > 40000
select count(*) from employees where salary>40000; # 22 

-- get the  count of employees who have manager
select count(manager_id) from employees; # 27 ; counts total non null values here in manager_id column 

-- get the count of employees who are not managers and whose salary > 50000
select count(manager_id) from employees where salary> 50000;  # 7

# order by
-- give list of employees with their salaries in ascending order 
select * from employees order by salary ; # gives in ascending order which is default 

/* here we have shown only some values 
14	Amelia	Garcia	101	37000.00
28	Lily	Green	101	37500.00
8	Ava	Thomas	101	38000.00
24	Grace	Young	101	38500.00
4	Sophia	Davis	101	39000.00
11	Benjamin	Harris	105	39000.00
20	Ella	Lee	101	39500.00

*/

select * from employees order by salary  desc;
/*
25	Joseph	King	104	61000.00
5	Daniel	Wilson	104	60000.00
30	Zoey	Adams	104	59000.00
15	Henry	Martinez	104	58000.00
*/

-- get top 5 salaries

select salary from employees order by salary  desc limit 5 ;
/*
61000.00
60000.00
59000.00
58000.00
56000.00
*/

-- gives the names of top 5 salary earners
-- V.IMP note: it is not necessary to have the order by column as the  part of the select 
-- it is mandatory only in group by 
select first_name from employees order by salary  desc limit 5 ;
/*
Joseph
Daniel
Zoey
Henry
Sebastian
*/

-- here two levels of sorting is performed 
select * from employees order by salary desc , department_id  ; # dept id will be in ascending order here

/*
25	Joseph	King	104	61000.00
5	Daniel	Wilson	104	60000.00
30	Zoey	Adams	104	59000.00
15	Henry	Martinez	104	58000.00
19	Sebastian	Lewis	104	56000.00
1	John	Smith	101	55000.00
27	Matthew	Scott	103	53000.00
9	William	Jackson	104	52000.00
17	Alexander	Clark	103	51000.00
21	Jack	Walker	103	50000.00
13	Lucas	Thompson	103	49000.00
7	su	Anderson	103	47000.00
26	Chloe	Wright	102	46000.00
3	Michael	Brown	103	46000.00
*/


-- add 10% increment to the salary column
-- select * FROM EMPLOYEES;
-- the column will present in the last 
select *, salary+(.1*salary) as inc_salary from employees ;
/*
1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager	60500.000
2	Emma	Johnson	102	42000.00	2023-02-10	1	emma.j@email.com	9876543211	Analyst	46200.000
3	Michael	Brown	103	46000.00	2023-03-05	1	michael.b@email.com	9876543212	Developer	50600.000
4	Sophia	Davis	101	39000.00	2023-04-12	1	sophia.d@email.com	9876543213	HR Executive	42900.000
*/


-- we can order by based on an derived column also 
select *, salary+(.1*salary) as inc_salary from employees  order by inc_salary desc limit 4 ;
/*
25	Joseph	King	104	61000.00	2024-05-05	5	joseph.k@email.com	9876543234	Finance Manager	67100.000
5	Daniel	Wilson	104	60000.00	2023-05-20		daniel.w@email.com	9876543214	Director	66000.000
30	Zoey	Adams	104	59000.00	2024-07-15	5	zoey.a@email.com	9876543239	Accounts Lead	64900.000
15	Henry	Martinez	104	58000.00	2023-11-20	5	henry.m@email.com	9876543224	Accountant	63800.000
*/
















