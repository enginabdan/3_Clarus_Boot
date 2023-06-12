
------------- 07-08-2022 DAwSQL Session 5 (Data Functions) -------------

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

-- DATEFROMPARTS
-- DATETIMEFROMPARTS
-- DATETIMEOFFSETFROMPARTS
-- TIMEFROMPARTS

-- DATENAME >>> nvchar
-- DATEPART >>> int
-- DAY		>>> int 
-- MONTH	>>> int
-- YEAR		>>> int

-- DATEDIFF (DAY, START_DATE, END_DATE)

-- DATEADD (DAY, NUMBER, DATE)
-- EOMONTH (START_DATE, [MONTH_TO_ADD])

-- ISDATE

-- CURRENT_TIMESTAMP
-- GETDATE ()
-- GETUTCDATE ()

-- List customers who bought both 'Electric Bikes' and 'Comfort Bicycles' and 'Children Bicycles' in the same order.
-- SET OPERATORS

select b.customer_id, first_name, last_name 
from sales.orders a, sales.customers b
where a.customer_id=b.customer_id
and a.order_id in (select order_id
					from production.products a, sales.order_items b
					where a.product_id=b.product_id and a.category_id=(select category_id
																		from production.categories
																		where category_name='Electric Bikes')
					intersect
					select order_id
					from production.products a, sales.order_items b
					where a.product_id=b.product_id and a.category_id=(select category_id
																		from production.categories
																		where category_name='Comfort Bicycles')
					intersect
					select order_id
					from production.products a, sales.order_items b
					where a.product_id=b.product_id and a.category_id=(select category_id
																		from production.categories
																		where category_name='Children Bicycles'))

create table t_date_time (A_time time,
						  A_date date,
						  A_smalldatetime smalldatetime,
						  A_datetime datetime,
						  A_datetime2 datetime2,
						  A_datetimeoffset datetimeoffset)

select *
from t_date_time

insert t_date_time (A_time, A_date, A_smalldatetime, A_datetime, A_datetime2, A_datetimeoffset)
values ('12:00:00', '2021-07-17', '2021-07-17','2021-07-17', '2021-07-17', '2021-07-17' )

select *
from t_date_time

-- TIMEFROMPARTS / ...

insert t_date_time (A_time)
values (TIMEFROMPARTS(12,0,0,0,0));

select *
from t_date_time

insert t_date_time (A_date)
values (DATEFROMPARTS(2021,05,17));

select *
from t_date_time

insert t_date_time (A_datetime)
values (DATETIMEFROMPARTS(2021,05,17,20,0,0,0))

select *
from t_date_time

insert t_date_time (A_datetimeoffset)
values (DATETIMEOFFSETFROMPARTS(2021,05,17,20,0,0,0,2,0,0))

select *
from t_date_time

-- DATEPART / DAY() ...

select A_date,
	   DATENAME(DW, A_date) [Day1],
	   DAY(A_date) [Day2],
	   MONTH(A_date) [Month],
	   YEAR(A_date) [Year],
	   A_time,
	   DATEPART (HOUR, A_time),
	   DATEPART (MINUTE, A_time),
	   DATEPART (SECOND, A_time),
	   DATEPART (NANOSECOND, A_time),
	   DATEPART (YEAR, A_date),
	   DATEPART (MONTH, A_date),
	   DATEPART (WEEK, A_date),
	   DATEPART (DAY, A_date),
	   DATEPART (WEEKDAY, A_date)
from t_date_time

-- DATEDIFF

select A_date, A_time, datediff (day, A_date, A_time)
from t_date_time

select order_date, shipped_date, required_date,
	   datediff (day, order_date, shipped_date) resp_day,
	   datediff (day, shipped_date, required_date) delay_day
from sales.orders

-- DATEADD

select order_date,
	   dateadd (year, 5, order_date) ord_dt_year,
	   dateadd (month, -5, order_date) ord_dt_month,
	   dateadd (week, 5, order_date) ord_dt_week,
	   dateadd (day, -5, order_date) ord_dt_day
from sales.orders

-- EOMONTH

select order_date, shipped_date, required_date,
	   eomonth (order_date) ord_eom,
	   eomonth (shipped_date) shp_eom,
	   eomonth (required_date) req_eom,
	   eomonth (dateadd (day, datediff (day, order_date, shipped_date), shipped_date)) shp_pls_eom
from sales.orders

-- ISDATE

select order_date, isdate (order_date)
from sales.orders

select order_date, isdate(cast(order_date as varchar))
from sales.orders

select isdate('20120325')

select isdate('engin')

select isdate('monday')

select isdate('july')

-- CURRENT_TIMESTAMP

select current_timestamp

-- GETDATE ()

select getdate()

-- GETUTCDATE

select getutcdate()

select  *
from t_date_time

insert t_date_time
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

select  *
from t_date_time

/*
Question: Create a new column that contains labels of the shipping speed of products.

If the product has not been shipped yet, it will be marked as "Not Shipped",
If the product was shipped on the day of order, it will be labeled as "Fast".
If the product is shipped no later than two days after the order day, it will be labeled as "Normal"
If the product was shipped three or more days after the day of order, it will be labeled as "Slow".
*/

select order_date, shipped_date,
	   datediff(day, order_date, shipped_date) datedif,
	   case
			when CAST(datediff (day, shipped_date, getdate()) as varchar) is NULL  then 'Not Shipped'
		 -- when datediff (day, order_date, shipped_date) > 4 then 'Not Shipped'
			when datediff (day, order_date, shipped_date) = 0 then 'Fast'
			when datediff (day, order_date, shipped_date) < 3 then 'Normal'
			when datediff (day, order_date, shipped_date) > 2 then 'Slow'
	   end as ship_status
from sales.orders
order by datedif

--Write a query returning orders that are shipped more than two days after the ordered date. 

select order_id, order_date, shipped_date,
	   datediff (day, order_date, shipped_date) as shp_mor_2_days
from sales.orders
where datediff (day, order_date, shipped_date) > 2
order by order_date desc

-- Write a query that returns the number distributions of the orders in the previous query result,
-- according to the days of the week.

SELECT	SUM(CASE WHEN DATENAME (DW, order_date) = 'Monday' THEN 1 ELSE 0 END) AS Monday,
		SUM(CASE WHEN DATENAME (DW, order_date) = 'Tuesday' THEN 1 ELSE 0 END) AS Tuesday,
		SUM(CASE WHEN DATENAME (DW, order_date) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
		SUM(CASE WHEN DATENAME (DW, order_date) = 'Thursday' THEN 1 ELSE 0 END) AS Thursday,
		SUM(CASE WHEN DATENAME (DW, order_date) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
		SUM(CASE WHEN DATENAME (DW, order_date) = 'Saturday' THEN 1 ELSE 0 END) AS Saturday,
		SUM(CASE WHEN DATENAME (DW, order_date) = 'Sunday' THEN 1 ELSE 0 END) AS Sunday
FROM	sales.orders
WHERE	DATEDIFF(DAY, order_date, shipped_date) > 2

--Write a query that returns the order numbers of the states by months.

select a.state, year(b.order_date) [year], month(b.order_date) [month], count (distinct b.order_id) num_ord
from sales.customers a, sales.orders b
where a.customer_id=b.customer_id
group by a.state, year(b.order_date), month(b.order_date)
order by a.state, year(b.order_date), month(b.order_date)

select a.state, month(b.order_date) [month], count (distinct b.order_id) num_ord
from sales.customers a, sales.orders b
where a.customer_id=b.customer_id
group by a.state, month(b.order_date)
order by a.state, month(b.order_date)