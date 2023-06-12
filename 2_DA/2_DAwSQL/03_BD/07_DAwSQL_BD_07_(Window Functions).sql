
----------- 08-08-2022 DAwSQL Session 7 Window Functions------------

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

-- ///////////////////////////////////////////////////////////

-- �r�nlerin stock say�lar�n� bulunuz

select product_id, sum(quantity) as prd_qtty
from production.stocks
group by product_id
order by product_id

select product_id,
	   sum(quantity)
	   over (partition by product_id order by product_id rows between unbounded preceding and unbounded following)
	   as prd_qtty
from production.stocks

-- Markalara g�re ortalama bisiklet fiyatlar�n� hem Group By hem de Window Functions ile hesaplay�n�z.

select distinct a.brand_id,
	   avg(b.list_price)
	   over (partition by a.brand_id
			 order by a.brand_id
			 rows between unbounded preceding and unbounded following) as avg_prc
from production.brands a, production.products b
where a.brand_id=b.brand_id;

select a.brand_id, avg(b.list_price)
from production.brands a, production.products b
where a.brand_id=b.brand_id
group by a.brand_id
order by a.brand_id;

-- ANALYTIC AGGREGATE FUNCTIONS
   -- MIN()
   -- MAX()
   -- AVG()
   -- SUM()
   -- COUNT()

-- T�m bisikletler aras�nda en ucuz bisikletin fiyat�

select product_id, min(list_price) as min_prc
from production.products
group by product_id
order by min(list_price)

select top 2 product_id, min(list_price) over () as min_prc
from production.products

-- Herbir kategorideki en ucuz bisikletin fiyat�

select b.category_id, min (a.list_price) min_prc
from production.products a, production.categories b
where a.category_id = b.category_id
group by b.category_id

select distinct b.category_id, min (a.list_price) over (partition by b.category_id) min_prc
from production.products a, production.categories b
where a.category_id = b.category_id

-- Products tablosunda toplam ka� fakl� bisikletin bulundu�u
select count(distinct product_id) as sum_prd
from production.products

select distinct count(product_id) over () as sum_prd
from production.products

-- Order_items tablosunda toplam ka� farkl� bisiklet oldu�u

select count(distinct product_id) as sum_prd
from sales.order_items

select distinct count (product_id) over () as sum_prd
from (select distinct product_id from sales.order_items) as a

-- Herbir kategoride toplam ka� farkl� bisikletin bulundu�u

select category_id, count(product_id) as sum_prd
from production.products
group by category_id

select distinct category_id, count(product_id) over (partition by category_id) as sum_prd
from production.products

-- Herbir kategorideki herbir markada ka� farkl� bisikletin bulundu�u

select a.category_id, b.brand_id, count (a.product_id) as sum_prd
from production.products a, production.brands b
where a.brand_id = b.brand_id
group by a.category_id, b.brand_id
order by a.category_id, b.brand_id

select distinct a.category_id, b.brand_id,
	   count (a.product_id)
	   over (partition by a.category_id, b.brand_id order by a.category_id, b.brand_id) as sum_prd
from production.products a, production.brands b
where a.brand_id = b.brand_id

-- WF ile tek select' te herbir kategoride ka� farkl� marka oldu�unu hesaplayabilir miyiz?

select distinct category_id, count (brand_id) over (partition by category_id order by category_id) as sum_brnd
from production.products

select distinct category_id, count (brand_id) over (partition by category_id order by category_id) as sum_brnd
from (select distinct category_id, brand_id from production.products) as A

-- ANALYTIC NAVIGATION FUNCTIONS
   -- first_value()
   -- last_value()
   -- lead()
   -- lag()

-- Herbir personelin bir �nceki sat���n�n sipari� tarihini yazd�r�n�z (LAG fonksiyonunu kullan�n�z)

select staff_id, store_id, lag(order_date, 1) over (partition by staff_id order by staff_id, store_id) as lag_ord
from sales.orders

-- Herbir personelin bir sonraki sat���n�n sipari� tarihini yazd�r�n�z (LEAD fonksiyonunu kullan�n�z)

