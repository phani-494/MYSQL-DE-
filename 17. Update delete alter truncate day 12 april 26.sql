# update an delete

use retail_db;
show tables;
select * from products;

# updating two values in products  here 
update products set quan=5,price=100 where id=4; # for a special id 

# if u want to have all same value in a column- suppose let;s assume quantity is same now

update products set quan=10; # for entire column

select * from products;
/*

1	234.456000	10
2	238.987655	10
4	100.000000	10
4	100.000000	10
*/


-- let's delete some id which is no longer in use

delete from products where id=4;
# even if there are multiple records with id=4, all those will be deleted 


/*
1	234.456000	10
2	238.987655	10
*/

-- to delete the entire data of the table 
delete   from  products; 


-- Difference between ALTER and UPDATE

-- update is a DML command used to modify the data. here we have to commit for save and we can do rollback here.
-- alter is a DDL command used to change the defintion(structure) of the table.
-- suppose u added a new column, then it is committed permanently ; since DDL commands are  auto committed always.



-- delete vs truncate 

-- 1. both are used to delete the table here.
# 

# suppose u observe the query here
-- we can delete the selected data or all the data .

delete from products  where id=8;

-- here first where clause will work and filter the results and those will be deleted here.


-- TRUNCATE : removes all the data in the entire table here
-- no filters are used here such as where clause .
-- deletes all the table data here.alter

TRUNCATE orders ; # similar to delete from orders 

select * from orders; # now no data is present here

--  Truncate is a DDL operation(even it deals with data only ) where internally it drops the table and recreates it(simply deals with structure of table internally)

-- delete is a DML operations where it deals with records not with  the structure here

# whenever u want to delete the very large amount of data , then simply truncate it
-- if u use delete, then it takes lot of time here to delete the data as it is done row by row here.

-- to acheive high performance we use truncate.

-- truncate will do a implicit commit as it is a DDL operation  and cannot be rolled back. data permanently gone and no rollback










