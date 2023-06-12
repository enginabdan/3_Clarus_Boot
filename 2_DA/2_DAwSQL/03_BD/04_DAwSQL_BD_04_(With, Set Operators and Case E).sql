/*        05.08.2022 DAwSQL Session 4 -- Set Operators and Case Expression     */

--CTE's
--Ordinary CTE's

--List customers who have an order prior to the last order of a customer named Sharyn Hopkins 
--and are residents of the city of San Diego.

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

--UNION / UNION ALL
--List Customer's last names in Sacramento and Monroe

-- Union

select last_name 
from sales.customers
where city='Sacramento'
union						-- 16 exit
select last_name 
from sales.customers
where city='Monroe'

select first_name, last_name 
from sales.customers
where city='Sacramento'
union						-- 17 exit
select first_name, last_name 
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

select city
from sales.stores
union all					-- Kind is the same and concats
select state
from sales.stores

select city, 'state' as state 
from sales.stores
union all					-- Number of col not the same not concat
select state,
from sales.stores

select city, 'state' as state 
from sales.stores
union all					-- Kind is the same and concats
select state, 'ahmet' as name
from sales.stores

select city, 'state' as state 
from sales.stores
union all					-- Kind is not the same not concat
select state, 1 as num
from sales.stores

--INTERSECT
-- Write a query that returns brands that have products for both 2016 and 2017.

-- with 'or'
select a.brand_id, brand_name, b.product_name, model_year
from production.brands a, production.products b
where model_year=2016 or model_year=2017;

-- with 'in'
select a.brand_id, brand_name, b.product_name, model_year
from production.brands a, production.products b
where model_year in (2016, 2017);

-- with union
select a.brand_id, brand_name, b.product_name, model_year
from production.brands a, production.products b
where model_year=2016
union
select a.brand_id, brand_name, b.product_name, model_year
from production.brands a, production.products b
where model_year=2017;

-- with union all
select a.brand_id, brand_name, b.product_name, model_year
from production.brands a, production.products b
where model_year=2016
union all
select a.brand_id, brand_name, b.product_name, model_year
from production.brands a, production.products b
where model_year=2017;

-- with 'with'
with t1 as (select a.brand_id, brand_name, b.product_name, model_year
			from production.brands a, production.products b
			where model_year=2016
			union all
			select a.brand_id, brand_name, b.product_name, model_year
			from production.brands a, production.products b
			where model_year=2017)
select product_name, COUNT(product_name) as cnt_prd
from t1
where brand_name='Haro'
group by product_name
having COUNT(product_name) > 1
order by product_name;

-- with 'intersect'
select brand_id
from production.products
where model_year=2016
intersect
select brand_id
from production.products
where model_year=2017
order by brand_id;

-- with 'exists'
select brand_id
from production.products a 
where exists (select brand_id
			  from production.products b
			  where model_year=2016
			  intersect
			  select brand_id
			  from production.products b
			  where model_year=2017
			  and a.brand_id=b.brand_id)
group by brand_id
order by brand_id;

-- with 'not exists'
select brand_id
from production.products a 
where not exists (select brand_id
				  from production.products b
				  where model_year=2016
				  intersect
				  select brand_id
				  from production.products b
				  where model_year=2017
				  and a.brand_id=b.brand_id)
group by brand_id
order by brand_id;

-- pivot table

select state, count(state) as cnt_state
from sales.customers
group by state

select *
from (select state from sales.customers) as b
pivot (count(state) for state in ([TX],[NY],[CA])) as state_table

-- Write a query that returns customers who have orders for both 2016, 2017, and 2018

select a.customer_id
from sales.customers a, sales.orders b
where a.customer_id=b.customer_id
and order_date between '2016-01-01' and '2016-12-31'
and order_date between '2017-01-01' and '2017-12-31'
and order_date between '2018-01-01' and '2018-12-31'
order by order_date;

select a.customer_id
from sales.customers a, sales.orders b
where a.customer_id=b.customer_id
and order_date between '2016-01-01' and '2016-12-31'
intersect
select a.customer_id
from sales.customers a, sales.orders b
where a.customer_id=b.customer_id
and order_date between '2017-01-01' and '2017-12-31'
intersect
select a.customer_id
from sales.customers a, sales.orders b
where a.customer_id=b.customer_id
and order_date between '2018-01-01' and '2018-12-31';

-- EXCEPT
-- Write a query that returns brands that have a 2016 model product but not a 2017 model product.

select brand_id, brand_name
from production.brands
where brand_id in (select brand_id
				   from production.products
				   where model_year=2016
				   except
				   select brand_id
				   from production.products
				   where model_year=2017)

-- Write a query that returns only products ordered in 2017 (not ordered in other years)

select distinct a.product_id
from production.products a, sales.order_items b, sales.orders c
where a.product_id=b.product_id and b.order_id=c.order_id and c.order_date between '2017-01-01' and '2017-12-31'
except
select distinct a.product_id
from production.products a, sales.order_items b, sales.orders c
where a.product_id=b.product_id and b.order_id=c.order_id and c.order_date not between '2017-01-01' and '2017-12-31'

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

-- Write a query that returns State where 'Trek Remedy 9.8 - 2017' product is not ordered

select e.state, count(d.product_id) cnt_prdcts
from (select c.order_id, customer_id, b.product_id
	  from production.products a, sales.order_items b, sales.orders c
	  where a.product_id=b.product_id and b.order_id=c.order_id and a.product_name='Trek Remedy 9.8 - 2017') d
right join sales.customers e on d.customer_id=e.customer_id
group by e.state
--having count(d.product_id) = 0 (FOR NOT ORDERED)

----

select distinct state
from sales.customers x
where not exists(select	d.state
				 from	production.products a, sales.order_items b, sales.orders c, sales.customers d
				 where	a.product_id = b.product_id
				 and	b.order_id = c.order_id
				 and	c.customer_id = d.customer_id
				 and	a.product_name = 'Trek Remedy 9.8 - 2017'
				 and	d.state = x.state)

---

select state
from sales.customers
except
select d.state
from production.products a, sales.order_items b, sales.orders c, sales.customers d
where a.product_id = b.product_id
and	b.order_id = c.order_id
and	c.customer_id = d.customer_id
and	a.product_name = 'Trek Remedy 9.8 - 2017'

-- CASE EXPRESSION
-- Generate a new column containing what the mean of the values in the Order_Status column.
-- 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed

select order_status,
	case order_status
		when 1 then 'Pending'
		when 2 then 'Processing'
		when 3 then 'Rejected'
		when 4 then 'Completed'
	end as mean_status
from sales.orders

-- Create a new column containing the labels of the customers' email service providers ( "Gmail", "Hotmail", "Yahoo" or "Other" )

select customer_id, email,
	case 
		when email like '%gmail%' then 'Gmail'
		when email like '%hotmail%' then 'Hotmail'
		when email like '%yahoo%' then 'Yahoo'
	else
		'Other'
	end as email_prvd
from sales.customers

-- List customers who bought both 'Electric Bikes' and 'Comfort Bicycles' and 'Children Bicycles' in the same order.

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