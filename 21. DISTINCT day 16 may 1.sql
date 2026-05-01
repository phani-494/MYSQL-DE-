-- DISTINCT

USE RETAIL_DB2;
SHOW TABLES;


CREATE TABLE customers1 (
    `Index` INT PRIMARY KEY,
    customer_id VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    company VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    phone_1 VARCHAR(30),
    phone_2 VARCHAR(30),
    email VARCHAR(100),
    subscription_date DATE,
    website VARCHAR(100)
); 
-- we imported data from csv file herecustomers

select * from customers1;

-- we want to know what countries are present. since there are multiple countries it gives us multiple same results 

select country from customers1; # a list of 998 countries with so many duplicates here repeating
select count(country) from customers1; # 998

-- when we want to only the countries without the duplicates, we need to know the distinct


select  distinct country from customers1; # a distinct 239 countries will be present here

select  count(distinct country) from customers1; # 239 are there 

select  count(distinct city) as city_count from customers1; # 982 cities  are there 


select  distinct country,city from customers1; 


CREATE TABLE student_courses (
    student_name VARCHAR(50),
    course VARCHAR(50)
);

INSERT INTO student_courses (student_name, course) VALUES
('Indra', 'SQL'),
('Indra', 'Python'),
('Indra', 'SQL'),       -- duplicate
('Ravi', 'SQL'),
('Ravi', 'Python'),
('Ravi', 'Python'),     -- duplicate
('Anu', 'SQL');

# some duplicates are present as shown above
-- here we apply distinct on both columns combinations
SELECT  distinct student_name, course FROM student_courses;
/*
Indra	SQL
Indra	Python
Ravi	SQL
Ravi	Python
Anu	SQL
*/


create table students(
student_id INT AUTO_INCREMENT,
student_fname varchar(30) NOT NULL,
student_lname varchar(30) NOT NULL,
student_mname varchar(30),
student_email varchar(30) NOT NULL,
student_phone varchar(15) NOT NULL,
student_alternate_phone varchar(15),
years_of_exp INT NOT NULL,
student_company varchar(30),
batch_date varchar(30) NOT NULL,
source_of_joining varchar(30) NOT NULL,
location varchar(30) NOT NULL,
PRIMARY KEY(student_id),
UNIQUE KEY(student_email)
);


INSERT INTO students (student_fname, student_lname, student_mname, student_email, student_phone, years_of_exp, student_company, batch_date, source_of_joining, location)
VALUES 
('Amit', 'Sharma', 'Kumar', 'amit.s@example.com', '9876543210', 5, 'TechCorp', '2024-01-15', 'LinkedIn', 'Bangalore'),
('Amit', 'Patel', NULL, 'amit.p@example.com', '9876543211', 3, 'Innovate', '2024-01-15', 'Referral', 'Mumbai'),
('Priya', 'Singh', 'Kumari', 'priya.s@example.com', '9876543212', 2, 'TechCorp', '2024-02-01', 'LinkedIn', 'Bangalore'),
('Rahul', 'Verma', NULL, 'rahul.v@example.com', '9876543213', 8, 'DataSoft', '2024-01-15', 'Google', 'Delhi'),
('Sonia', 'Khan', NULL, 'sonia.k@example.com', '9876543214', 4, 'Innovate', '2024-02-01', 'LinkedIn', 'Mumbai'),
('Amit', 'Sharma', 'Kumar', 'amit.alt@example.com', '9876543215', 5, 'TechCorp', '2024-01-15', 'LinkedIn', 'Bangalore'),
('Vikram', 'Rao', 'Aditya', 'vikram.r@example.com', '9876543216', 6, 'DataSoft', '2024-03-10', 'Referral', 'Hyderabad'),
('Anjali', 'Nair', NULL, 'anjali.n@example.com', '9876543217', 2, 'TechCorp', '2024-01-15', 'LinkedIn', 'Bangalore'),
('Rahul', 'Gupta', NULL, 'rahul.g@example.com', '9876543218', 10, 'GlobalIT', '2024-03-10', 'Google', 'Delhi'),
('Sonia', 'Mehta', NULL, 'sonia.m@example.com', '9876543219', 4, 'Innovate', '2024-02-01', 'LinkedIn', 'Mumbai'),
('Karan', 'Johar', NULL, 'karan.j@example.com', '9876543220', 7, 'GlobalIT', '2024-03-10', 'Referral', 'Hyderabad'),
('Priya', 'Das', 'Anjali', 'priya.d@example.com', '9876543221', 1, 'TechCorp', '2024-01-15', 'LinkedIn', 'Bangalore'),
('Amit', 'Joshi', NULL, 'amit.j@example.com', '9876543222', 4, 'DataSoft', '2024-02-01', 'Google', 'Delhi'),
('Sneha', 'Reddy', NULL, 'sneha.r@example.com', '9876543223', 3, 'Innovate', '2024-01-15', 'LinkedIn', 'Mumbai'),
('Vikram', 'Singh', NULL, 'vikram.s@example.com', '9876543224', 9, 'GlobalIT', '2024-03-10', 'Referral', 'Hyderabad');


select * from students;

-- give the top 5 students who have more experience

select * from  students order by years_of_exp desc limit 5; 
/*
9	Rahul	Gupta		rahul.g@example.com	9876543218		10
15	Vikram	Singh		vikram.s@example.com	9876543224		9
4	Rahul	Verma		rahul.v@example.com	9876543213		8
11	Karan	Johar		karan.j@example.com	9876543220		7
7	Vikram	Rao	Aditya	vikram.r@example.com	9876543216		6
*/

-- get the candidates with 4th and 5th highest exp

select * from  students order by years_of_exp desc limit  3,2 ; # gives the exact result 

/*
LIMIT offset, count
3 → skip first 3 rows
2 → then take next 2 rows
*/

select distinct(source_of_joining) from students;
/*
LinkedIn
Referral
Google
*/

-- get the  sources used by top 5 experienced people

SELECT  source_of_joining
FROM students
ORDER BY years_of_exp DESC limit 5;

/*
Google
Referral
Google
Referral
Referral
*/

select distinct source_of_joining from  students order by years_of_exp desc ;  # gives error here
# Error Code: 3065. Expression #1 of ORDER BY clause is not in SELECT list, references column 'retail_db2.students.years_of_exp' 
# which is not in SELECT list; this is incompatible with DISTINCT



/*
When you use DISTINCT, every column in ORDER BY must also be in the SELECT list.
*/





SELECT DISTINCT source_of_joining, years_of_exp
FROM students
ORDER BY years_of_exp DESC limit 5;

/*
Google	10
Referral	9
Google	8
Referral	7
Referral	6
*/


