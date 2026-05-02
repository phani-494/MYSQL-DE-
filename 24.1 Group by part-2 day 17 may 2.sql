create database practice;
use practice;

 
CREATE TABLE project_tasks1(
    project_name VARCHAR(100),
    task_name VARCHAR(100),
    assigned_to VARCHAR(100),
    start_date DATE,
    days_required INT,
    end_date DATE,
    progress DECIMAL(5,2)
);

DELIMITER $$

CREATE PROCEDURE insert_random_task(IN num_records INT)
BEGIN
    DECLARE i INT DEFAULT 0;

    WHILE i < num_records DO
        INSERT INTO project_tasks (
            project_name,
            task_name,
            assigned_to,
            start_date,
            days_required,
            end_date,
            progress
        )
        VALUES (
            ELT(FLOOR(1 + RAND()*5), 'Marketing', 'Sales', 'IT','Health','Finance'),
            CONCAT('Task_', FLOOR(RAND()*1000)),
            ELT(FLOOR(1 + RAND()*6), 'Alice', 'Bob', 'Charlie', 'Daisy', 'Eve','Indra'),
            DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND()*60) DAY),
            FLOOR(5 + RAND()*25),
            DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND()*90) DAY),
            ROUND(RAND()*100, 2)
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;


CALL insert_random_task(300);
select * from project_tasks;


select date_format(start_date,'%Y-%m') as start_month,project_name   from project_tasks group by  start_month,project_name;
/*
2024-01	Sales
2024-02	Sales
2024-01	Marketing
2024-02	IT
2024-02	Marketing
2024-01	IT
2024-02	Finance
2024-02	Health
2024-01	Finance
2024-01	Health
*/



-- let's get back to sales table

use retail_db2;
select * from sales;

select  store_location ,sum(amount) as TA
from sales
where TA>200000 # derived column will not be visible to where 
group by store_location;


 # Error Code: 1054. Unknown column 'TA' in 'where clause'

/*
Problem here:
TA is created in SELECT
But WHERE runs before SELECT

👉 So when MySQL reaches:

WHERE TA > 200000

➡️ TA doesn’t exist yet ❌
*/

/*
Correct Solution → Use HAVING
💡 Why HAVING works
HAVING runs after GROUP BY
At that time:
SUM(amount) is already calculated ✅
TA is available ✅
🧠 Simple Rule to Remember
Clause	Works on
WHERE	Rows (before grouping)
HAVING	Groups (after grouping)

*/

select  store_location ,sum(amount) as TA
from sales
group by store_location;
/*
Los Angeles	216723.62
New York	192459.50
Chicago	227727.12
*/
-- apply filter on above results and find >200000 sales amount 

-- find total sales by store location where total sales amount exceeds 200000
-- when we want to  filter on aggregations, we need to use HAVING 
-- on this distinct store locations we need to apply the filter based on amount
select  store_location ,sum(amount) as TA
from sales
group by store_location
having TA>200000;
/*
store_location TA
Los Angeles	216723.62
Chicago	227727.12

*/

-- let's find the highest order amount in each category

select category,max(amount) from sales group by category;

/*
Furniture	1248.62
Appliances	1246.46
Electronics	1248.00
*/

-- total sales amount and avg quantity sold per product in new york

select product, sum(amount),avg(quantity) from sales
 where store_location="New York"  # first we need the New york location rows-- before grouping we need to apply filter 
 group by product;
/*
product sum(amount) avg(quantity)
Monitor	42851.53	2.9737
Laptop	41900.40	2.9846
Smartphone	36270.30	2.9508
Desk Chair	33785.18	3.0339
Headphones	37652.09	2.9219
*/


-- let's do some analysis on the Laptop  product in New york location after grouping
select product, sum(amount),avg(quantity) from sales
 where store_location="New York"  # first we need the New york location rows-- before grouping we need to apply filter 
 group by product
 having product="Laptop"; # Laptop	41900.40	2.9846
 -- the above takes lot time comapred to below query
 -- we can do simply filter in where clause 


-- this is optimised search  here
select product, sum(amount),avg(quantity) from sales
 where store_location="New York" and product="Laptop"  # first we need the New york location rows and where proodcut is Laptop
 group by product;
 
/*
Key Difference
🔴 Query 1 Flow
Filter → store_location = "New York"
Group ALL products in New York
Then filter → product = "Laptop"

👉 It processes more data than needed

🟢 Query 2 Flow
Filter → store_location = "New York"
Filter → product = "Laptop"
Group only remaining rows

👉 It processes minimal data

🧠 Why Query 2 is Faster
1. Early Filtering (Big Deal)
WHERE reduces rows before grouping
Less data → faster aggregation
2. HAVING is Late Filtering
Runs after GROUP BY
Wastes work grouping unnecessary rows

Simple Analogy

Imagine 1 million rows:

Query 1:
Groups 100,000 rows → then filters ❌
Query 2:
Filters to 2,000 rows → then groups ✅

👉 Huge performance difference

*/


-- It is better to apply  having clause if we want to either filter based on count of orders, or any other aggregate functions
-- like total sales ,avg amount etc..
-- filters on aggregation is not possible using where clause

-- find total sales and total quantity sold each month

select distinct date_format(sale_date,'%Y-%m') as sale_month from sales; # 2023-10


select date_format(sale_date,'%Y-%m') as sale_month, sum(quantity) as total_sales ,sum(amount) as total_amount 
 from sales
 group by  sale_month;


-- from each store find the count of unique customers;

select store_location, count(distinct id)
from sales
group by store_location;
/*
store_location count(distinct id)
Chicago	337 # from chicago stores, 337 unique customers are present
Los Angeles	338
New York	325
*/


-- monthly sales by each customer 
select date_format(sale_date,'%Y-%m') as sale_month, id, sum(amount) as total_amount
 from sales
 group by  sale_month,id;

/*
sale_month id total_amount
2023-10	1	507.41
2023-10	2	1120.62
2023-10	3	531.10
2023-10	4	940.06
2023-10	5	980.54
*/



-- monthly sales by each customer who have placed atleast 8 orders
-- Keeps only those groups where: Customer placed at least 8 orders in that month
-- Monthly total sales for each customer, but only if that customer made at least 8 orders in that month
SELECT DATE_FORMAT(sale_date, '%Y-%m') as sale_month, customer_id, 
SUM(amount) as total_sales
FROM sales
GROUP BY sale_month, customer_id
HAVING count(*) >= 8;

/*
Who are high-frequency customers?
Which customers are most engaged monthly?
Useful for:
Loyalty programs
Target marketing
Customer segmentation
*/

-- total sales amount by category with sales in jan 2023
-- Total sales for each category, but only for January 2023
SELECT category, SUM(amount) as total_sales
FROM sales
WHERE MONTH(sale_date) = 1 AND YEAR(sale_date) = 2023
GROUP BY category;


-- For January 2023, each store’s total sales and number of orders, sorted by busiest stores first

SELECT store_location, 
       SUM(amount) AS total_sales, 
       COUNT(*) AS num_transactions
FROM sales
WHERE sale_date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY store_location
ORDER BY num_transactions DESC;

