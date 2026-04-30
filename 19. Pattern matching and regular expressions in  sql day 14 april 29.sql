show databases;
use retail_db2;
select * from employees;


-- PATTERN MATCHING
-- Here we don't know the exact pattern , but we have some idea of how the pattern will looks like

-- find all the employees where first name starts with   J 
-- Here % represents any no of characters ( 0 or more characters)
-- when we use underscore(_) it means exactly one character here

-- even if there is only J , it also comes in the result as % includes 0 characters also
select * from employees where first_name like "J%"; # it should start with J and after that it can be anything 

/*
employee_id, first_name, last_name, department_id, salary, hire_date, manager_id, email, phone_number, job_title
1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager
7	James	Anderson	103	47000.00	2023-07-01	3	james.a@email.com	9876543216	Developer
21	Jack	Walker	103	50000.00	2024-03-05	3	jack.w@email.com	9876543230	Frontend Dev
25	Joseph	King	104	61000.00	2024-05-05	5	joseph.k@email.com	9876543234	Finance Manager
*/

select * from employees where first_name like "%n"; # it should start with any letter  but ends with h  
/*  here mentioned some columns only for understanding
employee_id, first_name, last_name
1	John	Smith
11	Benjamin	Harris
16	Evelyn	Robinson
19	Sebastian	Lewis
*/


-- last name should start with B and ends with n 
select * from employees where last_name like "B%n"; # word should start with B and ends with n    --   3	Michael	Brown

select * from employees where first_name like "C%" and  last_name like "%n";  # 12	Charlotte	Martin

select * from employees where first_name like "A%A" ; # here first_name starts with A and ends with A
/*
8	Ava	Thomas
14	Amelia	Garcia
*/

-- first name should have exactly 5 characters ;
select * from employees where first_name like "_____" ; # here we given 5 underscores 
/*
7	James	Anderson
13	Lucas	Thompson
15	Henry	Martinez
23	David	Allen
24	Grace	Young
26	Chloe	Wright

*/

-- first name should be atleast 7 characters (7  or more charcters)
select * from employees where first_name like "_______%" ; # 7 underscores are given here and after 0 or more characters 

/*
3	Michael	Brown
9	William	Jackson
11	Benjamin	Harris
12	Charlotte	Martin
17	Alexander	Clark
19	Sebastian	Lewis
22	Scarlett	Hall
27	Matthew	Scott
*/

-- in first name the first character shoule be A and third character should be  e and after that any no of characters

select * from employees where first_name like "A_e%" ;  # here second character can be anything
/*
14	Amelia	Garcia	101
17	Alexander	Clark	103
*/

-- first name should be 4 characters and starts with J
select * from employees where first_name like "J___" ; 
/*
1	John	Smith
21	Jack	Walker
*/

-- get all the first names where it contains an in it .. it can be anywhere 
-- before and after an , there can be anything

select * from employees where first_name like "%an%" ; # for example : ran,man, daniel etc...
/*
5	Daniel	Wilson
17	Alexander	Clark
19	Sebastian	Lewis
*/

-- job title includes the manager
select * from employees where job_title like "%manager%"; 
# 1	John	Smith	101	55000.00	2023-01-15		john.smith@email.com	9876543210	Manager
# 25 Joseph	King	104	61000.00	2024-05-05	5	joseph.k@email.com	9876543234	Finance Manager

-- select any manager from the department_id 104 
select * from employees where department_id=104 and  job_title like "%manager%"; 
# 25	Joseph	King	104	61000.00	2024-05-05	5	joseph.k@email.com	9876543234	Finance Manager


# to check for atleast one character we need to use _% 
# for gmails or emails we use -%@ so that we are checking atleast one character present or not before @


-- after dot there should be atleast one character there
-- before @ there should be atleast one character 
select * from employees where email like "_%@email._%"; # all are valid here . so all results are there


select * from employees where email like "_%@_%._%";
-- before @ there should be atleast one character
-- after  @ there should be atleast one character
-- after dot there should be atleast one character

/*
@gmail.com      -- no character before @
abc@.com        -- nothing between @ and .
abc@gmail.      -- nothing after .
abcgmail.com    -- no @
abc@com         -- no dot
*/


select * from employees where email not like "_%@_%._%"; # no results  show here

update  employees set email="phani&%@gmail.com" where first_name="James";


-- search for all employees who have % in their email
-- % and _ are wildcard characters here
-- when we give \ then it will not acts as wildcard character


