# when we want some column(s) to act as a unique identifier to find out a record unqiuely in a big table, then we make that column as Primary key 
# for example, a bank account column must be unique and no duplicates were allowed for it(Null values are not accepted here)
# this column can uniquely identify every account holder here

show databases;
use student;
create table Bank_Details (Ac_No int PRIMARY KEY,F_Name varchar(15) NOT NULL, Phone varchar(10) NOT NULL);
insert into Bank_Details Values(1234,"Indra",709312345);

insert into Bank_Details Values(1235, "Mahi",7654334);

# the below line gives error as Duplicate entry '1235' for key "bank_details".PRIMARY
insert into Bank_Details VALUES(1235, "Suresh",987654);

# here the primary key field is not given and no null values can be accepted for this 
insert into Bank_Details(F_Name,Phone) Values("Raja",98765); # gives error as Field'Ac_No' doesn't have a default Value


desc Bank_Details;

insert into Bank_Details VALUES(NULL, "Suresh",987654); # Gives Error as Column Ac_No cannot be NUll .

select * from Bank_Details;


# Auto  increment

# sometimes we want the values to be auto incremented so there is no need to enter them manually.
# for example, the students id_card no will increment one by one and there is no need to enter by us.

# in this case,we can add AUTO INCREMENT attribute column  here simply and each and every value will be unique here 

create table Std_Details(Id_No INT PRIMARY KEY  AUTO_INCREMENT  ,F_Name varchar(15) NOT NULL, class int  default 6);
insert into Std_Details(F_Name) values("Kannaya");
insert into Std_Details(F_Name,class) values("Mahidhar",9);

insert into Std_Details  values(4,"sasi",4);

insert into Std_Details  values(4,"sasi",4); # gives error as Duplicate entry "4" for key std_details.PRIMARY 

select * from std_details;

# let's say suppose we explicitly enter a value for the id as 7 here simply, then from that moment onwards AUTO_increment will starts again


insert into Std_Details values(7,"Manu",5);


insert into Std_Details(F_Name,class)  values("Thoni",5);

insert into Std_Details(F_Name)  values("cheni");


select * from Std_Details;
/*
1	Kannaya	6
2	Mahidhar	9
4	sasi	4
7	Manu	5
8	Thoni	5
9	cheni	6

*/


insert into Std_Details  values(9,"cheni",10); # since 9 already exists,we cannot insert one more 9 there

# when you want the big  column names as shortcut names instead of big ones 
# or names which are not proper then we can use alias name here and get the table

select class as 'Student_class' from Std_Details;

select class as 'Student_class',  class as 'Study clas' from Std_Details;


# where clause is used to filter the records or to apply some conditions 
# used for condition based queries

select class as 'Student_class',  class as 'Study clas' from Std_Details where class>5;

/*
6	6
9	9
6	6

*/

# to get a particular student record 
select class as 'Student_class',  class as 'Study clas' from Std_Details where F_name="Manu"; # works fine 

# we can perform update and delete some records using where clause

update Std_Details  set class=12 where F_name="Manu";

select * from Std_Details ;

/*
1	Kannaya	6
2	Mahidhar	9
4	sasi	4
7	Manu	12
8	Thoni	5
9	cheni	6

*/

delete from std_details where F_name="Thoni"; # this will be deleted simply



# practice problems

create database bank_db;
use bank_db;
create table employess (emp_id int primary key auto_increment, name varchar(16) not null, design varchar(15) default "Probation");

# here we done a mistake of not using this database when we created 
# main point is we need to use this after creating it



insert into employess(name,design) values("Maharaja","AE");
insert into employess(name,design) values("Samar","AEs");
insert into employess(name,design) values("raja","JE");
insert into employess(name) values("rajanna");

desc employess;

select * from employess;

update employess set design="Police" where emp_id=3;

delete from employess where emp_id=2;
show databases;
use bank_db;
show tables;


