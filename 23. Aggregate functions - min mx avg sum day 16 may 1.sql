--  Aggregate = combine multiple rows into a single value

CREATE TABLE IF NOT EXISTS sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    amount DECIMAL(10, 2),
    sale_date DATE,
    quantity INT,
    customer_id INT,
    store_location VARCHAR(50)
);



DELIMITER $$

CREATE PROCEDURE insert_sales_data()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO sales VALUES (
            i,
            ELT(1 + FLOOR(RAND()*5), 'Laptop','Smartphone','Desk Chair','Monitor','Headphones'),
            ELT(1 + FLOOR(RAND()*3), 'Electronics','Furniture','Appliances'),
            ROUND(50 + (RAND()*1200),2),
            DATE_ADD('2023-10-01', INTERVAL FLOOR(RAND()*10) DAY),
            1 + FLOOR(RAND()*5),
            100 + FLOOR(RAND()*50),
            ELT(1 + FLOOR(RAND()*3), 'New York','Los Angeles','Chicago')
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL insert_sales_data();

select * from sales;
/*
1	Headphones	Furniture	507.41	2023-10-06	3	140	Los Angeles
2	Monitor	Furniture	1120.62	2023-10-07	4	124	New York
3	Laptop	Appliances	531.10	2023-10-08	2	120	New York
4	Monitor	Furniture	940.06	2023-10-02	4	136	Los Angeles
*/

select  count(*) from sales; # 1000 records

select max(sale_date) as recent_SALE , min(sale_date) as oldest_SALE  from sales; # 2023-10-10	2023-10-01


select max(amount) as MAX_SALE , min(amount) as MIN_SALE , avg(amount) as AVG_SALE from sales;
/*
MAX_SALE, MIN_SALE, AVG_SALE
1248.62	50.22	636.910240
*/
-- we are getting the output in same row
-- to get the output in multiple rows we use union 


select  count(*) as total_orders,sum(amount) as total_SALE , min(amount) as MIN_SALE ,max(amount) as MAX_SALE ,
 avg(amount) as AVG_SALE from sales;
 /*
 total_orders, total_SALE, MIN_SALE, MAX_SALE, AVG_SALE
 1000	636910.24	50.22	1248.62	636.910240
 */
 
 SELECT 'Total Orders' AS metric, COUNT(*) AS value FROM sales
UNION 
SELECT 'Total Sale', SUM(amount) FROM sales
UNION 
SELECT 'Min Sale', MIN(amount) FROM sales
UNION 
SELECT 'Max Sale', MAX(amount) FROM sales
UNION 
SELECT 'Avg Sale', AVG(amount) FROM sales
UNION 
SELECT 'Min Sale', MIN(amount) FROM sales ; # we given twice this 
 
/*
 Total Orders	1000.000000
Total Sale	636910.240000
Min Sale	50.220000       only once we got the result as unnion doesn't allow the duplicates 
Max Sale	1248.620000
Avg Sale	636.910240
*/ 
 
 /*
 Key Concept
Keyword	Behavior
UNION	❌ Removes duplicates
UNION ALL	✅ Keeps duplicates
*/
 
 
 -- here it will allow the duplicates also.
 SELECT 'Total Orders' AS metric, COUNT(*) AS value FROM sales
UNION ALL
SELECT 'Total Sale', SUM(amount) FROM sales
UNION ALL
SELECT 'Min Sale', MIN(amount) FROM sales
UNION ALL
SELECT 'Max Sale', MAX(amount) FROM sales
UNION ALL
SELECT 'Avg Sale', AVG(amount) FROM sales;



/*
Why this works
Each SELECT returns one row
UNION ALL stacks them vertically
So columns → become rows
*/ 