select staff_id, store_id, lead(order_date, 1) over (partition by staff_id order by staff_id, store_id) as lead_ord
from sales.orders

-- Window Frame

SELECT COUNT (*) OVER () TOTAL_ROW
from production.products


SELECT  DISTINCT category_id,  
		COUNT (*) OVER () TOTAL_ROW,
		COUNT (*) OVER (PARTITION BY category_id) num_of_row,
		COUNT (*) OVER (PARTITION BY category_id ORDER BY product_id) num_of_row
from	production.products


SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) prev_with_current
from	production.products


SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id


SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id


SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id


SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id


SELECT	category_id,
		COUNT(*) OVER(ORDER BY product_id ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id

-- T�m bisikletler aras�nda en ucuz bisikletin ad� (FIRST_VALUE fonksiyonunu kullan�n�z)

select distinct first_value(product_name) over (order by list_price) as frst_name
from production.products

-- �r�n�n yan�na list price' �n� nas�l eklersiniz?

select distinct first_value(product_name) over (order by list_price) as frst_name,
	   first_value(list_price) over (order by list_price) as frst_val
from production.products

-- Herbir kategorideki en ucuz bisikletin ad� (FIRST_VALUE fonksiyonunu kullan�n�z)

select distinct category_id,
	   first_value (product_name) over (partition by category_id order by list_price) as frst_name
from production.products

-- Herbir kategorideki en ucuz bisikletin ad� ve fiyat� (FIRST_VALUE fonksiyonunu kullan�n�z)

select distinct category_id,
	   first_value (product_name) over (partition by category_id order by list_price) as frst_name,
	   first_value(list_price) over (partition by category_id order by list_price) as frst_val       
from production.products

-- T�m bisikletler aras�nda en ucuz bisikletin ad� (LAST_VALUE fonksiyonunu kullan�n�z)

select distinct last_value (product_name) over (order by list_price desc rows between unbounded preceding and unbounded following) as frst_name
from production.products

-- ANALYTIC NUMBERING FUNCTIONS
   -- ROW_NUMBER()
   -- RANK()
   -- DENSE_RANK()
   -- CUME_DIST()		>>> En y�ksek de�ere 1 verir // Tekrar edenleri tekrar� kadar hesaba katar
   -- PERCENT_RANK()	>>> En d���k de�ere 0 verir // Tekrar edenleri sadece 1 kere hesaba katar
   -- NTILE()

SELECT	category_id, list_price, 
		ROW_NUMBER () OVER (PARTITION BY category_id ORDER BY list_price) ROW_NUM,
		RANK () OVER (PARTITION BY category_id ORDER BY list_price) RANK_NUM,
		DENSE_RANK () OVER (PARTITION BY category_id ORDER BY list_price) DENSE_RANK_NUM,
		ROUND (CUME_DIST () OVER (PARTITION BY category_id ORDER BY list_price) , 2 ) CUM_DIST,
		ROUND (PERCENT_RANK () OVER (PARTITION BY category_id ORDER BY list_price) , 2 ) PERCENT_RNK,
		NTILE(4) OVER (PARTITION BY category_id ORDER BY list_price) ntil
FROM	production.products

-- ma�azalar�n 2016 y�l�na ait haftal�k hareketli sipari� say�lar�n� hesaplay�n�z

select distinct datepart (week, order_date) as ord_week,
	   count(datepart (week, order_date)) over (partition by datepart (week, order_date) order by datepart (week, order_date)) as ord_cnt
from sales.orders
where order_date > '2015-12-31' and order_date < '2017-01-01'  

-- '2016-03-12' ve '2016-04-12' aras�nda sat�lan �r�n say�s�n�n 7 g�nl�k hareketli ortalamas�n� hesaplay�n.

select distinct datepart (week, order_date)-11 as ord_week,
	   count(datepart (week, order_date)) over (partition by datepart (week, order_date) order by datepart (week, order_date)) as ord_cnt
from sales.orders
where order_date > '2016-03-12' and order_date < '2016-04-12' 