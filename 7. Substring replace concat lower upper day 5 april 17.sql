# concat  functions
# select will display the data 
select concat("Phanindra" ,"   ","reddy");
select concat("Phanindra" ,"   ","reddy"," u are hero !");

 
 show databases;
 use student;
 show tables;
 
 select * from std_details; # here we have columns as Id_No, F_Name, class ;
 
 select concat (F_Name,"  ", class) as "Name-class"  from std_details;
 # the result will be this
 /*
 Name-class
 Kannaya  6
Mahidhar  9
sasi  4
Manu  12
cheni  6
 */
 
 select Id_No,concat (F_Name,"  ", class) as "Name-class"  from std_details;
 
 /*
1	Kannaya  6
2	Mahidhar  9
4	sasi  4
7	Manu  12
9	cheni  6
 */
 
 
 # when we want to add +91 for every number or say let's add reddy to every name then use concat 
 
 select concat (F_Name," Reddy ") as "Name"  from std_details;

/*
Kannaya Reddy 
Mahidhar Reddy 
sasi Reddy 
Manu Reddy 
cheni Reddy 
*/


# concat_ws    ws  means "with separator"
# we can use somply concat and add separtor there . then why we use concat_ws
# when there are more columns instead of two, then at that time every where we cannot simply add the separator symbol


select concat_ws("---","Indra","sena"); # gives result as Indra---sena

select concat_ws("*",F_Name," Reddy ") as "Name"  from std_details;

/*
Kannaya* Reddy 
Mahidhar* Reddy 
sasi* Reddy 
Manu* Reddy 
cheni* Reddy 
*/


select concat_ws("---","Indra","sena","You are", "a good guy"); # gives result as Indra---sena---You are---a good guy

select concat_ws(":","Indra","sena","You are", "a good guy"); # gives result as Indra:sena:You are:a good guy

# sub-string 
# selects the sub-string from 1 to 5 and here generally index starts from 1 only 
select substring("INdrasena",1,5); # INdra
select substring("INdrasena",4,15); # rasena # goes till the end and no error occurs if there are no characters left 

select substring("INdrasena",4); # rasena # goes till the end and no error occurs as default value here is the end value 


# when we give - here then it starts prints from the backwards 

select substring("INdrasena",-4); # last 4 characters will be printed here 

# replace function- takes the original string and replaces a substring with some other string and gives the new string
# replace(str,from_str,to_str)
select replace("Indrasena","Indra","Maha"); # gives result as "Mahasena"




CREATE TABLE students (
    roll_no INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL
) AUTO_INCREMENT = 100;

-- Insert Random Student Names
INSERT INTO students (student_name) VALUES
('Arjun'),
('Priya'),
('Rahul'),
('Sneha'),
('Kiran'),
('Meena'),
('Vikram'),
('Anjali'),
('Rohit'),
('Divya');

-- Display Data
SELECT * FROM students;

/*

100	Arjun
101	Priya
102	Rahul
103	Sneha
104	Kiran
105	Meena
106	Vikram
107	Anjali
108	Rohit
109	Divya
*/


select replace(roll_No,10,1000) as New_RollNo from students; # Wherever 10 is present, there it will be replaced with 1000

/*
New_RollNo
10000
10001
10002
10003
10004
10005
10006
10007
10008
10009
*/

select replace(roll_No,10,"emp") as New_RollNo from students; # Wherever 10 is present, there it will be replaced with 1000

/*
emp0
emp1
emp2
emp3
emp4
emp5
emp6
emp7
emp8
emp9
*/

# one of the best use case is we can replace a space string with empty string

select replace("indra sena reddy"," ",""); # all whitespaces are removed here 


# reverse

select reverse("Hello"); # gives result as olleH


select reverse(student_name) as Rev_Name from students; 

/*
Rev_Name
nujrA
ayirP
luhaR
ahenS
nariK
aneeM
markiV
ilajnA
tihoR
ayviD

*/


select upper(student_name) as Rev_Name from students; 
/*
ARJUN
PRIYA
RAHUL
SNEHA
KIRAN
MEENA
*/

select upper("Mahasena"); # MAHASENA
select lower("MAHasena"); # mahasena

select lower(student_name) as Rev_Name from students; 