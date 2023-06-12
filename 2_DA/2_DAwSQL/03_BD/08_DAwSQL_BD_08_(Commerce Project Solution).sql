
-- DAwSQL Session -8 10-08-2022
-- E-Commerce Project Solution

SELECT count(*) FROM cust_dimen;

SELECT count(*) FROM prod_dimen;

SELECT count(*) FROM orders_dimen;

SELECT count(*) FROM shipping_dimen;

SELECT count(*) FROM market_fact;

-- Join all the tables and create a new table called combined_table.
-- market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen

select *
into combined_table
from (select e.Cust_id, Customer_Name, Province, Region, Customer_Segment, 
             a.Ord_id, a.Prod_id, Sales, Discount, Order_Quantity, Product_Base_Margin,
             b.Order_Date, Order_Priority,
             d.Product_Category, Product_Sub_Category,
             c.Ship_id, Ship_Mode, Ship_Date
	  from market_fact a
		   inner join orders_dimen b on a.Ord_id=b.Ord_id
		   inner join shipping_dimen c on a.Ship_id=c.Ship_id
		   inner join prod_dimen d on a.Prod_id=d.Prod_id
		   inner join cust_dimen e on a.Cust_id=e.Cust_id) x;

select count(*)
from combined_table

-- Find the top 3 customers who have the maximum count of orders.

-- Method1
select top 3 a.Cust_id, count (b.Ord_id)
from cust_dimen a, market_fact b
where a.Cust_id=b.Cust_id
group by a.Cust_id
order by count (b.Ord_id) desc

-- Method2
select top 3 y.Cust_id, max(y.w)
from (select distinct Cust_id, count(Ord_id) over (partition by Cust_id order by Ord_id) as w
	  from market_fact) as y
group by y.Cust_id
order by max(y.w) desc

-- Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
-- Use "ALTER TABLE", "UPDATE" etc.

alter table combined_table
add DaysTakenForDelivery int

select *
from combined_table

update combined_table
set DaysTakenForDelivery=datediff(day, Order_Date, Ship_Date)

select DaysTakenForDelivery
from combined_table

-- Find the customer whose order took the maximum time to get delivered.
-- Use "MAX" or "TOP"

-- Method-1
select top 1 Customer_name, max(DaysTakenForDelivery) over (partition by Customer_name) as max_del
from combined_table
order by max_del desc

-- Method-2
select top 1 Customer_Name, DaysTakenForDelivery
from combined_table
order by DaysTakenForDelivery desc

-- Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
-- You can use such date functions and subqueries

select month(Order_Date), count(distinct Cust_id) as Mnth_Unq_Cus
from combined_table a
where exists (select distinct Cust_id
			  from combined_table b
			  where Order_Date between '2011-01-01' and '2011-01-31'
			  and a.Cust_id=b.Cust_id)
			  and Order_Date between '2011-01-01' and '2011-12-31'
group by month(Order_Date)

-- write a query to return for each user the time elapsed between the first purchasing and the third purchasing, 
-- in ascending order by Customer ID
-- Use "MIN" with Window Functions

select Cust_id, Ord_id, Order_Date, first_ord, dense_ord, datediff(day, first_ord, Order_Date) as dif_1th_orddate
from (select Cust_id, Ord_id, Order_Date,
		     min (Order_Date) over (partition by Cust_id) as first_ord,
		     dense_rank() over (partition by Cust_id order by Order_Date) as dense_ord
	  from combined_table) as w
where dense_ord=3

-- Write a query that returns customers who purchased both product 11 and product 14, 
-- as well as the ratio of these products to the total number of products purchased by the customer.
-- Use CASE Expression, CTE, CAST AND such Aggregate Functions

with t1 as (select Cust_id,
				   sum (case when Prod_id=11 then Order_Quantity else 0 end) as P_11,
		           sum (case when Prod_id=14 then Order_Quantity else 0 end) as P_14,
				   sum (case when Prod_id in (11,14) then Order_Quantity else 0 end) as P_11_14,
				   sum(Order_Quantity) as total_prd
			from combined_table
			group by Cust_id
			having sum (case when Prod_id=11 then Order_Quantity else 0 end) >= 1 and
				   sum (case when Prod_id=14 then Order_Quantity else 0 end) >= 1 and
				   sum (case when Prod_id in (11,14) then Order_Quantity else 0 end) >= 1)
