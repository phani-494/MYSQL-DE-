# Gives all the data bases present in it 
show databases;

# how to create database 

create database retail_DB;

show databases;

# before creating tables in database, we need to connect to the database

select database(); # Shows null as we havem't connected to any database

# to connect to a database ,we need to use this 
use retail_DB;  # now it connected to this database 

select database(); # now it shows result as retail_DB. we can create tables inside it now 

# create a customer table in it
#orders is name of the table

CREATE TABLE orders(order_id,customer_id,order_status); # gives error here as datatypes not given
# this works fine
CREATE TABLE orders(order_id int,customer_id int,order_status varchar(15),date datetime);

show tables; # gives tables in the current database 

# suppose if u want to find the tables in the world database first we need to connect to it and then apply show tables

show databases;
use  world; # we connected to it
show tables; # gives tables in this world database 


use retail_DB;

# create customers table

CREATE TABLE Customers(name varchar(20),address varchar(26), pincode varchar(10))

select * from orders; # shows the table and columns (full table)

# to insert the data

INSERT INTO orders VALUES(123,600,'COMPLETED','2025-4-1');

INSERT INTO orders VALUES(124,601,'NOT COMPLETED','2025-4-2');

select * from orders;