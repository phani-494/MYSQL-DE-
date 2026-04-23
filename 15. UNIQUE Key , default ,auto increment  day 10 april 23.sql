# unique key - here null values are allowed.
# primary key-- unique + not null
# a table can have only 1 or 0 PK but it can have  many unique keys
-- any no of null values are allowed for unqiue key here-  and no 2 null values are same 

# for example consider email (and phone numbers): there cannot be same email ids and 
-- sometimes it will be optional also( null values also accepted for email)
# so for email we can give unique key constraint

use retail_db4;
create table stud_details(id int primary key, email varchar(20) unique key ,fname varchar(10) not null);

insert into stud_details values(1, "raja@gmail.com","Mahi"); # works fine
insert into stud_details values(2,null,"swamy"); # null values are accepted for email 
# let's try to insert some duplicate email
insert into stud_details values(3, "raja@gmail.com","sahi");#  Error Code: 1062. Duplicate entry 'raja@gmail.com' for key 'stud_details.email'

insert into stud_details(id,fname) values(4, "thani"); # works fine as email is optional 


-- default : for some columns there will be always some specific values by default and no need to enter them every time 
-- in such cases we can use the default value here
-- if no other value is given then default value will be inserted here.
drop table stud_details ;

create table stud_details(id int , email varchar(20) unique key ,fname varchar(10) ,class int default 8);

insert into stud_details values(1,"mahi@gmail.com","Phani",9);

-- Error Code: 1136. Column count doesn't match value count at row 1
insert into stud_details values(1,"mahi@gmail.com","Phani"); # error as shown above 

insert into stud_details(id,email,fname) values(2,"sahi@gmail.com","thani"); # works fine
-- instead of null value to class by default here 9 is inserted
insert into stud_details(id,email,fname) values(3,"abhi@gmail.com","honey");
select * from stud_details;

/*
1	mahi@gmail.com	Phani	9
2	sahi@gmail.com	thani	8
3	abhi@gmail.com	honey	8
*/

insert into stud_details values(10,"hitesh@gmail.com","Phani",default); # we can also simply mention as default here
insert into stud_details values(11,"ritesh@gmail.com","sai",null); # see here we given null and it is accepted and no error here
-- if we don't want this then we should give as class int not null default 8

alter table stud_details add column date1 date default (current_date); # date1 column is added 

/*
1	mahi@gmail.com	Phani	9	2026-04-23
2	sahi@gmail.com	thani	8	2026-04-23
3	abhi@gmail.com	honey	8	2026-04-23
10	hitesh@gmail.com	Phani	8	2026-04-23
11	ritesh@gmail.com	sai		2026-04-23

*/

# AUTO_INCREMENT KEY
-- mostly used for primary key
-- automatically keeps incrementing values here 
-- as it keeps incrementing , every time new value generated and no duplicates will be there which means best suitable for primary key
-- we can start from some  value such as 100 and it starts incrementing from 101 


drop table stud_details;

create table stud_details(id int primary key auto_increment , email varchar(20) unique key ,fname varchar(10) ,class int default 8);

insert into stud_details values(1,"mahi@gmail.com","mahi",10);
insert into stud_details(email,fname) values("thani@gmail.com","thani"); # here automatically id is 2
insert into stud_details(email,fname) values("john@gmail.com","johncena"); 

select * from stud_details;
/*
1	mahi@gmail.com	mahi	10
2	thani@gmail.com	thani	8
3	john@gmail.com	johncena	8
*/


insert into stud_details values(10,"gnana@gmail.com","gnana",10); # now the increment will start from 10 and keep increasing
insert into stud_details(email,fname) values("karn@gmail.com","karn"); 


select * from stud_details;

/*
1	mahi@gmail.com	mahi	10
2	thani@gmail.com	thani	8
3	john@gmail.com	johncena	8
10	gnana@gmail.com	gnana	10
11	karn@gmail.com	karn	8
*/

-- set the starting value of auto-increment here 

alter table stud_details  auto_increment=100;
# when u enter/insert  values the value will starts from 100 now 



