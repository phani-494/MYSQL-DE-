show databases;
use retail_db;
show tables;
describe student_details;
select * from student_details;

# to update any record value or to update the values by applying filter
update student_details set Name='Mahendra' where age=29;

delete from student_details where Name='Indra';

delete from student_details;

drop table student_details;
