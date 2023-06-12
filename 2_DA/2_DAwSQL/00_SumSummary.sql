
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