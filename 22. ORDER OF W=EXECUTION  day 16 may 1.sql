select * from students;

select student_fname, source_of_joining from  students order by years_of_exp desc ; # this works fine

/* only some records shown here for understanding here
Rahul	Google
Vikram	Referral
Rahul	Google
Karan	Referral
Vikram	Referral
Amit	LinkedIn
Amit	LinkedIn
Sonia	LinkedIn
Sonia	LinkedIn
*/


select distinct source_of_joining from  students order by years_of_exp desc ;  # gives error here 

-- Error Code: 3065. Expression #1 of ORDER BY clause is not in SELECT list, 
-- references column 'retail_db2.students.years_of_exp' which is not in SELECT list; this is incompatible with DISTINCT


SELECT DISTINCT source_of_joining, years_of_exp
FROM students
ORDER BY years_of_exp DESC limit 5;  # this will work fine here

/*
Google	10
Referral	9
Google	8
Referral	7
Referral	6
*/

select  source_of_joining
from students 
where location in ('Bangalore','mumbai')
order by years_of_exp desc 
limit 5;

/*
LinkedIn
LinkedIn
LinkedIn
LinkedIn
Referral
*/


-- to understand this, we need to know the order of execution like which will be executed first here

select distinct source_of_joining
from students 
where location in ('Bangalore','mumbai')
order by years_of_exp desc 
limit 5; # gives error here
/*
 find highest  5 experiencing candidates in these 2 locations and their source of joining.
we want to the source of joining based on experience in  2 locations only.
if we don't use the distinct it is working fine but when we use distinct here , it is failing
*/

-- let's see the flow of execution here
/* - 
1. FROM -  first load the table(data) -- upto here all columns and rows are present (ex- 100 rows and 20 columns)
2. WHERE - apply the filter on data -- after filtering we got 50 rows  and 20 columns here
3. select - project the columns whatever we want -- we choose what columns are needed . for example- 10 columns here  with 50 rows 
4. distinct - remove the duplicate records 
5. order by - sorting based on ascending or  descending order
6. limit - always at the end and restricts the no of records 
*/


select student_fname 
from students 
where years_of_exp > 6;

-- first STUDENTS - all columns /all rows
-- second -- where years_of_exp is > 6
-- third -projection of the fname column

-- suppose let's say first the select happens and then where will be done 
-- then here first fname will be selected and then where filter will be done but here how can you apply the filter on the fname only
-- so this assumption is wrong and it cannot works here 


-- suppose assume salary column is present here

-- this gives error here as  first it loads the table and then checks for the revised salary in table using where
-- but it is not present in that time
-- so this gives error 
select student_fname ,years_of_exp*1.1 as revised_exp 
 from students
 where revised_exp >6;

# Error Code: 1054. Unknown column 'revised_exp' in 'where clause'

-- we are able to use the derived column in order by 
select student_fname , student_company,years_of_exp*1.1 as revised_exp   # third this will happens
 from students # first it will happen 
 where  student_company !="Datasoft" # second this will happen 
 order by revised_exp desc  # internally this data will be present to order by and works fine 
 limit 5;
 
 /*
 Correct logical flow (clean version)
FROM → get data
WHERE → filter rows
Compute expressions → years_of_exp * 1.1
ORDER BY → sort using that computed value
LIMIT → take top 5
SELECT → show final columns

*/


/*
Rahul	GlobalIT	11.0
Vikram	GlobalIT	9.9
Karan	GlobalIT	7.7
Amit	TechCorp	5.5
Amit	TechCorp	5.5
*/

-- so we cannot use the derived column in where clause but we can use the derived column in order by 

-- here we haven't used the order by column in select columns and still this will works fine here
-- here implicitly years_of_exp column also got selected in the select columns and it works fine 

select student_fname , student_company  # third this will happen 
 from students # first it will happen 
 where  student_company !="Datasoft" # second this will happen 
 order by years_of_exp desc  # fourth  this will be done and sorting works fine as revised exp is present  internally
 limit 5;
 
 
 # FROM --> WHERE --> SELECT (internally it uses/projects the order by column also which is given in order by )--> order by --> limit 
 /*
 One-line Rule to Remember

Without DISTINCT → ORDER BY can use hidden columns
With DISTINCT → ORDER BY must use only selected columns
*/



select distinct source_of_joining # third and internally it uses/selects the years_of_exp column also and 
-- now distinct will happen which will reduce the data 
from students  # first 
where location in ('Bangalore','mumbai') # second
order by years_of_exp desc  # 4th this will be done
limit 5; # gives error here


/*
here what we wanted is the - distinct source_of_joining
but what is happening is DISTINCT (source of joining ,years of exp)
*/
