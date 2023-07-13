SELECT InvoiceId, CustomerId, Total FROM invoices ORDER BY CustomerId ASC, Total DESC;   
SELECT InvoiceId, CustomerId, Total FROM invoices ORDER BY Total DESC, CustomerId ASC;
SELECT * FROM invoices WHERE Total >= 10 LIMIT 10;
SELECT * FROM invoices WHERE Total < 10 LIMIT 5;
SELECT * FROM tracks WHERE Name LIKE "B%s";
SELECT * FROM invoices WHERE BillingCountry IN ("USA","Germany","Norway","Canada") AND InvoiceDate BETWEEN "2010-01-01" AND "2010-12-31" ORDER BY InvoiceDate DESC;