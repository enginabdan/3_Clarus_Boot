
--///////////////////////////////////////////// SUBJECT BASE SUMMARY ////////////////////////////////////////////

------------------------------------------------ WRITE AND RUN --------------------------------------------------

-- WRITTEN		///		RUNNING

-- SELECT				--FROM+JOIN
-- FROM+JOIN	        --WHERE
-- WHERE				--GROUP BY
-- GROUP BY				--HAVING
-- HAVING				--SELECT
-- ORDER BY				--ORDER BY
-- LIMIT		        --LIMIT

------------------------------------------------- OPERATORSN -----------------------------------------------------

-- distinct, like,
-- and, or, not, in, not in, exists, not exists,
-- <, >, =, !=, <>, between,
-- max, min, sum, count, avg 

------------------------------------------- DDL // DML // DCL // TCL --------------------------------------------

-- 	DDL - Data Definition Language (set up and configure a new database), (CREATE, ALTER, DROP)
--	DML - Data Manipulation Language (to access or manipulate data), (SELECT, INSERT, UPDATE, DELETE)
--	DCL - Data Control Language (used to grant or revoke access control), (REVOKE, GRANT)
--	TCL - Transaction Control Language (controls the transactions of DML and DDL), (BEGIN, COMMIT)

------------------------------------------------- DATA TYPES ----------------------------------------------------

-- DATA TYPES
	-- String
	-- Date and Time
	-- Numeric

-- STRING DATA TYPES
	-- CHAR 
	-- VARCHAR
	-- BINARY
	-- VARBINARY
	-- BLOB
	-- TEXT
	-- ENUM
	-- SET

-- DATE AND TIME DATA TYPES
	-- DATE 
	-- DATETIME
	-- TIMESTAMP
	-- YEAR

-- NUMERIC DATA TYPES
	-- INTEGER OR INT
	-- SMALLINT
	-- TINYINT
	-- MEDIUMINT
	-- BIGINT
	-- FLOAT
	-- DOUBLE
	-- FIXED
	-- DECIMAL
	-- NUMERIC

-- DATA TYPES
	-- char		>>> 10 dersek herþey için 10 tutar
	-- varchar	>>> 20 dedik, giriþ 5 char o zaman 5 yer tutat (var)
	-- text		>>> uzun metinler için çok büyük karakterde
	-- nchar	>>> unique karakter kullanýlabilir ð, ü ...
	-- nvchar	>>> unique karakter kullanýlabilir ð, ü ...
	-- ntext	>>> unique karakter kullanýlabilir ð, ü ...

---------------------------------------------- CONSTRAINTS -------------------------------------------------

-- CONSTRAINTS 
	-- NOT NULL
	-- DEFAULT
	-- UNIQUE
	-- PRIMARY KEY
	-- FOREIGN KEY

----------------------------------------------- JOIN TYPES ---------------------------------------------------

-- JOIN TYPES
	-- Inner Join
	-- Left Join
	-- Right Join
	-- Full Outer Join
	-- Cross Join
	-- Self Join

------------------------------------------- GROUP BY AND HAVING ---------------------------------------------

-- GROUP BY AND HAVING
-- Summary Table
-- Creating new Table with "Into"

---------------------------------------------- GROUPING SETS ------------------------------------------------

-- Grouping Sets

-- Group by Rollup(c1,c2,c3) >>> (c1,c2,c3) + (c1,c2,NULL) + (C1,NULL,NULL), (NULL,NULL,NULL)

-- Group by Cube(c1,c2,c3) >> --(C1,C2,C3) +
							  --(C1,C2,NULL) + (C1,C3,NULL) +
                              --(C2,C3,NULL) + 
							  --(C1,NULL,NULL) + (C2,NULL,NULL) + (C3,NULL,NULL)
							  --(NULL,NULL,NULL)

----------------------------------------------- PIVOT TABLES-------------------------------------------------

-- Pivot
-- Add "model year" dimention

---------------------------------------------- NESTED QUERIES -----------------------------------------------

-- Nested Queries
	-- Single row subqueries
	-- Multiple row subqueries
	-- Correlated subqueries

-- With "in/not in"
-- With "exists / not exists"

----------------------------------------------- VIEW TABLES --------------------------------------------------

-- view
-- View Tables are updated automatically when the tables that are making the view table are updated
-- Temporary tables >>> "into"

----------------------------------------------- CTE TABLES ----------------------------------------------------

