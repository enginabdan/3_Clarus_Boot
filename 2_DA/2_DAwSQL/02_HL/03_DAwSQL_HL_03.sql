-----------------DAwSQL Lab 3 2021-08-10------------

-- 1. Find the weekly order count for the city of Baldwin for the last 8 weeks earlier from '2016-08-18', and also the cumulative total.
-- Desired output: [week, order_count, cuml_order_count]
-- Baldwin �ehrindeki '2016-08-18' tarihinden �nceki 8 haftaya ait sipari� say�lar�n� ve k�m�latif sipari� toplamlar�n� getiriniz.

SELECT DISTINCT
	   DATEPART(WEEK, order_date) Week_Num,
	   COUNT(order_id) OVER(PARTITION BY DATEPART(WEEK, order_date)) Order_Count,
	   COUNT(order_id) OVER(ORDER BY DATEPART(WEEK, order_date)) Cumil_Value
FROM sales.orders A, Sales.stores B  
WHERE A.store_id = B.store_id AND
	  B.city = 'Baldwin' AND
	  A.order_date BETWEEN DATEADD(WEEK, -8, '2016-08-17') AND '2016-08-17'


SELECT	Customer_id, Order_Date, B.product_id, A.order_id,
		DENSE_RANK() OVER (PARTITION BY Customer_id ORDER BY Order_Date) historical_numerate,
		RANK() OVER (PARTITION BY Customer_id ORDER BY Order_Date),
		ROW_NUMBER() OVER (PARTITION BY Customer_id ORDER BY Order_Date)
FROM	sales.orders A, 
		sales.order_items B
WHERE	A.order_id=B.order_id

-- 2. Write a query that returns customers who ordered the same product on two consecutive orders.
-- Expected output: customer_id, product_id, previous order date, next order date
-- 2. Ayn� �r�n� iki ard���k sipari�te sipari� eden m��terileri d�nd�ren bir sorgu yaz�n.

WITH T1 AS (SELECT	Customer_id, Order_Date, B.product_id, A.order_id,
					DENSE_RANK() OVER (PARTITION BY Customer_id ORDER BY Order_Date) historical_numerate
			FROM	sales.orders A, 
					sales.order_items B
			WHERE	A.order_id=B.order_id),
	 T2 AS (SELECT	Customer_id, Order_Date, B.product_id, A.order_id,
					DENSE_RANK() OVER (PARTITION BY Customer_id ORDER BY Order_Date) historical_numerate
			FROM	sales.orders A, 
					sales.order_items B
			WHERE	A.order_id=B.order_id)
SELECT	T2.customer_id,
		T2.product_id,
		T1.order_date,
		T1.order_id,
		T1.historical_numerate PREV_ORD,
		T2.order_date,
		T2.historical_numerate NEXT_ORD
FROM	T1, T2
WHERE	T1.customer_id = T2.customer_id AND
		T1.product_id = T2.product_id AND
		T1.historical_numerate + 1 = T2.historical_numerate

--CONTROL

SELECT	Customer_id, Order_Date, B.product_id, A.order_id,
		DENSE_RANK() OVER (PARTITION BY Customer_id ORDER BY Order_Date) historical_numerate
FROM	sales.orders A, 
		sales.order_items B
WHERE	A.order_id=B.order_id AND customer_id = 24

--

SELECT	Customer_id, B.product_id,
		DENSE_RANK() OVER (PARTITION BY Customer_id ORDER BY Order_Date) +1 historical_numerate
FROM	sales.orders A, 
		sales.order_items B
WHERE	A.order_id=B.order_id
INTERSECT
SELECT	Customer_id, B.product_id,
		DENSE_RANK() OVER (PARTITION BY Customer_id ORDER BY Order_Date) historical_numerate
FROM	sales.orders A, 
		sales.order_items B
WHERE	A.order_id=B.order_id