-- first and last % are wild card characters here 
select * from employees where email  like "%\%%"; # here \% means it will not acts as wild character and search for % in email
# 7	James	Anderson	103	47000.00	2023-07-01	3	phani&%@gmail.com	9876543216	Developer
 
 -- suppose we have %\__ where 2 underscores are present 
 -- what it represents is there should be anything before the underscore and exactly one character should present after the underscore
 -- some examples are  sunny_1, phanindra_2, _3, .........
 
 
 # regular expressions - for complex matching patterns
 
 
 -- get all the employees where first name starts with A OR B OR C OR D
 
 select * from employees where first_name like 'A%' or first_name like 'B%' or first_name like 'C%' or first_name like 'D%';
 
 /*
 5	Daniel	Wilson
8	Ava	Thomas
11	Benjamin	Harris
12	Charlotte	Martin
14	Amelia	Garcia
17	Alexander	Clark
23	David	Allen
26	Chloe	Wright
*/

-- EASY WAY USING REGULAR EXPRESSIONS

-- ^ means starts with and [] means any of them
select * from employees where first_name regexp '^[ABCD]'; # gives as like above result here


-- $ means ending of the string 
select * from employees where first_name regexp '[ABCD]$'; # gives the names which ends with a/b/c/d

/*
2	Emma	Johnson
4	Sophia	Davis
6	Olivia	Taylor
8	Ava	Thomas
10	Mia	White
14	Amelia	Garcia
20	Ella	Lee
23	David	Allen
*/


-- get all the employees where the first name have 2nd character as (a,e,i,o,u);
-- here we are saying that  starts with  and then we give . which means single character then
-- second letter should be a/e/i/o/u here and then anything should be there

select * from employees where first_name regexp '^.[Aeiou]'; # dot represents single character should be there 

/*
1	John	Smith
3	Michael	Brown
4	Sophia	Davis
5	Daniel	Wilson
7	James	Anderson
9	William	Jackson
10	Mia	White
11	Benjamin	Harris
13	Lucas	Thompson
*/

update  employees set first_name="su" where first_name="is";


select * from employees where first_name regexp '^.[Aeiou]$';
# 7	su	Anderson	103	47000.00	2023-07-01	3	phani&%@gmail.com	9876543216	Developer
#  there should be  starting with one character and  then it should end with a/e/i/o/u 
 
 -- 2nd char is a vowel and 4th char is a vowel 
 
  select * from employees where first_name regexp '^.[Aeiou].[AEIOU]';
  

DROP TABLE USERS;

CREATE TABLE USERS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL
);
 
 INSERT INTO USERS (email) VALUES
('indra@gmail.com'), # VALID EMAIL NAMES 
('john@yahoo.com'),
('sita123@outlook.in'),
('ram.kumar@test.org'),
('a1b2c3@mail.net'),
('user_01@company.co'),
('hello.world@gmail.com'),
('demo123@sample.io'),
('king@domain.com'),
('queen99@service.in'),

-- Invalid emails (10)
('gmail.com'),
('@gmail.com'),
('indra@'),
('indra@gmail'),
('indra@@gmail.com'),
('indra gmail.com'),
('indra@.com'),
('indra@com'),
('indra#gmail.com'),
('');
 
 
 SELECT * FROM USERS;
 
 -- RULES FOR VALID EMAIL ARE SHOWN IN EXAMPLES 
 
 #  email contains: Name can be a-z 0-9 and _  .
 # domain can be a-z 0-9 
 # sub domain can be 2 or more characters 
 
 /*
 [abcd]* means 0 or more times
 [abcd]+ means 1 or more characters
 [abcd]? 0 or 1 time
 here - in a-z means range of characters .
 ^[a-z0-9._]+ means starts with any letter or number or dot symbol or  underscore
 
 \\.[a-z]{2,}"; means derch for dot symbol and then any characters ranging from maximum 2 to any length 
 \\.[a-z]{5}" ; means there should be 5 characters length 
 */
 
 SELECT * FROM USERS where email regexp "^[a-z0-9._]+@[a-z0-9_]+\\.[a-z]{2,}"; # it gives the list of first 10 valid emails 
 
 
 SELECT * FROM USERS where email  not regexp "^[a-z0-9._]+@[a-z0-9_]+\\.[a-z]{2,}"; # it gives the list of last 10 invalid emails 
 
SELECT * FROM USERS where email  regexp "^[a-z0-9._]+@[a-z0-9_]+\\.[a-z]{2}$"; # it gives the list of  valid emails  ending with only 2 characters
  /*
  sita123@outlook.in
user_01@company.co
demo123@sample.io
queen99@service.in
*/

  SELECT * FROM USERS where email  regexp "......"; # here we didn't mention start and end symbols
  /*
  email contains at least 6 characters in a row anywhere.

Since almost any normal email has 6+ characters, many rows will match.
*/

-- we use ^ in [] means those should not present
-- here we don't want to include any numbere before @
   SELECT * FROM USERS where email   regexp "^[^0-9.]+@[a-z0-9_]+\\.[a-z]{2}";
  /* 
   1	indra@gmail.com
2	john@yahoo.com
9	king@domain.com
15	indra@@gmail.com
  */
  
 
 






 
 
 






























