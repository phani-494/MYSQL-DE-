# ALTER is used to change the structure of existing table.
# Instead of dropping the table and losing the data ,we can simply use alter and add new columns delete the columns etc..

create database retail_db2;
use retail_db2;

-- Create the orders table
CREATE TABLE orders (
    order_id int,
    order_item_id int,
    order_date date,
    customer_id int,
    product_id int,
    quantity int,
    product_price float,
    total_price float
);

-- Insert records into the orders table
INSERT INTO orders VALUES
(1, 1, '2013-07-25', 11599, 957, 1, 299.98, 299.98),
(2, 2, '2013-07-25', 256, 1073, 1, 199.99, 199.99),
(2, 3, '2013-07-25', 256, 502, 5, 50.00, 250.00),
(2, 4, '2013-07-25', 256, 403, 1, 129.99, 129.99),
(4, 5, '2013-07-25', 8827, 897, 2, 24.99, 49.98),
(4, 6, '2013-07-25', 8827, 365, 5, 59.99, 299.95),
(4, 7, '2013-07-25', 8827, 502, 3, 50.00, 150.00),
(4, 8, '2013-07-25', 8827, 1014, 4, 49.98, 199.92),
(5, 9, '2013-07-25', 11318, 957, 1, 299.98, 299.98),
(5, 10, '2013-07-25', 11318, 365, 5, 59.99, 299.95),
(5, 11, '2013-07-25', 11318, 1014, 2, 49.98, 99.96),
(5, 12, '2013-07-25', 11318, 957, 1, 299.98, 299.98),
(5, 13, '2013-07-25', 11318, 403, 1, 129.99, 129.99);


desc orders;
/*
order_id	int	YES		
order_item_id	int	YES		
order_date	date	YES		
customer_id	int	YES		
product_id	int	YES		
quantity	int	YES		
product_price	float	YES		
total_price	float	YES		
*/

select * from orders;

# now the management ordered us to add a new column named order_status 
# new column is added at the end always 

alter table orders add column (Order_Status varchar(20) default "Completed"); # we added a new column here 

# here we changed the existing  structure and total 9 columns are here'
# to insert data, we need to pass 9 values here.

# suppose u want to delete a particular order_id   for ex- order_id 7

delete from orders where order_id=7;

# here let us try to add some order_id values for 7 and add items 

INSERT INTO orders (order_id, order_item_id, order_date, customer_id, order_status, product_id, quantity, product_price, total_price) 
VALUES (7, 14, '2013-07-25', 4530, 'COMPLETE', 1073, 1, 199.99, 199.99),
(7, 15, '2013-07-25', 4530, 'COMPLETE', 957, 1, 299.98, 299.98),
(7, 16, '2013-07-25', 4530, 'COMPLETE', 926, 5, 15.99, 79.95);

# now we want to add some orders without order_status and there are 2 ways 
# 1. giving column_name and null 
# 2. without mentioning column name and by default null values will be added


-- Scenario 1: Including the order_status column but setting it to NULL
INSERT INTO orders (order_id, order_item_id, order_date, customer_id, order_status, product_id, quantity, product_price, total_price) VALUES
(8, 17, '2013-07-25', 2911, null, 365, 3, 59.99, 179.97),
(8, 18, '2013-07-25', 2911, null, 365, 5, 59.99, 299.95),
(8, 19, '2013-07-25', 2911, null, 1014, 4, 49.98, 199.92),
(8, 20, '2013-07-25', 2911, null, 502, 1, 50.00, 50.00); # below also same way it works 

/*
-- Scenario 2: Equivalent to the above, but omitting order_status from the column list entirely
INSERT INTO orders (order_id, order_item_id, order_date, customer_id, product_id, quantity, product_price, total_price) VALUES
(8, 17, '2013-07-25', 2911, 365, 3, 59.99, 179.97),
(8, 18, '2013-07-25', 2911, 365, 5, 59.99, 299.95),
(8, 19, '2013-07-25', 2911, 1014, 4, 49.98, 199.92),
(8, 20, '2013-07-25', 2911, 502, 1, 50.00, 50.00);


This example highlights a fundamental rule in SQL:
* **Explicit Nulls:** In the first block, you explicitly tell the database to put a `NULL` in the `order_status` column.
* **Implicit Nulls:** In the second block, by leaving `order_status` out of the column list, the database will automatically 
# insert a `NULL` (provided the column doesn't have a `NOT NULL` constraint or a default value).

# Both methods achieve the same result for `order_id` 8. 

*/

