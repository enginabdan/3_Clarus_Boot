-- 01_SQL_BD_01

-- SELECT
-- SELECT name FROM tracks;
-- SELECT name, Composer FROM tracks;
-- SELECT AlbumId, Title,ArtistId FROM albums;
-- SELECT * FROM albums;

-- DISTINCT
-- SELECT Composer FROM tracks;
-- SELECT DISTINCT Composer FROM tracks;
-- SELECT AlbumId, MediaTypeId FROM tracks;
-- SELECT DISTINCT AlbumId, MediaTypeId FROM tracks;
-- SELECT DISTINCT * FROM tracks;

-- WHERE & LIMIT
-- SELECT DISTINCT * FROM invoices WHERE BillingCity LIKE "Bo%n";
-- SELECT DISTINCT name, Composer FROM tracks WHERE Composer="Jimi Hendrix";
-- SELECT DISTINCT * FROM invoices WHERE total>10;  
-- SELECT DISTINCT * FROM invoices WHERE total>10 LIMIT 4;

-- ORDER BY
-- SELECT DISTINCT * FROM invoices WHERE total>10 ORDER BY total DESC LIMIT 4;
-- SELECT DISTINCT * FROM invoices WHERE total>10 AND BillingCity="Dublin" ORDER BY BillingCity ASC LIMIT 2;
-- SELECT DISTINCT * FROM invoices WHERE total>10 OR BillingCity="Dublin" ORDER BY BillingCity ASC LIMIT 2;

-- AND | OR | NOT OPERATORS
-- SELECT DISTINCT * FROM invoices WHERE NOT BillingCity="Bangalore" ORDER BY BillingCity ASC LIMIT 2;
-- SELECT * FROM invoices WHERE NOT BillingCountry="USA" AND NOT BillingCity="Frankfurt" ORDER BY total ASC;

-- BETWEEN OPERATOR
-- SELECT DISTINCT * FROM invoices WHERE total BETWEEN 10 AND 15 ORDER BY total ASC LIMIT 2;
-- SELECT * from employees WHERE HireDate BETWEEN "2002-01-01" AND "2004-01-01" ORDER BY HireDate ASC LIMIT 5;
-- SELECT * FROM invoices WHERE InvoiceDate BETWEEN "2009-01-01" AND "2011-12-31" ORDER BY InvoiceDate DESC LIMIT 2;
-- SELECT * FROM invoices WHERE InvoiceDate NOT BETWEEN "2009-01-01" AND "2011-12-31" ORDER BY InvoiceDate DESC LIMIT 2;
-- Burada DateTime ise 1 gün sonrasını seçmelisin 2. zaman için

-- IN OPERATOR 
-- SELECT * FROM invoices WHERE BillingCity IN ("Berlin", "Paris", "Frankfurt") ORDER BY BillingCity DESC LIMIT 6; 
-- SELECT * FROM invoices WHERE BillingCity NOT IN ("Berin", "Paris", "Frankfurt") ORDER BY BillingCity DESC;
-- SELECT FirstName, LastName, Country FROM customers WHERE Country IN ("Belgium", "Norway", "Canada", "USA") ORDER BY Country DESC;
