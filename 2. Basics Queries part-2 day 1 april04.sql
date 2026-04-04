# List all existing databases 

SHOW DATABASES;

# USE is a command to select a database so you can work inside it.
# connect to this DB
USE retail_db;

select database(); # shows the current database 

show tables; # gives list of tables in the retail_db

use world; # now the database is changed here 

# to delete a database 

DROP DATABASE world;

show databases;
use retail_db;
# create a table 
create table Student_Details(Name Varchar(10),age int, Fees int);

# Describes about the table here (shows the structure of the table)
desc Student_Details;


# when u give values in same sequence , then no need to give column names while inserting


insert  into Student_Details values('Indra',28,50000);
insert  into Student_Details values('Mahesh',26,60000);

DESCRIBE Student_Details;

SHOW COLUMNS FROM Student_Details;


# To View Actual Data

# If you meant “details” as data inside table:
# read data from a table 
SELECT * FROM Student_Details; # gives the table
# if u want to enter only age (a particular column);
insert  into Student_Details(age) values(29); # remaining values are Null

SELECT * FROM Student_Details; # gives the entire columns of  table

select age from Student_Details;

