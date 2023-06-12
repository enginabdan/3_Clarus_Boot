--------DAwSQL 04.08.2022 Session 3 (Organize Complex Queries)-----

--Pivot

select Category, sum(total_sales_price)
from sales.sales_summary
group by Category

select *
from (select Category, total_sales_price from sales.sales_summary) as a
pivot (sum (total_sales_price) for Category in ([Children Bicycles],
												[Comfort Bicycles],
												[Cruisers Bicycles],
												[Cyclocross Bicycles],
												[Electric Bikes],
												[Mountain Bikes],
												[Road Bikes])) as pvt_table
												
----add model year dimention

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

-------------------//////////////////////////
------ SINGLE ROW SUBQUERIES ------
--Bring all the personnels from the store that Kali	Vargas works

select *
from sales.staffs

select store_id, first_name, last_name
from sales.staffs
--where first_name='Kali Vargas'

select staff_id, first_name, last_name
from sales.staffs
where store_id = (select store_id from sales.staffs where first_name='Kali' and last_name='Vargas')

---------List the staff that Venita Daniel is the manager of.

select staff_id
from sales.staffs
where first_name='Venita' and last_name='Daniel'

select *
from sales.staffs
where manager_id=(select staff_id from sales.staffs where first_name='Venita' and last_name='Daniel')

select a.*
from sales.staffs a, sales.staffs b
where a.manager_id = b.staff_id and b.first_name='Venita' and b.last_name='Daniel'

-------------Write a query that returns customers in the city where the 'Rowlett Bikes' store is located.

select city
from sales.stores
where store_name='Rowlett Bikes'

select *  
from sales.customers
where city=(select city from sales.stores where store_name='Rowlett Bikes')

--List bikes that are more expensive than the 'Trek CrossRip+ - 2018' bike.

select list_price
from production.products
where product_name='Trek CrossRip+ - 2018'

select category_id
from production.categories
where category_name in (Electric Bikes, Mountain Bikes, Road Bikes);

select a.*
from production.products a, production.categories b, production.categories c
where a.category_id=b.category_id and b.category_id=c.category_id
and list_price > (select list_price from production.products where product_name='Trek CrossRip+ - 2018')
order by model_year desc;

---List customers who orders previous dates than Arla Ellis.

select order_date
from sales.orders a, sales.customers b
where a.customer_id=b.customer_id and first_name='Arla' and last_name='Ellis'

select b.customer_id, first_name, last_name, a.order_date
from sales.orders a, sales.customers b
where a.customer_id=b.customer_id and order_date < (select order_date
													from sales.orders a, sales.customers b
													where a.customer_id=b.customer_id
													and b.first_name='Arla' and b.last_name='Ellis')

------------------ Multiple rows Subqueries-------------
-----List order dates for customers residing in the Holbrook city.

select b.order_date
from sales.customers a, sales.orders b
where a.customer_id=b.customer_id and city='Holbrook';

select customer_id
from sales.customers
where city='Holbrook'

select order_date
from sales.orders
where customer_id in (select customer_id from sales.customers where city='Holbrook')

------------Write a query that returns order dates for non-Holbrook customers.

select order_date
from sales.orders
where customer_id not in (select customer_id from sales.customers where city='Holbrook')

----- List products in categories other than Cruisers Bicycles, Mountain Bikes, or Road Bikes. 

select category_id
from production.categories
where category_name in ('Cruisers Bicycles', 'Mountain Bikes', 'Road Bikes');

select product_id, product_name, model_year, list_price, category_id
from production.products
where category_id not in (select category_id
						  from production.categories
						  where category_name in ('Cruisers Bicycles', 'Mountain Bikes', 'Road Bikes'))
and model_year = 2016;

------ Question: List Bikes that cost more than electric bikes

select category_id
from production.categories
where category_name like '%Bikes'

select max(list_price)
from production.products a, production.categories b
where a.category_id=b.category_id
and category_name='Electric Bikes'

select *
from production.products
where category_id in (select category_id from production.categories where category_name like '%Bikes')
and list_price > (select max(list_price)
				  from production.products a, production.categories b
				  where a.category_id=b.category_id and category_name='Electric Bikes') 

select *
from production.products
where category_id in (select category_id from production.categories where category_name like '%Bikes')
and list_price > all (select list_price
					  from production.products a, production.categories b
					  where a.category_id=b.category_id and category_name='Electric Bikes') 

------ Question: List Bikes that cost more than any electric bikes

select *
from production.products
where category_id in (select category_id from production.categories where category_name like '%Bikes')
and list_price > (select min(list_price)
				  from production.products a, production.categories b
				  where a.category_id=b.category_id and category_name='Electric Bikes') 

select *
from production.products
where category_id in (select category_id from production.categories where category_name like '%Bikes')
and list_price > any (select list_price
					  from production.products a, production.categories b
					  where a.category_id=b.category_id and category_name='Electric Bikes')

-------------------------CORRELATED SUBQUERIES
--EXISTS / NOT EXISTS
--Write a query that returns State where 'Trek Remedy 9.8 - 2017' product is not ordered

select distinct(state)
from production.products a, sales.order_items b, sales.orders c, sales.customers d 
where a.product_id=b.product_id
and b.order_id=c.order_id
and c.customer_id=d.customer_id
and a.product_name='Trek Remedy 9.8 - 2017'

------With "in/not in"

select distinct(state)
from sales.customers
where state not in (select distinct(state)
					from production.products a, sales.order_items b, sales.orders c, sales.customers d 
					where a.product_id=b.product_id
					and b.order_id=c.order_id
					and c.customer_id=d.customer_id
					and a.product_name='Trek Remedy 9.8 - 2017')

------With "exist / not exist"
------e.state=d.state >>>> eþitlenenleri getir==exist veya getirme==not exist------

------EXISTS
select distinct state
from sales.customers e
where exists (select distinct(d.state)
			  from production.products a, sales.order_items b, sales.orders c, sales.customers d 
			  where a.product_id=b.product_id
			  and b.order_id=c.order_id
			  and c.customer_id=d.customer_id
			  and a.product_name='Trek Remedy 9.8 - 2017'
			  and e.state=d.state);

------NOT EXISTS
select distinct state
from sales.customers e
where not exists (select distinct(d.state)
				  from production.products a, sales.order_items b, sales.orders c, sales.customers d 
				  where a.product_id=b.product_id
				  and b.order_id=c.order_id
				  and c.customer_id=d.customer_id
				  and a.product_name='Trek Remedy 9.8 - 2017'
				  and e.state=d.state);

--------------- VIEWS ------
-- Create a view that contains orders details for each customer
-- View Tables are updated automatically when the tables that are making the view table are updated

create view view_table as
select first_name, last_name, order_date, product_name, model_year, quantity, list_price, final_price
from (select a.first_name, a.last_name, b.order_date, d.product_name, d.model_year,
			 c.quantity, c.list_price, c.list_price * (1-c.discount) final_price
	  from sales.customers a, sales.orders b, sales.order_items c, production.products d
	  where a.customer_id=b.customer_id and b.order_id=c.order_id and c.product_id=d.product_id) A;

select *
from view_table

--------TEMPORARY TABLE

select first_name, last_name, order_date, product_name, model_year, quantity, list_price, final_price
into temporary_summary_table
from (select a.first_name, a.last_name, b.order_date, d.product_name, d.model_year,
			 c.quantity, c.list_price, c.list_price * (1-c.discount) final_price
	  from sales.customers a, sales.orders b, sales.order_items c, production.products d
	  where a.customer_id=b.customer_id and b.order_id=c.order_id and c.product_id=d.product_id) A;