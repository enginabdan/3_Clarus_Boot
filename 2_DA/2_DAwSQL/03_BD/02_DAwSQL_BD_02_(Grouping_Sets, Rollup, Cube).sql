use BikeStores;

---------01.08.2022 DAwSQL Session 2 (Advanced Grouping Operations)----------

------ CROSS JOIN ------
-- Write a query that returns all brand x category possibilities.
--Expected columns: brand_id, brand_name, category_id, category_name

select *  
from production.brands
cross join production.categories
order by brand_id

------////////////////---------
--SELF JOIN
-- Write a query that returns the staffs with their managers.
--Expected columns: staff first name, staff last name, manager name

select a.first_name as stf_frst, a.last_name as stf_lst, b.first_name as mangr_frst
from sales.staffs a, sales.staffs b
where a.manager_id = b.staff_id;

-----------///////////-----------
--GROUPING OPERATIONS
--HAVING
--Write a query that checks if any product id is repeated in more than one row in the products table.

select product_id, count(product_name) as cnt_prdcts
from production.products
group by product_id
having count(product_name) > 1

---Write a query that returns category ids with a maximum list price above 4000 or a minimum list price below 500.

select category_id, max(list_price) as max_lst_prc, min(list_price) as min_lst_prc
from production.products
group by category_id
having max(list_price) > 4000 or min(list_price) < 500;

---Find the average product prices of the brands.
--As a result of the query, the average prices should be displayed in descending order.

select a.brand_id, b.brand_name, avg(list_price) as avg_prc
from production.products a, production.brands b
where a.brand_id = b.brand_id
group by a.brand_id, b.brand_name
order by 3 desc;

--Write a query that returns BRANDS with an average product price of more than 1000.

select a.brand_id, b.brand_name, avg(list_price) as avg_prc 
from production.products a, production.brands b
where a.brand_id = b.brand_id
group by a.brand_id, b.brand_name
having avg(list_price) > 1000
order by 3 asc;

-- Write a query that returns the net price paid by the customer for each order.
-- Don't neglect discounts and quantities

select order_id, sum(quantity * list_price * (1 - discount)) as net_prc 
from sales.order_items
group by order_id
order by order_id;

---------/////////////////////////////-----------
		
--SUMMARY TABLE
--Copy an existing table to a new table.
--Don't need to create a new table before this process.
 
SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year, 
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
FROM	sales.order_items A, production.products B, production.brands C, production.categories D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY C.brand_name, D.category_name, B.model_year

--We will use the table we obtained as a result of the above query again and again in all future queries. 
--For this, we are copying this query result to a new table as below.

SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year, 
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sales.sales_summary
FROM	sales.order_items A, production.products B, production.brands C, production.categories D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY C.brand_name, D.category_name, B.model_year

------

select *
from sales.sales_summary
order by 1,2,3

---GROUPING SETS

--1. Calculate the total sales price.

select sum(total_sales_price)
from sales.sales_summary

--2. Calculate the total sales price of the brands

select Brand, sum(total_sales_price)
from sales.sales_summary
group by Brand
order by Brand;

--3. Calculate the total sales price of the categories

select Category, sum(total_sales_price)
from sales.sales_summary
group by Category
order by Category;

--4. Calculate the total sales price by brands and categories.

select Brand, Category, sum(total_sales_price)
from sales.sales_summary
group by Brand, Category
order by Brand, Category;

--Perform the above four variations in a single query using 'Grouping Sets'.

select Brand, Category, sum(total_sales_price)
from sales.sales_summary
group by grouping sets ((Brand), (Category), (Brand, Category), ())
order by Brand, Category;

---------------- ROLLUP ----------------------

--Generate different grouping variations that can be produced with the brand and category columns using 'ROLLUP'.
-- Calculate sum total_sales_price
-- group by rollup(c1,c2,c3) >>> (c1,c2,c3) + (c1,c2,NULL) + (C1,NULL,NULL), (NULL,NULL,NULL)

select Brand, Category, Model_Year, sum(total_sales_price)
from sales.sales_summary
group by rollup(Brand, Category, Model_Year)
order by 1,2,3

--------------- CUBE -------------------

--Generate different grouping variations that can be produced with the brand and category columns using 'CUBE'.
-- Calculate sum total_sales_price
-- group by CUBE(c1,c2,c3) >> --(C1,C2,C3) +
							  --(C1,C2,NULL) + (C1,C3,NULL) +
                              --(C2,C3,NULL) + 
							  --(C1,NULL,NULL) + (C2,NULL,NULL) + (C3,NULL,NULL)
							  --(NULL,NULL,NULL)

select Brand, Category, Model_Year, sum(total_sales_price)
from sales.sales_summary
group by cube(Brand, Category, Model_Year)
order by 1,2,3;


---------/////////////////////////////-----------
--------DAwSQL 04.08.2022 Session 3 (Organize Complex Queries)-----
--------------- Pivot -------------------

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