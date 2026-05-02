use practice;


CREATE TABLE string_practice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    product_code VARCHAR(20),
    comments VARCHAR(255)
);

INSERT INTO string_practice 
(full_name, email, phone, city, product_code, comments)
VALUES
('john doe', 'john.doe@gmail.com', '9876543210', '    new york    ', 'prd-001-ny', 'first order'),
('ALICE SMITH', 'ALICE@YAHOO.COM', '9123456780', '   LOS ANGELES', 'prd-002-la', 'repeat customer'),
('Bob Marley', 'bob.marley@outlook.com', '9988776655', 'chicago     ', 'prd-003-ch', 'VIP client'),
('charlie brown', 'charlie.brown@gmail.com', '9090909090', '    houston', 'prd-004-hs', 'new signup'),
('DAVID MILLER', 'DAVID.M@GMAIL.COM', '9812345678', 'PHOENIX', 'prd-005-ph', 'bulk order'),
('emma watson', 'emma.watson@yahoo.com', '9700000000', 'philadelphia      ', 'prd-006-pa', 'discount applied'),
('Frank Ocean', 'frank.ocean@icloud.com', '9654321098', 'san antonio', 'prd-007-sa', 'late delivery'),
('grace hopper', 'grace.hopper@gmail.com', '9543216789', '    san diego', 'prd-008-sd', 'priority shipping'),
('Henry Ford', 'henry.ford@ford.com', '9432109876', 'dallas', 'prd-009-da', 'corporate order'),
('isabella ross', 'isabella.ross@gmail.com', '9321098765', 'san jose    ', 'prd-010-sj', 'gift order');



select * from string_practice;

select *, concat(full_name,city) as Name_city from string_practice;


/* only some records shown here for understanding
id, full_name, email, phone, city, product_code, comments, Name_city
1	john doe	john.doe@gmail.com	9876543210	    new york    	prd-001-ny	first order	john doe    new york    
2	ALICE SMITH	ALICE@YAHOO.COM	9123456780	   LOS ANGELES	prd-002-la	repeat customer	ALICE SMITH   LOS ANGELES
3	Bob Marley	bob.marley@outlook.com	9988776655	chicago     	prd-003-ch	VIP client	Bob Marleychicago     
4	charlie brown	charlie.brown@gmail.com	9090909090	    houston	prd-004-hs	new signup	charlie brown    houston
*/

-- suppose u have first_name and last_name columns then use concat to get the full nameas 

select *, concat(first_name,last_name) as Full_Name from string_practice; # just to understand

select concat(email," ",phone,' ',city) as Full_Address from string_practice;
/*
john.doe@gmail.com 9876543210     new york    
ALICE@YAHOO.COM 9123456780    LOS ANGELES
bob.marley@outlook.com 9988776655 chicago     
charlie.brown@gmail.com 9090909090     houston
DAVID.M@GMAIL.COM 9812345678 PHOENIX
*/

select full_name, length(full_name) as Name_Length from string_practice;
/* somr records shown  here for understanding
full_name, Name_Length
john doe	8
ALICE SMITH	11
Bob Marley	10
charlie brown	13
DAVID MILLER	12
*/


select full_name, length(full_name) as Name_Length 
from string_practice
where Name_Length=8; # after from it comes to where and it doesn't find the column named the Name_Length
-- Error Code: 1054. Unknown column 'Name_Length' in 'where clause'


select full_name, length(full_name) as Name_Length 
from string_practice
where length(full_name)=10;  # now this will works 
/*
Bob Marley	10
Henry Ford	10
*/

select concat("Phani","Indra"); # PhaniIndra 
select length("Phanindra Reddy"); # 15 

-- to the length function, we can give integers also as it internally uses the string conversions (typecasting) here

select length(id) from string_practice;
/*
1
1
1
1
1
1
1
1
1
2
*/


-- implement data quality checks here such as some conditions;
-- length of customer state should be 3
-- length of zipcode should be 5
-- if violated then those are invalid records as of now

select count(*) from string_practice
 where length(state)!=2
 or  length(zipcode)!=5 ;# all these result will be invalid records
 
 
 select upper(full_name) from string_practice;
 /*
 JOHN DOE
ALICE SMITH
BOB MARLEY
CHARLIE BROWN
*/

 select lower(full_name) from string_practice;
 /*
 john doe
alice smith
bob marley
charlie brown
david miller
*/

-- SUBSTRING : Index always starts from 1 here

select substring("Hello world",7); # start from 7th character which is w and go till end 

select substring("Hello world",7,3); # start from 7th character which is w and take 3 characters

select substring("Hello world",-3); # take  last 3 characters -- rld

select substring("Hello world",1); # gives entire string  -- Hello world




select full_name, substring(full_name,5) from string_practice;
/*
full_name, substring(full_name,5)
john doe	 doe
ALICE SMITH	E SMITH
Bob Marley	Marley
charlie brown	lie brown
DAVID MILLER	D MILLER
*/

-- TRIM

select trim("  You are Hero   "); #You are Hero -- both sides spaces are removed 
select ltrim("  You are Hero   ");# You are Hero   -- only left spaces are removed
select rtrim("  You are Hero   "); #  You are Hero-- only right spaces are removed

-- observe carefully that city column have spaces randomly  
select trim(city) from string_practice;
/*
new york
LOS ANGELES
chicago
houston
PHOENIX
*/

-- find all the customers with leading or trailing spaces in city

select * from string_practice 
where trim(city) !=city;
/*
1	john doe	john.doe@gmail.com	9876543210	    new york    
2	ALICE SMITH	ALICE@YAHOO.COM	9123456780	   LOS ANGELES
3	Bob Marley	bob.marley@outlook.com	9988776655	chicago     
4	charlie brown	charlie.brown@gmail.com	9090909090	    houston
6	emma watson	emma.watson@yahoo.com	9700000000	philadelphia      
*/

-- REPLACE

select replace("Hello world", "world","Mysql"); # replaces world with Mysql  -- Hello Mysql



select * from string_practice;

select product_code, replace(product_code ,"prd-00","P") from string_practice;

/*
prd-001-ny	P1-ny
prd-002-la	P2-la
prd-003-ch	P3-ch
prd-004-hs	P4-hs
*/

-- LOCATE /instr -- FIRST OCCURENCE WILL BE GIVEN
-- this says locate SQL in MYSQL 
select locate("SQL" ,"MYSQL") as position; # 3 (at 3rd position it is present)

-- this says in the string of MYSQL , locate SQL
select instr("MYSQL" ,"SQL") as position; # 3 (at 3rd position it is present)


-- Suppose ur location is present as 6009 AP Kadapa
-- u want the 6009 here (till the space  we want value)

select city_location, substr(city_location,1,locate(" ", city_location)) from string _practice;


select  substr("6009 AP Kadapa",1,locate(" ", "6009 AP Kadapa")); # 6009 
