-----------------DAwSQL Lab 3 2022-08-12------------

-- Find the weekly order count for the city of Baldwin for the last 8 weeks earlier from '2016-08-18', and also the cumulative total.
-- Desired output: [week, order_count, cuml_order_count]
-- Baldwin �ehrindeki '2016-08-18' tarihinden �nceki 8 haftaya ait sipari� say�lar�n� ve k�m�latif sipari� toplamlar�n� getiriniz.

select distinct datepart(week, order_date) week_num,
	   count(order_id) over(partition by datepart(week, order_date)) order_count,
	   count(order_id) over (order by  datepart(week, order_date)) cum_val
from sales.orders a, sales.stores b
where a.store_id=b.store_id
and b.city='Baldwin'
and a.order_date between dateadd(week, -8, '2016-08-17') and '2016-08-17'
 

select distinct
	   datepart(week, order_date) week_num,
	   count(order_id) over(partition by datepart(week, order_date)) order_count,
	   count(order_id) over(order by datepart(week, order_date)) cum_val
from sales.orders a, Sales.stores b  
where a.store_id = b.store_id
	  and b.city = 'Baldwin'
	  and a.order_date between dateadd(week, -8, '2016-08-17') and '2016-08-17'


select	Customer_id, Order_Date, B.product_id, A.order_id,
		dense_rank() over (partition by Customer_id order by Order_Date) historical_numerate,
		rank() over (partition by Customer_id order by Order_Date),
		row_number() OVER (partition by Customer_id order by Order_Date)
from	sales.orders a, 
		sales.order_items b
where	a.order_id=b.order_id

-- Write a query that returns customers who ordered the same product on two consecutive orders.
-- Expected output: customer_id, product_id, previous order date, next order date
-- Ayn� �r�n� iki ard���k sipari�te sipari� eden m��terileri d�nd�ren bir sorgu yaz�n.

with T1 as (select	Customer_id, Order_Date, b.product_id, a.order_id,
					dense_rank() over (partition by Customer_id order by Order_Date) historical_numerate
			from	sales.orders a, 
					sales.order_items b
			where	a.order_id=b.order_id),
	 T2 as (select	Customer_id, Order_Date, b.product_id, a.order_id,
					dense_rank() over (partition by Customer_id order by Order_Date) historical_numerate
			from	sales.orders a, 
					sales.order_items b
			where	a.order_id=b.order_id)
select	T2.customer_id,
		T2.product_id,
		T1.order_date,
		T1.order_id,
		T1.historical_numerate PREV_ORD,
		T2.order_date,
		T2.historical_numerate NEXT_ORD
from	T1, T2
where	T1.customer_id = T2.customer_id
		and T1.product_id = T2.product_id
		and T1.historical_numerate + 1 = T2.historical_numerate

-- CONTROL

select	Customer_id, Order_Date, b.product_id, a.order_id,
		dense_rank() over (partition by Customer_id order by Order_Date) historical_numerate
from	sales.orders a, 
		sales.order_items b
where	a.order_id=b.order_id and customer_id = 24

--

select	Customer_id, b.product_id,
		dense_rank() over (partition by Customer_id order by Order_Date) +1 historical_numerate
from	sales.orders a, 
		sales.order_items b
where	a.order_id=b.order_id
intersect
select	Customer_id, b.product_id,
		dense_rank() over (partition by Customer_id order by Order_Date) historical_numerate
from	sales.orders a, 
		sales.order_items b
where	a.order_id=b.order_id