select Cust_id, P_11, P_14, P_11_14, total_prd,
	   (100*P_11/total_prd) as P_11_Rat,
	   (100*P_14/total_prd) as P_14_Rat,
	   (100*P_11_14/total_prd) as P_11_14_Rat
from t1

--CUSTOMER RETENTION ANALYSIS

-- Create a view that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)
-- Use such date functions. Don't forget to call up columns you might need later.


drop view if exists customer_logs

create view customer_logs as

select Cust_id, year(Order_Date) [year], month(Order_Date) [month]
from combined_table

-- Create a view that keeps the number of monthly visits by users. (Separately for all months from the business beginning)
-- Don't forget to call up columns you might need later.

drop view if exists number_of_visits

create view number_of_visits as

select Cust_id, [year], [month], count(*) num_of_log
from	customer_logs
group by Cust_id, [year], [month]

-- For each visit of customers, create the next month of the visit as a separate column.
-- You can number the months with "DENSE_RANK" function.
-- then create a new column for each month showing the next month using the numbering you have made. (use "LEAD" function.)
-- Don't forget to call up columns you might need later.

drop view if exists next_visit

create view next_visit as

select *, lead(current_month, 1) over (partition by Cust_id order by current_month) next_visit_month
from (select  *, dense_rank () over (order by [year], [month]) current_month
	  from	number_of_visits) A

-- Calculate the monthly time gap between two consecutive visits by each customer.
-- Don't forget to call up columns you might need later.

drop view if exists time_gaps

create view time_gaps as

select *, (next_visit_month - current_month) time_gaps
from next_visit

-- Categorise customers using average time gaps. Choose the most fitted labeling model for you.
-- For example: 
-- Labeled as churn if the customer hasn't made another purchase in the months since they made their first purchase.
-- Labeled as regular if the customer has made a purchase every month.

select * from time_gaps

select cust_id, avg_time_gap,
	   case when avg_time_gap = 1 then 'retained' 
			when avg_time_gap > 1 then 'irregular'
			when avg_time_gap IS NULL then 'Churn'
			else 'unknown data'
	   end cust_labels
from( select Cust_id, avg(time_gaps) avg_time_gap
	  from	time_gaps
	  group by Cust_id) A

-- MONTH-WISE RETENTýON RATE

-- Find month-by-month customer retention rate  since the start of the business.
-- Find the number of customers retained month-wise. (You can use time gaps)

select	distinct cust_id, [year], [month], current_month, next_visit_month, time_gaps,
		count(cust_id)	over (partition by next_visit_month) retention_month_wise
from time_gaps
where time_gaps =1
order by cust_id, next_visit_month

-- Calculate the month-wise retention rate.
-- Basic formula: o	Month-Wise Retention Rate = 1.0 * Number of Customers Retained in The Next Nonth / Total Number of Customers in The Previous Month
-- It is easier to divide the operations into parts rather than in a single ad-hoc query. It is recommended to use View. 
-- You can also use CTE or Subquery if you want.
-- You should pay attention to the join type and join columns between your views or tables.


drop view if exists current_num_of_cust

create view current_num_of_cust as

select distinct cust_id, [year], [month], current_month,
	   count (cust_id)	over (partition by current_month) curr_cust
from time_gaps

select *
from current_num_of_cust

---

drop view if exists next_num_of_cust

create view next_num_of_cust as

select distinct cust_id, [year], [month], current_month, next_visit_month,
	   count (cust_id)	over (partition by current_month) next_cust
from time_gaps
where time_gaps = 1 and current_month > 1

select distinct b.[year], b.[month], b.current_month, round(1.0 * b.next_cust / a.curr_cust, 2) retention_rate 
from current_num_of_cust a
left join next_num_of_cust b
on a.current_month + 1 = b.next_visit_month