-- CTE TABLES
	-- Ordinary CTE's
	-- Recursive CTE's
	-- CTE with new table Values

-------------------------------------------- SET OPERATIONS ---------------------------------------------------

-- SET OPERATIONS
	-- Union (Erase the same row)
	-- Union all (Getting all rows although the same)
	-- Intersection (Instead of join) (Important)
	-- Except (Important)

------------------------------------------- CASE EXPRESSIONS ---------------------------------------------------

-- CASE EXPRESSION

--------------------------------------------- DATE TIME --------------------------------------------------------

-- time				hh:mm:ss[.nnnnnnn]
-- date				YYYY-MM-DD
-- smalldatetime	YYYY-MM-DD hh:mm:ss
-- datetime			YYYY-MM-DD hh:mm:ss[.nnn]
-- datetime2		YYYY-MM-DD hh:mm:ss[.nnnnnnn]
-- datetimeoffset	YYYY-MM-DD hh:mm:ss[.nnnnnnn] [+|-]hh:mm

-- DATEFROMPARTS
-- DATETIMEFROMPARTS
-- DATETIMEOFFSETFROMPARTS
-- TIMEFROMPARTS

-- DATENAME >>> nvchar	>>> DATENAME(DW, ORDER_DATE)
-- DATEPART >>> int		>>> DATEPART(DAY, ORDER_DATE)

-- DAY		>>> int		>>> DAY(ORDER_DATE)
-- WEEK		>>> int		>>> WEEK(ORDER_DATE)
-- MONTH	>>> int		>>> MONTH(ORDER_DATE) 
-- YEAR		>>> int		>>> YEAR()

-- DATEDIFF (DAY, START_DATE, END_DATE)

-- DATEADD (DAY, NUMBER, DATE)
-- EOMONTH (START_DATE, [MONTH_TO_ADD])

-- ISDATE

-- CURRENT_TIMESTAMP
-- GETDATE ()
-- GETUTCDATE ()

------------------------------------------------ FUNCTIONS ---------------------------------------------------

-- CHARINDEX		>>> select charindex ('c', email)
-- PATINDEX			>>> select patindex ('%r%', email)

-- LEN				>>>	select len(email)

-- LEFT				>>> select left (email, 3)
-- RIGHT			>>> select right (email, 3)
-- SUBSTRING		>>> select substring (email, -2, 5)

-- LOWER			>>> select lower (email)
-- UPPER			>>> select upper (email)

-- STRING_SPLIT		>>> select * from string_split (email, ',')
-- +				>>> select upper (left(email, 1)) + right (email, len(email)-1)

-- TRIM				>>> select trim (email)
-- LTRIM			>>> select ltrim (email)
-- RTRIM			>>> select rtrim (email)

-- REPLACE			>>> select replace (email, 'RAc', ' ')

-- STR				>>> select str (email, 7, 3)

-- CAST				>>> select cast (email as VARCHAR(6))
-- CONVERT			>>> select convert (INT, email)

-- COALESCE			>>> select coalesce (phone, email)

-- NULLIF			>>> select nullif (first_name, 'Debra')

-- ROUND			>>> select round (phone, 2, 0)

--------------------------------------------- WINDOW FUNCTIONS -----------------------------------------------

-- WINDOW FUNCTIONS
								-- GROUP BY				-- WF
   -- Distinct					necessity				optional
   -- Aggregating				necessity				optional
   -- Ordering					invalid					valid
   -- Performance				slower					faster
   -- Dependency on Select		dependent				independent

-- Types of WF
   -- Aggregation Functions
		-- min()
		-- max()
		-- sum()
		-- avg()
		-- count()
   -- Navigation Functions
		-- first_value()
		-- last_value
		-- lead()
		-- lag()
   -- Numbering Functions
		-- row_number()
		-- rank()
		-- dense_rank()
		-- ntile()
		-- cume_dist()
		-- percent_rank()

