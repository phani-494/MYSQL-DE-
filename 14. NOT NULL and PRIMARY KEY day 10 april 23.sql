# NOT NULL and Primary key constraint 

-- when u want some of the data to be mandatory and no null values are allowed into them,in that case NOT NULL constraint is used 

use retail_db4;
show tables;

create table orders1(id int not null , price float not null ,quantity int);

insert into orders1 values(1,3,5);
insert into orders1 values(null,3,6); # gives error as : Column id cannot be null
# alone we cannot give quantity here since null values will be entered to id and price if constraint is not added 
# by default null is added but here we given constraint they should not be null
insert into orders1(quantity) values(100); # error here as Field id doesn't have a default value 
insert into orders1 values(1,3); # error as :  column count doesn't match value count at this row
insert into orders1(id,price) values(1,3);  # this works fine and quantity will be null by default 


# whenever u want to insert the data, then it is mandatory to insert id and price here
# if default value is given , then instead of null the default value will be stored here.


-- PRIMARY KEY
-- nulls are not allowed and only unique values are allowed.
-- A key which can uniquely identify a record 
-- we have class of students whose names can be repeated and it is not possible to identify them uniquely
-- in that case, there should be a column which helps us to identify a column uniquely here

create table students(id int, fname varchar(20),lname varchar(10),class int);
insert into students values(1,"rama","shyam",5);
insert into students values(1,"mahi","shankar",5); # this works fine as for id we haven't mentioned it as primary key


-- let's drop this table and create again with id as primary key

drop table students;

create table students(id int primary key, fname varchar(20),lname varchar(10),class int);

insert into students values(1,"rama","shyam",5);
insert into students values(1,"mahi","shankar",5); # gives error as : Error Code: 1062. Duplicate entry '1' for key 'students.PRIMARY'

insert into students values(2,"gnana","reddy",5);
insert into students values(3,"jagan","mohan",9);

select * from students;
/*
1	rama	shyam	5
2	gnana	reddy	5
3	jagan	mohan	9
*/

-- drop a primary key
-- since there is only 1 primary key for a table, there is no need to specify the column name while dropping
create table stud(id int primary key ,fname varchar(10));

alter table stud drop primary key; #  works fine


# we can also add primary key for a table using the column name and alter 
-- syntax is:  alter table table_name add primary key(column name);

-- make sure that there will be only 1 primary key for a table.
-- assume id is not a primary key here.
-- before u use this command, we need to make sure that class column should not contain any duplicates 
alter table students add primary key(class);

# since primary key is table level constraint, we can check it's information in the table_ constraints table in information_schema database
use information_schema;
select * from table_constraints where table_name='students';
/*
def	student	PRIMARY	student	students	PRIMARY KEY	YES
*/

use retail_db4;
# we can mention multiple columns as primary key and it can be done by mentioning in the table lastly.
# sometimes a single column won't work as Primary Key. In such cases,we can use 2 columns 

create table if not exists study(id int  ,fname varchar(10),lname varchar(10),aadhar_no double,primary key(id,aadhar_no));
# here id+aadhar_no is defined as the Primary_key 
insert into study values(1,"Indra","Sena",45687),(1,"Siva","reddy",6543);
select * from study;

/*
id, fname, lname, aadhar_no
1	Indra	Sena	45687
1	Siva	reddy	6543
*/


insert into study values(2,"Indra","Sena",45),(2,"Siva","reddy",45); # error here as primary key have duplicte entry
/*
Error Code: 1062. Duplicate entry '2-45' for key 'study.PRIMARY'
*/












