show databases;
select database();
use retail_db;
select database();
show tables;
describe orders;

# let;s create a new table Sales;

create table Sales(prod_id int, prod_name varchar(20),prod_price int, prod_manuf datetime);

insert  into Sales values(1,'Chain',200,'2026-04-04');
# internally string also can be converted into int
# observe here int datatype columns are given as string. str to int typecasting is done internally
'300'---> 300 is possible here 
insert  into Sales values('2','Chain','300','2026-04-04');

# the value inside the str should be int only - not the mixed datatypes 
# Gives error as this str datatype cannot be converted into int ('300A' cannot be converted into int)
insert  into Sales values('2','Chain','300A','2026-04-04');
insert  into Sales values('2','Chain','Arjun','2026-04-04'); # gives error as Arjun cannot be converted into int 

# For the datetime , the format should be exact as YY-MM-DD (wrapped in  ' ') else it gives error
# the data will not be inserted 

insert  into Sales values('2','Chain','300','20-04-2026');  # incorrect date time value

# varchar datatype can take even single integer values also here

insert  into Sales values('2',25,1300,'2026-04-04');

select * from Sales;


drop table Sales ;
show tables;

describe orders;
/* # Multi line comment in sql 
order_id	int
customer_id	int
order_status	varchar(15)
date	datetime
*/
# the order should be of 15 characters but we are trying to insert more than 15 characters long .so it gives error here 
insert into orders values(25,34,'Pending_incomplete_status',2026-09-05);
insert into orders values(25,34,'done_status',2026-09-05); # for date u should mention it as string 
# else it will treat it as minus sign as gives error as '2012' which is 2026-14=2012 

# we can insert records at a time using comma 

insert into orders values(25,34,'Done','2026-09-05'),(125,33,'incomplete','2026-09-05');
select * from orders;


# let's deal with float datatype here 

create table Products(id int,price float ,quan int);
insert into Products values(1,234.456,3),(2,238.98765,12);
select * from Products; # output is shown below .  the float values are truncated or rounding off to  3 decimal places only 
/*
1	234.456	3
2	238.988	12 # see hee
*/


/*
DECIMAL(p, s)
Where:
p (precision) → total number of digits
s (scale) → digits after decimal point

*/
# decimal(20,8) datatype
# by using this we can store total 20 digits 8 places for decimal values 
# we want all values of decimal to be printed.

drop table Products;

# let's recreate it and use the decimal datatype here

create table Products(id int,price decimal(14,26) ,quan int); # gives error as first value should be greater there 


create table Products(id int,price decimal(14,6) ,quan int); # this works fine here 

 #                                 here it stores extra 3 zeros        # here it will be truncated to 6 places only 
insert into Products values(1,234.456,3),(2,238.98765456,12),(4,221.44565456,19);
 select * from Products; # gives result as this
/* 
234.456000	3
238.987655	12
221.445655	19

*/

use information_schema;
# in this database there is no table of orders and orders table is in retail_db
select * from orders; # gives error as this current  database doesn't have orders.


# if u want to definitely use it means then give database_name.table
# whatever database it may be connected, it always works fine here 
select * from retail_db.orders; # now it gives proper result 
use retail_db;


# there is a case where some values were optional among the columns and we need to insert only some specific columns only
# in that case, we need to mention the column names specifically and Null Values will be filled there 
# now() gives the current date and time 
# we can pass in any order but the key-value pair should match 
insert into orders(order_id,date) values(670,  now());


# when column names are too big at that time, we can use alias names as shown below

select customer_id as cid from orders;
/*
cid
600
601
601
34
33

*/


show tables;

# on left side  , right click on database . there we can see data import wizard.
# from there we can data import from that file to the table 
# we downloaded a csv sheet named as customers and it has 1000 records 
select count(*) from customers; # gives 1000

# when u want to see limited no of records then we can use the limit 
select * from customers limit 5;

select * from customers order by Country;

select * from customers order by Country desc;

# table structure remains same but data will be removed

delete  from orders  ; # in safe mode it is not possible to delete the records 

# Turn off safe mode close and then restart the entire work bench 