
-----10-08-2022 DAwSQL Lab 2------------

-- Select customers who have purchase both Children Bicycle and Comfort Bicycle on a single order. 
-- (expected columns: Customer id, first name, last name, order id)

-- Method 1
select e.customer_id, first_name, last_name, d.order_id,
	   sum(case when a.category_name='Children Bicycles' then 1 else 0 end) as chl_bcy,
	   sum(case when a.category_name='Comfort Bicycles' then 1 else 0 end) as com_bcy
from production.categories a,
	 production.products b,
	 sales.order_items c,
	 sales.orders d,
	 sales.customers e
where a.category_id=b.category_id
      and b.product_id=c.product_id
	  and c.order_id=d.order_id
	  and d.customer_id=e.customer_id
	  and a.category_name in ('Children Bicycles', 'Comfort Bicycles')
group by e.customer_id, first_name, last_name, d.order_id
having sum(case when a.category_name='Children Bicycles' then 1 else 0 end) >= 1 and
	   sum(case when a.category_name='Comfort Bicycles' then 1 else 0 end) >= 1
order by d.order_id

-- Method 2
select e.customer_id, first_name, last_name, d.order_id
from production.categories a,
	 production.products b,
	 sales.order_items c,
	 sales.orders d,
	 sales.customers e
where a.category_id=b.category_id
      and b.product_id=c.product_id
	  and c.order_id=d.order_id
	  and d.customer_id=e.customer_id
	  and a.category_name = 'Children Bicycles'
intersect
select e.customer_id, first_name, last_name, d.order_id
from production.categories a,
	 production.products b,
	 sales.order_items c,
	 sales.orders d,
	 sales.customers e
where a.category_id=b.category_id
      and b.product_id=c.product_id
	  and c.order_id=d.order_id
	  and d.customer_id=e.customer_id
	  and a.category_name = 'Comfort Bicycles'

-- Method 3
with cte_tbl as (select e.customer_id, first_name, last_name, d.order_id,
				        case when a.category_name in ('Children Bicycles', 'Comfort Bicycles') then 1 else 0 end as both_byc 
			 	 from production.categories a,
					  production.products b,
					  sales.order_items c,
					  sales.orders d,
					  sales.customers e
				 where a.category_id=b.category_id
					   and b.product_id=c.product_id
					   and c.order_id=d.order_id
					   and d.customer_id=e.customer_id)
select cte_tbl.customer_id, first_name, last_name, order_id, both_byc
from cte_tbl
where both_byc=1