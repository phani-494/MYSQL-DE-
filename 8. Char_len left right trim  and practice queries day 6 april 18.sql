show databases;
use retail_db;
show tables;
select * from customers;


# char_length

select char_length("INDRASENA"); # 9

select char_length("INDRASENA reddy ") as Length; # 16

select `First Name`, char_length(`First Name`) as Length from customers limit 10;

/*
Andrew	6
Alvin	5
Jenna	5
Fernando	8
Kara	4
Marissa	7
Julie	5
Lauren	6
Emily	5
Marie	5


*/

# filter the names where len of name is more than 7 

# gives first 6 rows whose first name length is > 8
select * from customers where char_length(`First Name`)>8 limit 6;

/*
42	6fF3de1DDbeAaE9	Christina	Bautista	Lane Ltd	Lake Don	Turks and Caicos Islands	(964)671-6776	724-324-0841x953
43	bcE2C6eaAa1d53c	Alexandra	Castro	Wall, Clay and Mcintosh	South Lynnton	Swaziland	+1-469-312-3108x01224	(295)194-3972x6683
46	37a20bF88deF55D	Stephanie	Bradshaw	Tanner LLC	East Paulaville	American Samoa	+1-934-296-1820x843	(364)992-5769x31100
139	E31833D3D9DbCDD	Christopher	Savage	Armstrong-Contreras	Port Isabellachester	Iran	+1-312-445-7245x1043	001-461-762-8727x782
140	4032A3C28aaC8c5	Dominique	Mckinney	Sharp, Fleming and Gregory	Port Erin	Kazakhstan	(641)697-2728x62920	001-151-172-1644x17265
147	85Cdd16ADD6dCa5	Gwendolyn	Bradshaw	Gay, Bush and Goodman	East Jonathan	Mali	358.010.6852	(984)148-8789x56784

*/



# insert

select insert("Indra sena", 6,0, "Hi sir"); # gives result as IndraHi sir sena

select insert("Indra sena", 6,2, "Hi sir");  # IndraHi sirena

/*
INSERT("Indra sena", 6, 2, "Hi sir")
Original text = "Indra sena"
Start at position = 6
Remove 2 characters
Insert "Hi sir"
*/

select left("Mahasena",3); # first 3 characters will be selected 
select right("Phanindra",5); # last 5 characters will be selected 


select repeat("TQ",5); # TQTQTQTQTQ;
select repeat("TQ ",5); # TQ TQ TQ TQ TQ 

select trim("       Indrasena      "); #  removes the  whitespaces present at the start and the end 

# Practice Queries



-- Create Database
CREATE DATABASE company_db;

-- Use Database
USE company_db;

-- Create Employee Table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    fname VARCHAR(30),
    lname VARCHAR(30),
    desig VARCHAR(30),
    dept VARCHAR(30)
);

-- Insert Records
INSERT INTO employee (emp_id, fname, lname, desig, dept) VALUES
(101, 'Raju', 'Rastogi', 'Manager', 'Loan'),
(102, 'Sham', 'Mohan', 'Cashier', 'Cash'),
(103, 'Baburao', 'Apte', 'Associate', 'Loan'),
(104, 'Paul', 'Philip', 'Accountant', 'Account'),
(105, 'Alex', 'Watt', 'Associate', 'Deposit');

-- Display Table
SELECT * FROM employee;


# Task 1: print as 101:Raju:Manager:Loan


select concat_ws(":",emp_id,fname,desig,dept) from employee ;  
/*
101:Raju:Manager:Loan
102:Sham:Cashier:Cash
103:Baburao:Associate:Loan
104:Paul:Accountant:Account
105:Alex:Associate:Deposit
*/





# we are performing concatenation here with a separator

select concat_ws(":",emp_id,fname,desig,dept) from employee where emp_id=101;  # 101:Raju:Manager:Loan


# Task 2 : 101:Raju Rastogi:Manager:Loan
# for this we need to perform concat here simply 
select concat_ws(":",emp_id,concat(fname," ",lname) ,desig,dept) from employee where emp_id=101;  # 101:Raju Rastogi:Manager:Loan

select concat_ws(":",emp_id,concat(fname," ",lname) ,upper(desig),dept) from employee where emp_id=101;  # 101:Raju Rastogi:MANAGER:Loan


# Task 4 
/*
print as 

L101 Raju
C102 Sham 

*/

select concat(left(dept,1),emp_id),fname  from employee;

/*
L101	Raju
C102	Sham
L103	Baburao
A104	Paul
D105	Alex

*/


