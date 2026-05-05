-- date time 

use practice;

select current_time(); # 20:11:17

-- today date
select current_date(); # 2026-05-04

-- both time and date
select current_timestamp();  # 2026-05-04 20:13:15

-- extract only date from the timestamp;
select date('2026-05-04 20:13:15') as date_only; # 2026-05-04

select time('2026-05-04 20:13:15') as time_only;  # 20:13:15

select year('2026-05-04 20:13:15') as year_only; # 2026

select month('2026-05-04 20:13:15') as month_only; # 5

select monthname('2026-05-04 20:13:15') as month_name; # May

select day('2026-05-04 20:13:15') as day_only; # 4

select dayname('2026-05-04 20:13:15') as day_name; # Monday 


select dayofweek('2026-05-04 20:13:15') ; # 2 which means Monday 



-- get only year
select extract(year from  '2026-05-04 20:13:15') as year_only; # 2026

select extract(month from  '2026-05-04 20:13:15') as month_only; # 5

select extract(day from  '2026-05-04 20:13:15') as day_only; # 4

SELECT EXTRACT(YEAR_MONTH FROM '2026-05-04 20:13:15') ; # 202605


SELECT EXTRACT(week FROM '2026-05-04 20:13:15') ; # 18

SELECT EXTRACT(day FROM '2026-05-04 20:13:15') ; # 4



/*
Which one should you use?
For grouping → use EXTRACT(YEAR_MONTH ...)
For display → use DATE_FORMAT('%Y-%m')
For filtering → use YEAR() / MONTH() carefully (or better: date ranges)
*/


use retail_db2;
show tables;

select * from customers1;

ALTER TABLE customers1 DROP COLUMN  phone_1;
ALTER TABLE customers1 DROP COLUMN  phone_2;

-- to drop 2 columns at a time
ALTER TABLE customers1 DROP COLUMN  website,
drop column email;

select * from customers1;
/*
Index, customer_id, first_name, last_name, company, city, country, subscription_date
1	dE014d010c7ab0c	Andrew	Goodman	Stewart-Flynn	Rowlandberg	Macao	2021-07-26
2	2B54172c8b65eC3	Alvin	Lane	Terry, Proctor and Lawrence	Bethside	Papua New Guinea	2021-06-24
3	d794Dd48988d2ac	Jenna	Harding	Bailey Group	Moniquemouth	China	2020-04-05
4	3b3Aa4aCc68f3Be	Fernando	Ford	Moss-Maxwell	Leeborough	Macao	2020-11-29
*/


-- get only year from the subscription_date and select  some columns 

select first_name,city,year(subscription_date) as year from customers1 limit 5;

/*
first_name, city, year
Andrew	Rowlandberg	2021
Alvin	Bethside	2021
Jenna	Moniquemouth	2020
Fernando	Leeborough	2020
Kara	Port Jacksonland	2022

*/

-- get the count of customers by month and year

-- first let us see how to extract year and month  from date
SELECT 
    DATE_FORMAT(subscription_date, '%Y-%m') AS yearmonth
FROM customers1;
/* only some records shown here for understanding 
2021-07
2021-06
2020-04
2020-11
2022-04

*/

SELECT  count(*),DATE_FORMAT(subscription_date, '%Y-%m') AS yearmonth
FROM customers1 
group by DATE_FORMAT(subscription_date, '%Y-%m') order by yearmonth desc;


-- works fine 
SELECT  count(*),DATE_FORMAT(subscription_date, '%Y-%m') AS yearmonth
FROM customers1 
group by yearmonth order by yearmonth desc;

/*
27	2022-05
51	2022-04
32	2022-03
29	2022-02
31	2022-01
41	2021-12
30	2021-11
45	2021-10
30	2021-09
30	2021-08
37	2021-07
-- more present but upto this enough
*/

-- Incase  if we want total_amount earned for each month we can give as 

SELECT  count(*),DATE_FORMAT(subscription_date, '%Y-%m') AS yearmonth,sum(amount) as total_amount 
FROM customers1 
group by DATE_FORMAT(subscription_date, '%Y-%m') order by yearmonth desc;

select week(current_date()); # 18

SELECT WEEKDAY(CURRENT_DATE()); 

/*

What it does
CURRENT_DATE() → returns today’s date
WEEKDAY(date) → returns day of week as a number
📊 Output meaning

WEEKDAY() returns values from 0 to 6:

Value	Day
0	Monday
1	Tuesday
2	Wednesday
3	Thursday
4	Friday
5	Saturday
6	Sunday
*/


/*
DAYOFWEEK(date)
It behaves differently:
Function	Range	Start Day
WEEKDAY()	0–6	Monday
DAYOFWEEK()	1–7	Sunday

*/

-- date-add /date subtract

-- after 10 days what is the date
select date_add(current_date, interval 10 day) as newdate; # 2026-05-14

-- before 10 days what is the date 
select date_sub(current_date, interval 10 day); # 2026-04-24


select datediff(current_date, '2026-05-14'); # -9 days here minus 9 days 

select datediff('2026-05-24', '2026-05-14'); # 10 days 
select datediff('2026-05-24', '2000-05-14'); # 9506 days 
select datediff('2026-05-24', '1998-05-18'); # 10233 days 


-- DATEFORMAT

select date_format('2026-05-24', '%Y'); # 2026
select date_format('2026-05-24', '%y'); # 26     - last 2 letters only  will be given here 
select date_format('2026-05-24', '%M'); # May      
select date_format('2026-05-24', '%m'); # 05     
select date_format('2026-05-24', '%d'); # 24
select date_format('2026-05-24', '%D'); # 24th -- just 'th' will be added 
        
select date_format('2026-05-24', '%Y-%d'); # 2026-24
select date_format('2026-05-24', '%d-%M'); # 24-May
select date_format('2026-05-24', '%D-%M-%Y'); # 24th-May-2026
select date_format('2026-05-24', '%D %M %Y'); # 24th May 2026
select date_format('2026-05-24', '%M %D %Y'); # May 24th  2026


-- Unix time (also called epoch time) is the number of seconds that have passed since:  1970-01-01 00:00:00 UTC

-- Get current Unix timestamp
SELECT UNIX_TIMESTAMP(); #  1777983340 seconds passed. Returns current time in seconds since epoch

-- Convert date → Unix timestamp

SELECT UNIX_TIMESTAMP('2026-05-05 12:00:00'); # 1777962600   Output: seconds value (e.g., 177...)


--  Convert Unix timestamp → readable date
-- sometimes in our table or logs, time and date will be present in the form of the unixtime . we need to convert it using  FROM_UNIXTIME
SELECT FROM_UNIXTIME(1777900000); #  2026-05-04 18:36:40


-- in functions

-- to get the absolute value use abs()
select abs(-10); # 10


-- we can  use ceil or ceiling --both fine here 
select ceiling(10.5); # 11
select ceiling(-10.5); # -10

select floor(4.6); # 4
select floor(-4.6); # -5


select round(234.567812,3); # 234.568


-- TRUNCATE(number, decimal_places):  Cuts off digits without rounding
select truncate(234.567812,3); # 234.567

-- to get the remainder 
select mod(45,4); # 1

select power(3,3); # 27

select sqrt(25); # 5


-- this will give -1 if input is negative number and 0 if input is 0 and 1 if input is positive number 
select sign(-10); # -1

select sign(0); # 0

-- generates a random number fom 0 to 1
select rand(); # 0.9352387636296812


SELECT FLOOR(1 + (RAND() * 10)); # 8 --  gives random number from 1 to 10

SELECT FLOOR(1 + (RAND() * 100)); #  64 -- gives random number from 1 to 100