# drop a column

alter table orders drop column total_price; # now the column is dropped.

# we can change the datatype of the column by using alter
# we want to capture the time also along with date 

alter table orders modify order_date datetime; # now it becomes like this 

/*
1	1	2013-07-25 00:00:00	11599	957	1	299.98	Completed
2	2	2013-07-25 00:00:00	256	1073	1	199.99	Completed
2	3	2013-07-25 00:00:00	256	502	5	50	Completed
2	4	2013-07-25 00:00:00	256	403	1	129.99	Completed
*/
# above 00:00:00 is added at all places simply and no time is mentioned particularly.
# we can simply get back to date only using date 
/*
alter table orders modify order_date date; # when we run this we don't get any warning and we get date only..

*/
# here  let's try to insert  new data  with order_id 7 by deleting it first previous records 

delete from orders where order_id=7;
# we add again back with  some time stamp
# for first  column here we mentioned some exact time here which means some kind of data is added .

INSERT INTO orders (order_id, order_item_id, order_date, customer_id, order_status, product_id, quantity, product_price) 
VALUES (7, 14, '2013-07-25 12:30:45', 4530, 'COMPLETE', 1073, 1, 199.99),
(7, 15, '2013-07-25', 4530, 'COMPLETE', 957, 1, 299.98),
(7, 16, '2013-07-25', 4530, 'COMPLETE', 926, 5, 15.99);


select * from orders; # this data was added in the last
/*
7	14	2013-07-25 12:30:45	4530	1073	1	199.99	COMPLETE
7	15	2013-07-25 00:00:00	4530	957	1	299.98	COMPLETE
7	16	2013-07-25 00:00:00	4530	926	5	15.99	COMPLETE
*/

# above 12:30:45 time is added  -time is mentioned particularly.
# we can simply get back to date only using date but this time we get warning as we mentioned some particular time 
/*
alter table orders modify order_date date; # when we run this we  get warning and we get date only..
# since there is some kind of data loss, we are getting the warning.
*/

# to change the column name ;
alter table orders rename column order_id to id;

# change column datatype (float to int)

alter table orders modify product_price int ;
/*
1	1	2013-07-25	11599	957	1	300	Completed
2	2	2013-07-25	256	1073	1	200	Completed
2	3	2013-07-25	256	502	5	50	Completed
*/

# change column prod_id from int to varchar

alter table orders modify product_id varchar(6);

# let' say suppose we want to change datatype of customer_id to string 
# and suppose u converted here int to varchar(3) but some customer_id values are very large which cannot be accomodated by varchar(3)
-- in this case it will gives us a  error as;
alter table orders modify customer_id varchar(3); # error--> Data too long for column 
# here data will be lost if size is not fit and error occurs

select * from orders;
desc orders;

# we  can change date to int type here but datetime to int is not possible
alter table orders modify order_date int;

alter table orders modify order_date datetime;
/*
1	1	2013-07-25 00:00:00	11599	957	1	300	Completed
2	2	2013-07-25 00:00:00	256	1073	1	200	Completed
2	3	2013-07-25 00:00:00	256	502	5	50	Completed
2	4	2013-07-25 00:00:00	256	403	1	130	Completed
4	5	2013-07-25 00:00:00	8827	897	2	25	Completed
*/

# # we  cannot change datetime to int type here
alter table orders modify order_date int; # error as Out of range value for column 'order_date'at row 1

# anything can be changed to varchar but it should be proper size given there
-- change datetime as varchar
alter table orders modify order_date varchar(20); 

alter table orders modify order_date date; 
/*
1	1	2013-07-25	11599	957	1	300	Completed
2	2	2013-07-25	256	1073	1	200	Completed
2	3	2013-07-25	256	502	5	50	Completed
*/

-- change order_status to int;

alter table orders modify order_status int; # gives error as Incorrect integer vakue: 'Completed' for column 'order_status'

UPDATE orders  SET order_status = NULL; # this column values are NULL now.

alter table orders modify order_status int; # now no error here # check by using desc orders 

# rename the table here

alter table orders rename   to orders_now;








