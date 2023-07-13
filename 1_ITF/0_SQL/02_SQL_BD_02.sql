-- 02_SQL_BD_02

-- LIKE
-- SELECT * FROM employees WHERE first_name LIKE "___e%"
-- SELECT * FROM employees WHERE first_name LIKE "__v%"
-- SELECT * FROM tracks WHERE Composer LIKE "%Bach"
-- SELECT * FROM tracks WHERE Composer LIKE "Johann%"

-- AGGREGATE FUNCTIONS: SUM, AVG, MAX, MIN, COUNT
-- SUM, AVG >>> FOR NUMERIC
-- MAX, MIN, COUNT >>> FOR NUMERIC & NON NUMERIC

-- COUNT | COUNT DISTINCT
-- SELECT COUNT (InvoiceId) FROM invoices;
-- SELECT COUNT (name) FROM tracks;
-- SELECT COUNT (DISTINCT name) FROM tracks;
-- SELECT COUNT (DISTINCT name) as Distinct_Name FROM tracks;
-- SELECT COUNT (DISTINCT Composer) FROM tracks;
-- SELECT COUNT (Composer) FROM tracks;
-- SELECT COUNT (DISTINCT Composer) FROM tracks WHERE Composer IS NULL;
-- SELECT COUNT (DISTINCT Composer) FROM tracks WHERE Composer IS NOT NULL;

-- MIN
-- SELECT BillingCity, MIN (total) FROM invoices WHERE total IS NOT NULL;
-- SELECT FirstName, MIN (HireDate) AS oldest_date FROM employees;
-- SELECT FirstName, MIN (HireDate) oldest_date FROM employees;

--MAX
-- SELECT BillingCity, MAX(total) AS max_bill FROM invoices;
-- SELECT name, MAX(Milliseconds) AS max_duration FROM tracks;

--SUM
-- SELECT SUM(UnitPrice) AS total_price FROM tracks;
-- SELECT SUM (total) AS total_income FROM invoices

-- strftime("%Y %m %d","now")
-- SELECT DISTINCT strftime("%Y", InvoiceDate) FROM invoices;
-- SELECT DISTINCT strftime("%m", InvoiceDate) FROM invoices;
-- SELECT DISTINCT strftime("%d", InvoiceDate) FROM invoices;

-- AVG - SUBQUERY
-- SELECT BillingCity , AVG(total)  FROM invoices;
-- SELECT name FROM tracks WHERE Milliseconds > (SELECT AVG(Milliseconds) FROM tracks);
-- SELECT City, COUNT(City) FROM employees WHERE City="Calgary";

-- GROUP BY
-- SELECT City, COUNT (State)FROM employees GROUP BY City;
-- SELECT COUNT (State)FROM employees GROUP BY City;
-- SELECT gender, job_title, COUNT(job_title) FROM employees GROUP BY gender, job_title; 
-- SELECT job_title, gender, COUNT(job_title) FROM employees GROUP BY job_title, gender;
-- SELECT job_title, gender, COUNT(job_title) FROM employees WHERE job_title="Data Scientist" GROUP BY job_title, gender;
-- SELECT Composer, COUNT(TrackId) FROM tracks WHERE Composer is not null GROUP BY Composer;
-- SELECT BillingCountry, COUNT(total) FROM invoices GROUP BY BillingCountry;
-- SELECT Country, COUNT(CustomerId) FROM customers GROUP BY Country;
-- SELECT AlbumId, MIN(Milliseconds) FROM tracks GROUP BY AlbumId;