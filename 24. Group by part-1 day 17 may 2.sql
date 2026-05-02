-- GROUP BY
-- this helps in  dealing with groups/categories across a column 

use retail_db2;
select * from sales;



select distinct category from sales;
/*
Furniture
Appliances
Electronics
*/

-- we can find these using group by
select category from sales group by category;
/*
Furniture
Appliances
Electronics
*/

-- I want total sales for each group

select  category, count(id) as total_sales from sales group by category;
/*
category    total_sales
Furniture	341
Appliances	327
Electronics	332
*/

select  category, sum(amount) as total_amount from sales group by category;
/*
category    total_amount
Furniture	211749.70
Appliances	216370.14
Electronics	208790.40

*/

select  category, sale_date, sum(amount) as total_amount from sales group by category;

/*
Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated 
column 'retail_db2.sales.sale_date' which is not functionally dependent on columns in GROUP BY clause; 
this is incompatible with sql_mode=only_full_group_by

 sale_date column is not aggregated here and it have various dates here where sum(amount) is aggregated here
 so we need to aggregate the sale_date here either by min or max 
*/

/*
⚠️ Why it gives error

When you use GROUP BY, every column in SELECT must follow one rule:

👉 Either:

Be inside an aggregate function (SUM, COUNT, etc.)
OR be included in GROUP BY
Problem here:
category ✅ (in GROUP BY)
SUM(amount) ✅ (aggregate)
sale_date ❌ (neither grouped nor aggregated)

👉 MySQL doesn’t know:

“Which sale_date should I show for each category?”

Because each category can have multiple dates.
*/


select  category, max(sale_date), sum(amount) as total_amount from sales group by category;

/*
category  max(sale_date) total_amount
Furniture	2023-10-10	211749.70
Appliances	2023-10-10	216370.14
Electronics	2023-10-10	208790.40
*/

-- count of the distinct products in each category
-- for example in Electronics, there are 5 different products 


select category,count(distinct product) from sales group by category;
/*
category count(distinct product)
Appliances	5
Electronics	5
Furniture	5
*/

-- total count of products  of each category
select category,product,count( product) from sales group by category,product ;
/*
category   product  count( product)
Furniture	Headphones	65
Furniture	Monitor	68
Appliances	Laptop	77
Furniture	Laptop	70
Appliances	Monitor	54
Furniture	Smartphone	70
Electronics	Monitor	67
Electronics	Smartphone	65
Appliances	Smartphone	67
Furniture	Desk Chair	68
Electronics	Laptop	70
Appliances	Desk Chair	69
Electronics	Desk Chair	64
Electronics	Headphones	66
Appliances	Headphones	60
*/

select category,product from sales group by category,product  order by category;
/*
category product
Appliances	Desk Chair
Appliances	Headphones
Appliances	Laptop
Appliances	Monitor
Appliances	Smartphone
Electronics	Desk Chair
Electronics	Headphones
Electronics	Laptop
Electronics	Monitor
Electronics	Smartphone
Furniture	Desk Chair
Furniture	Headphones
Furniture	Laptop
Furniture	Monitor
Furniture	Smartphone

*/


-- lets see the products present

select product from sales group by product;
/*
Headphones
Monitor
Laptop
Smartphone
Desk Chair
*/

select product,count(id) from sales group by product;
/*
Headphones	191
Monitor	189
Laptop	217
Smartphone	202
Desk Chair	201
*/


select product ,sum(quantity) as total_quan from sales group by product order by product;
/*
product   total_quan
Desk Chair	605
Headphones	565
Laptop	662
Monitor	576
Smartphone	625
*/


-- let us see in one query for good understanding
select product , count(*) as total_orders,sum(quantity) as total_quan from sales group by product order by product;
/*
product total_orders total_quan
Desk Chair	201	605
Headphones	191	565
Laptop	217	662
Monitor	189	576
Smartphone	202	625
*/

-- find the 3 products with maximum sales volume

select product , count(*) as total_orders,sum(quantity) as total_quan from sales group by product order by total_quan desc limit 3;
/*
product, total_orders, total_quan
Laptop	217	662
Smartphone	202	625
Desk Chair	201	605

*/

-- total sales and no of transactions per store location


select store_location , count(*) as total_transactions,sum(quantity) as total_quan from sales group by store_location order by total_quan desc ;
/*
store_location total_transactions total_quan
Los Angeles	338	1067
Chicago	337	1000
New York	325	966
*/

-- assume customer_id with 1 has bought sales as 1000,5000,6000 . then for each customer_id we check the avg amount here 
select customer_id,avg(amount) as avg_sale  from sales group by customer_id; # just understand 


select date_format(sale_date,'%Y-%m') as Y_m  from sales;
/* just some records shown here 
2023-10
2023-10
2023-10
2023-10
2023-10
*/



-- total sales by month and category

select date_format(sale_date,'%Y-%m') as sale_month,category   from sales group by  sale_month,category ;
/*
sale_month category
2023-10	Furniture
2023-10	Appliances
2023-10	Electronics
*/

select date_format(sale_date,'%Y-%m') as sale_month,category ,sum(amount) as total_amount  from sales group by  sale_month,category ;
/*
sale_month category total_amount
2023-10	Furniture	211749.70
2023-10	Appliances	216370.14
2023-10	Electronics	208790.40
*/