-- WF Syntax and Keywords
   -- SELECT *, AVG(time) OVER (PARTITION BY time ORDER BY date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS avg_time
   -- from time_sales
   
   -- PARTITION		>>>		-- UNBOUNDED PRECEDING	>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
							-- N PRECEDING			>>> ROWS BETWEEN UNBOUNDED PRECEDING AND N PRECEDING
							--						>>> ROWS BETWEEN N PRECEDING AND CURRENT ROW
							-- 						>>> ROWS BETWEEN N PRECEDING AND M FOLLOWING
							-- N ROWS				
							-- CURRENT ROW --		>>> ROWS BETWEEN N PRECEDING AND CURRENT ROW
							--						>>> ROWS BETWEEN CURRENT ROW AND M FOLLOWING
							-- M ROWS				
							-- M FOLLOWING			>>> ROWS BETWEEN N PRECEDING AND M FOLLOWING
							--						>>> ROWS BETWEEN CURRENT ROW AND M FOLLOWING
							--						>>> ROWS BETWEEN M FOLLOWING AND UNBOUNDED FOLLOWING
							-- UNBOUNDED FOLLOWING	>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
-- Window Frames
-- How to apply WF

----------------------------------------- ANALYTIC AGGREGATE FUNCTIONS --------------------------------------

-- ANALYTIC AGGREGATE FUNCTIONS
   -- MIN()		>>>	select min(list_price) over (partition by category_id order by list_price) as xyz
   -- MAX()		>>>	select max(list_price) over (partition by category_id order by list_price) as xyz
   -- AVG()		>>>	select avg(list_price) over (partition by category_id order by list_price) as xyz
   -- SUM()		>>>	select sum(list_price) over (partition by category_id order by list_price) as xyz
   -- COUNT()	>>>	select count(list_price) over (partition by category_id order by list_price) as xyz

----------------------------------------- ANALYTIC NAVIGATION FUNCTIONS --------------------------------------

-- ANALYTIC NAVIGATION FUNCTIONS
   -- first_value()	>>>	select first_value(list_price) over (partition by category_id order by list_price) as xyz
   -- last_value()	>>>	select last_value(list_price) over (partition by category_id order by list_price rows between unbounded preceding and unbounded following) as xyz
   -- lead()		>>>	select lead(list_price) over (partition by category_id order by list_price) as xyz
   -- lag()			>>>	select lag(list_price) over (partition by category_id order by list_price) as xyz

----------------------------------------- ANALYTIC NUMBERING FUNCTIONS --------------------------------------

-- ANALYTIC NUMBERING FUNCTIONS
   -- ROW_NUMBER()		>>>	select row_number() over (partition by category_id order by list_price) as xyz
   -- RANK()			>>>	select rank() over (partition by category_id order by list_price) as xyz
   -- DENSE_RANK()		>>>	select dense_rank() over (partition by category_id order by list_price) as xyz
   -- CUME_DIST()		>>>	select cume_dist() over (partition by category_id order by list_price) as xyz
   --					>>> En yüksek deðere 1 verir // Tekrar edenleri tekrarý kadar hesaba katar
   -- PERCENT_RANK()	>>>	select percent_rank() over (partition by category_id order by list_price) as xyz
   --					>>> En düþük deðere 0 verir // Tekrar edenleri sadece 1 kere hesaba katar
   -- NTILE()			>>>	select ntile() over (partition by category_id order by list_price) as xyz


--///////////////////////////////////////////// LESSON BASE SUMMARY ////////////////////////////////////////////

------------------------------------------ 1st Lesson ------------------------------------------

-- WRITTEN		///		RUNNING

-- SELECT				--FROM+JOIN
-- FROM+JOIN	        --WHERE
-- WHERE				--GROUP BY
-- GROUP BY				--HAVING
-- HAVING				--SELECT
-- ORDER BY				--ORDER BY
-- LIMIT		        --LIMIT

-- distinct, like, and, or, not, in, not in, exists, not exists, <, >, =, !=, <>, between, max, min, sum, count, avg 

-- Single Row Query
-- Multiple Row Query
-- Correlated subqueries

-- 	DDL - Data Definition Language (set up and configure a new database), (CREATE, ALTER, DROP)
--	DML - Data Manipulation Language (to access or manipulate data), (SELECT, INSERT, UPDATE, DELETE)
--	DCL - Data Control Language (used to grant or revoke access control), (REVOKE, GRANT)
--	TCL - Transaction Control Language (controls the transactions of DML and DDL), (BEGIN, COMMIT)

------Data Types-----
-- String
-- Date and Time
-- Numeric

------String Data Types-----
-- CHAR 
-- VARCHAR
-- BINARY
-- VARBINARY
-- BLOB
-- TEXT
-- ENUM
-- SET

------Date and Time Data Types-----
-- DATE 
-- DATETIME
-- TIMESTAMP
-- YEAR

------Numeric Data Types-----

-- INTEGER OR INT
-- SMALLINT
-- TINYINT
-- MEDIUMINT
-- BIGINT
-- FLOAT
-- DOUBLE
-- FIXED
-- DECIMAL
-- NUMERIC

------ CONSTRAINTS ------
-- NOT NULL
-- DEFAULT
-- UNIQUE
-- PRIMARY KEY
-- FOREIGN KEY

-- Create Table

drop table if exists vacation_plan;
create table vacation_plan (place_id INT primary key,
							Country VARCHAR(20),
							hotel_name CHAR (20) NOT NULL,
							EmployeeId INT,
							Vacation_length INT,
							budget REAL,
							foreign key (EmployeeId)
							references employees (EmployeeId));

-- Load Table

insert into vacation_plan (place_id, country, hotel_name, EmployeeId, Vacation_length, budget)
values (1,'Canada', 'Hilton', 1,5,10000),
	   (2,'USA','Sheraton',1,5,10000),
       (3,'Turkey','Erzincan_plus',1,8,500);

-- Alter Table
alter table vacation_plan
add city text;

alter table vacation_plan
rename to new_vacation_plan;

alter table new_vacation_plan
rename column city to state;

-- Drop Table

drop table employee

-- Inner Join

SELECT A.product_id, A.product_name, B.category_id, B.category_name
FROM production.products as A
inner join production.categories as B
ON A.category_id = B.category_id

-- Left Join

select a.product_id, a.product_name, b.category_id, b.category_name
from production.products a
left join production.categories b
on a.category_id = b.category_id

-- Right Join

select a.product_id, a.product_name, b.store_id, b.quantity
from production.products a
right join production.stocks b
on a.product_id = b.product_id
where a.product_id > 310

-- Full Outer Join

select a.product_id, store_id, order_id, list_price, b.quantity
from sales.order_items a
full outer join production.stocks b
on a.product_id = b.product_id

-- Cross Join

select *  
from production.brands
cross join production.categories
order by brand_id

-- Self Join

select a.first_name as stf_frst, a.last_name as stf_lst, b.first_name as mangr_frst
from sales.staffs a, sales.staffs b
where a.manager_id = b.staff_id;

------------------------------------------ 2nd Lesson ------------------------------------------

-- Group by and Having

select product_id, count(product_name) as cnt_prdcts
from production.products
group by product_id
having count(product_name) > 1

select a.brand_id, b.brand_name, avg(list_price) as avg_prc 
from production.products a, production.brands b
where a.brand_id = b.brand_id
group by a.brand_id, b.brand_name
having avg(list_price) > 1000
order by 3 asc;

-- Summary Table / Creating new Table with "Into"

SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year, 
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sales.sales_summary
FROM	sales.order_items A, production.products B, production.brands C, production.categories D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY C.brand_name, D.category_name, B.model_year

-- Grouping Sets

select Brand, Category, sum(total_sales_price)
from sales.sales_summary
group by grouping sets ((Brand), (Category), (Brand, Category), ())
order by Brand, Category;

-- Group by Rollup(c1,c2,c3) >>> (c1,c2,c3) + (c1,c2,NULL) + (C1,NULL,NULL), (NULL,NULL,NULL)

select Brand, Category, Model_Year, sum(total_sales_price)
from sales.sales_summary
group by rollup(Brand, Category, Model_Year)
order by 1,2,3

-- Group by Cube(c1,c2,c3) >> --(C1,C2,C3) +
							  --(C1,C2,NULL) + (C1,C3,NULL) +
                              --(C2,C3,NULL) + 
							  --(C1,NULL,NULL) + (C2,NULL,NULL) + (C3,NULL,NULL)
							  --(NULL,NULL,NULL)

select Brand, Category, Model_Year, sum(total_sales_price)
from sales.sales_summary
group by cube(Brand, Category, Model_Year)
order by 1,2,3;

--- Pivot / Add "model year" dimention

select Category, Model_Year, sum(total_sales_price)
from sales.sales_summary
group by Category, Model_Year

select *
from (select Category, Model_Year, total_sales_price from sales.sales_summary) as a
pivot (sum(total_sales_price) for Category in ([Children Bicycles],
												[Comfort Bicycles],
												[Cruisers Bicycles],
												[Cyclocross Bicycles],
												[Electric Bikes],
												[Mountain Bikes],
												[Road Bikes])) as pvt_table

------------------------------------------ 3th Lesson ------------------------------------------

--- Nested Queries

--- Single row subqueries
--- Multiple row subqueries
--- Correlated subqueries

-- Single row subqueries

select b.customer_id, first_name, last_name, a.order_date
from sales.orders a, sales.customers b
where a.customer_id=b.customer_id and order_date < (select order_date
													from sales.orders a, sales.customers b
													where a.customer_id=b.customer_id
													and b.first_name='Arla' and b.last_name='Ellis')

-- Multiple row subqueries

select *
from production.products
where category_id in (select category_id from production.categories where category_name like '%Bikes')
and list_price > any (select list_price
					  from production.products a, production.categories b
					  where a.category_id=b.category_id and category_name='Electric Bikes')

-- Correlated subqueries

-- With "in/not in"

select distinct(state)
from sales.customers
where state not in (select distinct(state)
					from production.products a, sales.order_items b, sales.orders c, sales.customers d 
					where a.product_id=b.product_id
					and b.order_id=c.order_id
					and c.customer_id=d.customer_id
					and a.product_name='Trek Remedy 9.8 - 2017')

-- With "exists / not exists"

-- exists

select distinct state
from sales.customers e
where exists (select distinct(d.state)
			  from production.products a, sales.order_items b, sales.orders c, sales.customers d 
			  where a.product_id=b.product_id
			  and b.order_id=c.order_id
			  and c.customer_id=d.customer_id
			  and a.product_name='Trek Remedy 9.8 - 2017'
			  and e.state=d.state);

-- not exists

select distinct state
from sales.customers e
where not exists (select distinct(d.state)
				  from production.products a, sales.order_items b, sales.orders c, sales.customers d 
				  where a.product_id=b.product_id
				  and b.order_id=c.order_id
				  and c.customer_id=d.customer_id
				  and a.product_name='Trek Remedy 9.8 - 2017'
				  and e.state=d.state);

-- view

-- View Tables are updated automatically when the tables that are making the view table are updated

create view view_table as
select first_name, last_name, order_date, product_name, model_year, quantity, list_price, final_price
from (select a.first_name, a.last_name, b.order_date, d.product_name, d.model_year,
			 c.quantity, c.list_price, c.list_price * (1-c.discount) final_price
	  from sales.customers a, sales.orders b, sales.order_items c, production.products d
	  where a.customer_id=b.customer_id and b.order_id=c.order_id and c.product_id=d.product_id) A;

select *
from view_table

-- Temporary tables >>> "into"

select first_name, last_name, order_date, product_name, model_year, quantity, list_price, final_price
into temporary_summary_table
from (select a.first_name, a.last_name, b.order_date, d.product_name, d.model_year,
			 c.quantity, c.list_price, c.list_price * (1-c.discount) final_price
	  from sales.customers a, sales.orders b, sales.order_items c, production.products d
	  where a.customer_id=b.customer_id and b.order_id=c.order_id and c.product_id=d.product_id) A;

------------------------------------------ 4th Lesson ------------------------------------------

--Ordinary CTE's
--List customers who have an order prior to the last order of a customer named Sharyn Hopkins and are residents of the city of San Diego.

with t1 as (select max(order_date) max_ord_date
			from sales.orders a, sales.customers b
			where a.customer_id = b.customer_id and first_name='Sharyn' and last_name='Hopkins')
select b.customer_id, first_name, last_name, a.order_date
from sales.orders a, sales.customers b, t1 c
where a.customer_id=b.customer_id
and a.order_date < max_ord_date
and b.city='San Diego';

-- Recursive CTE's
-- Create a table that has the rows 0 to 9
 
with t1 as (select 0 number
			union all
			select number+1
			from t1
			where number < 9)
select *
from t1

--CTE with new table Values

WITH Users As (SELECT * 
			   FROM (VALUES (1,'start', CAST('01-01-20' AS date)),
							(1,'cancel', CAST('01-02-20' AS date)), 
						 	(2,'start', CAST('01-03-20' AS date)), 
						 	(2,'publish', CAST('01-04-20' AS date)), 
						 	(3,'start', CAST('01-05-20' AS date)), 
						 	(3,'cancel', CAST('01-06-20' AS date)), 
						 	(1,'start', CAST('01-07-20' AS date)), 
							(1,'publish', CAST('01-08-20' AS date)))
				as table_1 ([user_id], [action], [date]))
SELECT * FROM Users

--------- Set Operations ---------
-- Union (Erase the same row)
-- Union all (Getting all rows although the same)
-- Intersection (Instead of join) (Important)
-- Except (Important)

-- Union
--List Customer's last names in Sacramento and Monroe

select last_name 
from sales.customers
where city='Sacramento'
union						-- 16 exit
select last_name 
from sales.customers
where city='Monroe'

-- Union all
select last_name 
from sales.customers
where city='Sacramento'
union all					-- 17 exit
select last_name 
from sales.customers
where city='Monroe'

--INTERSECT
-- Write a query that returns brands that have products for both 2016 and 2017.

-- with 'intersect'
select brand_id
from production.products
where model_year=2016
intersect
select brand_id
from production.products
where model_year=2017
order by brand_id;

-- EXCEPT
-- Write a query that returns brands that have a 2016 model product but not a 2017 model product.

select x.product_id, product_name, z.order_date
from production.products x, sales.order_items y, sales.orders z
where x.product_id=y.product_id and y.order_id=z.order_id
and  x.product_id in (select a.product_id
					  from sales.order_items a, sales.orders b
					  where a.order_id=b.order_id and b.order_date between '2017-01-01' and '2017-12-31'
					  except
				 	  select a.product_id
					  from sales.order_items a, sales.orders b
					  where a.order_id=b.order_id and b.order_date not between '2017-01-01' and '2017-12-31')
order by z.order_date desc

-- CASE EXPRESSION
-- Generate a new column containing what the mean of the values in the Order_Status column.
-- 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed

select customer_id, email,
	case 
		when email like '%gmail%' then 'Gmail'
		when email like '%hotmail%' then 'Hotmail'
		when email like '%yahoo%' then 'Yahoo'
	else
		'Other'
	end as email_prvd
from sales.customers

------------------------------------------ 5th Lesson ------------------------------------------

--https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/ 

-- Date and Time
-- Consruct Date and Time
-- Return Date or Time Parts
-- Return Date and Time Dif Val
-- Modify Date and Time Val
-- Validate Date and Time Val
-- Rturn System Date and Time Val

-- time				hh:mm:ss[.nnnnnnn]
-- date				YYYY-MM-DD
-- smalldatetime	YYYY-MM-DD hh:mm:ss
-- datetime			YYYY-MM-DD hh:mm:ss[.nnn]
-- datetime2		YYYY-MM-DD hh:mm:ss[.nnnnnnn]
-- datetimeoffset	YYYY-MM-DD hh:mm:ss[.nnnnnnn] [+|-]hh:mm

-- TIMEFROMPARTS
-- DATEFROMPARTS
-- DATETIMEFROMPARTS
-- DATETIMEOFFSETFROMPARTS

-- DATENAME >>> nvchar	>>> DATENAME(DW, ORDER_DATE)
-- DATEPART >>> int		>>> DATEPART(DAY, ORDER_DATE)
-- DAY		>>> int		>>> DAY(ORDER_DATE)
-- WEEK		>>> int		>>> WEEK(ORDER_DATE)
-- MONTH	>>> int		>>> MONTH(ORDER_DATE) 
-- YEAR		>>> int		>>> YEAR()

-- DATEDIFF (DAY, START_DATE, END_DATE)

-- DATEADD (DAY, NUMBER, DATE)
-- EOMONTH (START_DATE, [MONTH_TO_ADD])

-- ISDATE

-- CURRENT_TIMESTAMP
-- GETDATE ()
-- GETUTCDATE ()

------------------------------------------ 6th Lesson ------------------------------------------

-- Data Types

-- char		>>> 10 dersek herþey için 10 tutar
-- varchar	>>> 20 dedik, giriþ 5 char o zaman 5 yer tutat (var)
-- text		>>> uzun metinler için çok büyük karakterde
-- nchar	>>> unique karakter kullanýlabilir ð, ü ...
-- nvchar	>>> unique karakter kullanýlabilir ð, ü ...
-- ntext	>>> unique karakter kullanýlabilir ð, ü ...

-- LEN				>>>	select len(email)
-- CHARINDEX		>>> select charindex ('c', email)
-- PATINDEX			>>> select patindex ('%r%', email)
-- LEFT				>>> select left (email, 3)
-- RIGHT			>>> select right (email, 3)
-- SUBSTRING		>>> select substring (email, -2, 5)
-- LOWER			>>> select lower (email)
-- UPPER			>>> select upper (email)
-- STRING_SPLIT		>>> select * from string_split (email, ',')
-- +				>>> select upper (left(email, 1)) + right (email, len(email)-1)
-- TRIM				>>> select trim (email)
-- LTRIM			>>> select ltrim (email)
-- RTRIM			>>> select rtrim (email)
-- REPLACE			>>> select replace (email, 'RAc', ' ')
-- STR				>>> select str (email, 7, 3)
-- CAST				>>> select cast (email as VARCHAR(6))
-- CONVERT			>>> select convert (INT, email)
-- COALESCE			>>> select coalesce (phone, email)
-- NULLIF			>>> select nullif (first_name, 'Debra')
-- ROUND			>>> select round (phone, 2, 0)

-- MAC ve WIN da database oluþturduk.
-- Bu database içine hazýr xlsx veya csv dosyalarýný tablo olarak ekledik
-- Bu arada primary key veya date format seçimi yapýp farklý kaydedip ekledik
-- Özellikle MAC azure studio üzerinde csv olan dosyalarý tablo olarak ekledik FARKLI KAYDEDEREK
-- Bu arada csv farklý kaydettik

------------------------------------------ 7th Lesson ------------------------------------------

-- Window Functions

-- WF vs GROUP BY
								-- GROUP BY				-- WF
   -- Distinct					necessity				optional
   -- Aggregating				necessity				optional
   -- Ordering					invalid					valid
   -- Performance				slower					faster
   -- Dependency on Select		dependent				independent

-- Types of WF
   -- Aggregation Functions	>>>	min(), max(), sum(), avg(), count()
   -- Navigation Functions	>>>	first_value(), last_value, lead(), lag()
   -- Numbering Functions	>>>	row_number(), rank(), dense_rank()	///	ntile(), cume_dist(), percent_rank()

-- WF Syntax and Keywords
   -- SELECT *, AVG(time) OVER (PARTITION BY time ORDER BY date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS avg_time
   -- from time_sales
   
   -- PARTITION		>>>		-- UNBOUNDED PRECEDING	>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
							-- N PRECEDING			>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
							-- N ROWS				>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
							-- CURRENT ROW --		>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
							-- M ROWS				>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
							-- M FOLLOWING			>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
							-- UNBOUNDED FOLLOWING	>>> ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
-- Window Frames
-- How to apply WF

-- ANALYTIC AGGREGATE FUNCTIONS
   -- MIN()		>>>	select min(list_price) over (partition by category_id order by list_price) as xyz
   -- MAX()		>>>	select max(list_price) over (partition by category_id order by list_price) as xyz
   -- AVG()		>>>	select avg(list_price) over (partition by category_id order by list_price) as xyz
   -- SUM()		>>>	select sum(list_price) over (partition by category_id order by list_price) as xyz
   -- COUNT()	>>>	select count(list_price) over (partition by category_id order by list_price) as xyz

-- ANALYTIC NAVIGATION FUNCTIONS
   -- first_value()	>>>	select first_value(list_price) over (partition by category_id order by list_price) as xyz
   -- last_value()	>>>	select last_value(list_price) over (partition by category_id order by list_price rows between unbounded preceding and unbounded following) as xyz
   -- lead()		>>>	select lead(list_price) over (partition by category_id order by list_price) as xyz
   -- lag()			>>>	select lag(list_price) over (partition by category_id order by list_price) as xyz

-- ANALYTIC NUMBERING FUNCTIONS
   -- ROW_NUMBER()		>>>	select row_number() over (partition by category_id order by list_price) as xyz
   -- RANK()			>>>	select rank() over (partition by category_id order by list_price) as xyz
   -- DENSE_RANK()		>>>	select dense_rank() over (partition by category_id order by list_price) as xyz
   -- CUME_DIST()		>>>	select cume_dist() over (partition by category_id order by list_price) as xyz
   --					>>> En yüksek deðere 1 verir // Tekrar edenleri tekrarý kadar hesaba katar
   -- PERCENT_RANK()	>>>	select percent_rank() over (partition by category_id order by list_price) as xyz
   --					>>> En düþük deðere 0 verir // Tekrar edenleri sadece 1 kere hesaba katar
   -- NTILE()			>>>	select ntile() over (partition by category_id order by list_price) as xyz



--///////////////////////////////////////////// LESSON BASE SUMMARY ////////////////////////////////////////////



-- select round(value, 2)	>>> 50.52
-- select ceiling(value)	>>> 51
-- select floor(value)		>>> 50

