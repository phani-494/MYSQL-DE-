show databases;

use company_db;
show tables;
select * from employee; # in the dept column we have differnt departments which are repeated
# but we want the dept which are present uniquely. we want to know what kind of dept are present

select (dept) from employee;
/*
Loan
Cash
Loan
Account
Deposit
*/

select distinct(dept) from employee; # we got loan only once here 
/*
dept 
Loan
Cash
Account
Deposit
*/
# we got the unique values here by using distinct
# to find the different unique cities this will be helpful

select distinct fname,lname from employee;
/*
Raju	Rastogi
Sham	Mohan
Baburao	Apte
Paul	Philip
Alex	Watt

*/

# order by is used for sorting 

select * from employee;
/*
101	Raju	Rastogi	Manager	Loan
102	Sham	Mohan	Cashier	Cash
103	Baburao	Apte	Associate	Loan
104	Paul	Philip	Accountant	Account
105	Alex	Watt	Associate	Deposit
*/


select * from employee order by fname; # gives result in ascending order of fname
/*
105	Alex	Watt	Associate	Deposit
103	Baburao	Apte	Associate	Loan
104	Paul	Philip	Accountant	Account
101	Raju	Rastogi	Manager	Loan
102	Sham	Mohan	Cashier	Cash

*/

select * from employee order by fname desc; # gives result in descending order of fname
/*

102	Sham	Mohan	Cashier	Cash
101	Raju	Rastogi	Manager	Loan
104	Paul	Philip	Accountant	Account
103	Baburao	Apte	Associate	Loan
105	Alex	Watt	Associate	Deposit

*/

# we can sort by based on the position of the column
# here we are sorting on the desig which is in 4 th position

select * from employee order by 4; 

/*
104	Paul	Philip	Accountant	Account
103	Baburao	Apte	Associate	Loan
105	Alex	Watt	Associate	Deposit
102	Sham	Mohan	Cashier	Cash
101	Raju	Rastogi	Manager	Loan
*/

# we can perform sorting on the multiple columns also 
select * from employee order by desig ,dept;

/*
104	Paul	Philip	Accountant	Account
105	Alex	Watt	Associate	Deposit
103	Baburao	Apte	Associate	Loan
102	Sham	Mohan	Cashier	Cash
101	Raju	Rastogi	Manager	Loan
*/


# like 
# used for filtering when u know something about the data 
# wherever Man is present(even as a substring) there it gives the result 
# % indicates any no of characters here 
select * from employee where desig like "%Man%"; # 101	Raju	Rastogi	Manager	Loan
select * from employee where desig like "%man%"; # 101	Raju	Rastogi	Manager	Loan - same result as above

# if my data have a word like this , then give that result ;
# here upper case and lower case doesn't matters as 'like' performs case insensitive operations

# suppose we want the fname where there is only 4 characters long only

select * from employee where fname like "____"; # here 4 underscores are given  

/*
101	Raju	Rastogi	Manager	Loan
102	Sham	Mohan	Cashier	Cash
104	Paul	Philip	Accountant	Account
105	Alex	Watt	Associate	Deposit
*/

# suppose we want the fname which starts with R then;

select * from employee where fname like "R%"; # gives result which starts with R  -->  101	Raju	Rastogi	Manager	Loan
select * from employee where fname like "S___"; # 102	Sham	Mohan	Cashier	Cash--> which starts with S and next 3 characters should be there

# suppose we want the fname which ends  with m then;
select * from employee where fname like "%m"; # 102	Sham	Mohan	Cashier	Cash --> gives result which end with m here..

# we can perform on integers also 
# emp_id which have 04 in it will be the result .
select * from employee where emp_id like "%04%"; # 104	Paul	Philip	Accountant	Account















