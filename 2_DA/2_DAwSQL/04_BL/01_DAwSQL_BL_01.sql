
----------- 08.08.2022 DAwSQL Lab 1 ---------

--Write a query that returns the average prices according to brands and categories.

select a.category_id, b.brand_id, avg(list_price) as avg_prc
from production.products a, production.brands b
where a.brand_id = b.brand_id
group by a.category_id, b.brand_id
order by a.category_id, b.brand_id

--Write a query that returns the store which has the most sales quantity in 2016.

-- Method-1
select top 1 c.store_id, store_name, sum(a.quantity) as tot_qnt
from sales.order_items a, sales.orders b, sales.stores c
where a.order_id=b.order_id and b.store_id=c.store_id and b.order_date > '2015-12-30' and b.order_date < '2017-01-01'
group by c.store_id, c.store_name
order by tot_qnt desc

-- Method-2
select top 1 c.store_id, store_name, sum(a.quantity) as tot_qnt
from sales.order_items a, sales.orders b, sales.stores c
where a.order_id=b.order_id and b.store_id=c.store_id and b.order_date like '%2016%'
group by c.store_id, c.store_name
order by tot_qnt desc

--Write a query that returns State where 'Trek Remedy 9.8 - 2017' product is not ordered

SELECT E.state, COUNT (product_id) CNT_PRODUCT
FROM (SELECT C.order_id, C.customer_id, A.product_id, product_name
	  FROM	production.products A, sales.order_items B, sales.orders C
	  WHERE	A.product_id = B.product_id
	  AND	B.order_id = C.order_id
	  AND	A.product_name = 'Trek Remedy 9.8 - 2017') D
RIGHT JOIN SALES.customers E ON D.customer_id = E.customer_id
GROUP BY E.state
HAVING COUNT (product_id) = 0

-- Method-1
select e.state, count(product_id) cnt_prd
from (select c.order_id, customer_id, a.product_id, product_name
	  from production.products a, sales.order_items b, sales.orders c
	  where a.product_id=b.product_id and b.order_id=c.order_id and a.product_name='Trek Remedy 9.8 - 2017') as d
right join sales.customers e on d.customer_id=e.customer_id
group by e.state
having count(product_id) = 0