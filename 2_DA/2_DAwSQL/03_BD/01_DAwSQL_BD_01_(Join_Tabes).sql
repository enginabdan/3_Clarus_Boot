
---------------01-08-22 DAwSQL Session 1------------

USE BikeStores;

--INNER JOIN

-- List products with category names
-- Select product ID, product name, category ID and category names

SELECT A.product_id, A.product_name, B.category_id, B.category_name
FROM production.products as A
inner join production.categories as B
ON A.category_id = B.category_id

--List employees of stores with their store information
--Select employee name, surname, store names

select a.first_name, a.last_name, b.store_name
from sales.staffs as a
inner join sales.stores as b
on a.store_id = b.store_id

----------/////////////////-----------

--LEFT JOIN
--List products with category names
--Select product ID, product name, category ID and category names (Use Left Join)

select a.product_id, a.product_name, b.category_id, b.category_name
from production.products a
left join production.categories b
on a.category_id = b.category_id

--Report the stock status of the products that product id greater than 310 in the stores.
--Expected columns: Product_id, Product_name, Store_id, quantity

select a.product_id, a.product_name, b.store_id, b.quantity
from production.products a
left join production.stocks b
on a.product_id = b.product_id
where b.product_id > 310

--------------//////////////----------------
--RIGHT JOIN
--Report the stock status of the products that product id greater than 310 in the stores.
--Expected columns: Product_id, Product_name, Store_id, quantity

select a.product_id, a.product_name, b.store_id, b.quantity
from production.products a
right join production.stocks b
on a.product_id = b.product_id
where a.product_id > 310

--Report the orders information made by all staffs.
--Expected columns: Staff_id, first_name, last_name, all the information about orders

select * --10
from sales.staffs

select count(distinct staff_id) --6
from sales.orders

select top 20 a.staff_id, a.first_name,a.last_name, b.*
from sales.staffs a
inner join sales.orders b
on a.store_id = b.store_id

--------------//////////////----------------
--FULL OUTER JOIN
--Write a query that returns stock and order information together for all products .
--Expected columns: Product_id, store_id, quantity, order_id, list_price

select a.product_id, store_id, order_id, list_price, b.quantity
from sales.order_items a
full outer join production.stocks b
on a.product_id = b.product_id