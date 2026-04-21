show databases;
use retail_db;
show tables;
select * from customers limit 10;
desc customers;


# suppose if u want to give permission to someone who wants to (use) acesss this table.
# here we want to  give access to only some columns and don't want to share the personal information columns(restricted access to other user)
# and only (select) read operation can be done by the other user not any updations and deletions
# when we want to give some restricted access then we can use view here 
# when column names have spaces in it , then use the single Quotes or double quotes while using select 
create view customers_view as 
select `Customer Id`,`First Name`,`Last Name`,Company,City from customers ; # Now the view is successful here and gives 10 columns here 

# very imp point is when columns names  have spaces in it , then we must need to use ` ` which is backticks present under escape 

# view acts as like a wrapper here simply holding the select statement(here is 12th line)

select *  from customers_view limit 5;


# gives result as like this  
/*

dE014d010c7ab0c	Andrew	Goodman	Stewart-Flynn	Rowlandberg
2B54172c8b65eC3	Alvin	Lane	Terry, Proctor and Lawrence	Bethside
d794Dd48988d2ac	Jenna	Harding	Bailey Group	Moniquemouth
3b3Aa4aCc68f3Be	Fernando	Ford	Moss-Maxwell	Leeborough
D60df62ad2ae41E	Kara	Woods	Mccarthy-Kelley	Port Jacksonland

*/

 # we are creating an user (Propio1) here with some password
 # since we are using in local host so we mentioned local host else it will be some ip address 
 
create USER 'Propio1'@'localhost' identified by 'INDRA123';

# we are granting permission to use select operation on the customers_view table to the created user  
 
grant select on retail_db.cutomers_view to  'Propio1'@'localhost' ;


# now we have created this particular user and to  login we should give as 

# mysql -u username -p   in gitbash or terminal
# once login as a new user , he cannot all the databases as like in root user
# because he didn't have the permission to access  all  databases 

# now the new user gives these commands:
# show databases;
# use retail_db;
# show tables;
# select * from customers_view 

# the above particular user can now be able to view the coustomers_view and only read operation has permission here 
# now the new user can access the table by writing as select * from customers_view 
# user must logn with his credentials and then  use this view 

# now we remove the given permission here 
revoke select  on retail_db.cutomers_view from  'Propio1'@'localhost';
# from that particular user, we are revoking the access.
# now if we try to use select * from customers_view, then it gives error as select command denied to user 
# if we use this command ;  drop table customers_view then we get error as drop command denied to user as we haven't given permission to use drop 

# we are granting all these 3 permissions now 
grant select,delete,drop on retail_db.cutomers_view to  'Propio1'@'localhost' ;
# now we have login into the user profile 
#there we given these commands simply 
# now drop can work fine here

# delete from customers_view where City=Tonyville
drop view customers_view ;

# we can revoke drop  as
# revoke drop on retail_db.cutomers_view from  'Propio1'@'localhost';

select * from customers_view; # gives error as Table 'retail_db.customers_view' doesn't exist.

# Database Admins generally creates users and gives the permissions here 

# how to delete a user

drop user 'Propio1'@'localhost';

 
show tables; # we can see different tables but how to find which are views in these tables...

# we have database named information_schema which is just like system catalog 
# it will hold what tables are present what are their column names, ..all meta data is present in this

use information_schema;
show tables; # there are lot of tables present here and specially a "TABLES" named table is present
# it contains all tables information

/*
TABLE_CONSTRAINTS_EXTENSIONS
TABLE_PRIVILEGES
TABLES
TABLES_EXTENSIONS
TABLESPACES_EXTENSIONS
*/




select *  FROM TABLES; # lot of tables data is shown here
select *  FROM TABLES where table_schema="retail_db"; 

/*
TABLE_SCHEMA  TABLE_NAME  TABLE_TYPE   # Here we can observe the table types clearly
retail_db	accounts	BASE TABLE
retail_db	customers	BASE TABLE
retail_db	customers_2	BASE TABLE
retail_db	customers_view	VIEW
retail_db	cutomers_view	VIEW
*/

# we can also check about the columns here  in columns table
select *  FROM columns where table_schema="retail_db"; 
/*
retail_db	accounts	id
retail_db	accounts	Aadhar
retail_db	accounts	Type
retail_db	customers	Index
retail_db	customers	Customer Id
retail_db	customers	First Name
retail_db	customers	Last Name
retail_db	customers	Company

*/

# let us learn about TCL commands
use retail_db1;
show tables;

select * from customers;
/*
1	dE014d010c7ab0c	Andrew	Goodman	Stewart-Flynn	Rowlandberg	Macao	846-790-4623x4715	(422)787-2331x71127
2	2B54172c8b65eC3	Alvin	Lane	Terry, Proctor and Lawrence	Bethside	Papua New Guinea	124-597-8652x05682	321.441.0588x6218
3	d794Dd48988d2ac	Jenna	Harding	Bailey Group	Moniquemouth	China	(335)987-3085x3780	001-680-204-8312
4	3b3Aa4aCc68f3Be	Fernando	Ford	Moss-Maxwell	Leeborough	Macao	(047)752-3122	048.779.5035x9122
*/

# let's delete the customer whose index =100

delete from customers where `Index`=100; # INDEX is a special keyword. so use backticks when using with  delete

# let's say by mistake we deleted some other record instead of original one

# to get back to previous state ,we use commit or rollback

# if we perform any DML operation then your transaction (like DML operations ..updating, inserting a record, purchasing an order,...) is in open state 
# whenever u perform a DML operation, it is like a transaction .alter
# transaction can be saved permanently into the database or it can be rollback 
# here we are not saving it and we are going back to previous state.

# before we save or undo the transaction, the transaction  will be in open state 

# here open state means it can be floating around and it can be saved fully or it can be avoided fully.

-- saved using commit
-- discarded using rollback

# whenever it is in open state , then only we can commit or rollback.
# once if committed means we cannot rollback here

# before limit tab ,we have small dot  symbol which shows autocommit mode here
select * from customers;

delete from customers where `Index`=102;
# after delete , now we do rollback
rollback; # even though it shows success here but 102 id is not   present as autocommit is enabled here
# every time any operation is done,it is committed.

# we turned off auto commit here
 
 
 delete from customers where `Index`=105;
# after delete , now we do rollback
rollback;
 # this record is present now in customers table as autocommit mode is off 
 
 
 delete from customers where `Index`=5;
 commit; # we committed here . so permanently got deleted here
 
rollback; # still 5 will not present 


-- commit ; save permanently
-- rollback: discard permanently

-- suppose u deleted all data from employees, then u can quickly rollback here

delete  from customers; # all rows deleted
# now the transaction is in open state. we can either commit or rollback 
rollback; # now we get our data back 

drop table customers; # this is not DML command . it is DDL command we cannot do anything once it is dropped even we use rollback also
# defintions are autocommit 

select * from customers;

	
    
