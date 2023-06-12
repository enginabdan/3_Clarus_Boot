-- 04_SQL_BD_04

-- HAVING, GROUP BY İLE KULLANILIR VE FİLTRELEME SADECE HAVING İLE YAPILABİLİR 
-- SELECT AlbumId, min(Milliseconds) AS min_duration FROM tracks GROUP BY AlbumId HAVING min_duration > 340000 ORDER BY min_duration DESC;

-- SELECT AlbumId, sum(Milliseconds) AS total_duration FROM tracks GROUP BY AlbumId HAVING total_duration > 340000 ORDER BY total_duration DESC;
-- SELECT t.AlbumId,a.Title, SUM(Milliseconds) AS Total_duration FROM tracks t INNER JOIN albums a ON t.AlbumId = a.AlbumId GROUP BY t.AlbumId, a.Title HAVING total_duration > 340000 ORDER BY Total_duration DESC;

-----DDL-----
-- Data Types
-- CREATE TABLE
-- ALTER TABLE
-- DROP TABLE 

------SQL Statements--------
-- DDL = Data Definition Language (CREATE, ALTER, DROP)
-- DML = Data Manipulation Language (INSERT, UPDATE, DELETE, SELECT)
-- DCL = Data Control Language (REVOKE, GRANT)
-- TCL = Transaction Control Language (COMMIT, ROLLBACK, SAVEPOINT)

------Data Types-----
-- String
-- Date and Time
-- Numeric

------String Data Types-----
-- CHAR 
-- VARCHAR
-- BINARY
-- VARBINARY
-- BLOB
-- TEXT
-- ENUM
-- SET

------Date and Time Data Types-----
-- DATE 
-- DATETIME
-- TIMESTAMP
-- YEAR

------Numeric Data Types-----
-- INT
----- INTEGER OR INT
----- SMALLINT
----- TINYINT
----- MEDIUMINT
----- BIGINT
-- FLOAT
----- FLOAT
----- DOUBLE
--FIXED
----- DECIMAL
----- NUMERIC

-- CREATE TABLE

-- DROP TABLE IF EXISTS vacation_plan;
-- CREATE TABLE vacation_plan (place_id INT, country VARCHAR (20), hotel_name TEXT, employee_id INT, vacation_length INT, budget REAL);

-- DROP TABLE tamamen siler tabloyu, TRUNCATE TABLE ise tablo içeriğini siler ancak SQL Liteda çalışmıyor

-- DROP TABLE vacation_plan
-- INSERT INTO table_name (column1, column2,...) VALUES(value1, value2,...)
-- CREATE TABLE, ALTER TABLE

-- CONSTRAINTS
-- NOT
-- NULLDEFAULT
-- UNIQUE
-- PRIMARY KEY
-- FOREIGN KEY

-- CREATE TABLE table_name(column1 INT PRIMARY KEY, caolumn2 INT,...)
-- CREATE TABLE table_name(column1 INT PRIMARY KEY, caolumn2 INT,column3 INT, FOREIGN KEY(column3) REFERENCES table3 (calumn3));
-- CREATE TABLE customers2 (customer_id INT PRIMARY KEY, first_name TEXT NOT NULL, last_name TEXT NOT NULL);
-- CREATE TABLE orders2 (order_id INT PRIMARY KEY, order_number INT, customer_id INT, FOREIGN KEY (customer_id) REFERENCES customers2 (customer_id));
-- INSERT INTO customers2(customer_id, first_name, last_name) VALUES (1,"John", "King"),(2, "Johnson", "Gold"),(3, "Martin", "Walker");					
-- INSERT INTO orders2 (order_id, order_number, customer_id) VALUES (1,101,1),(2,102,2),(3,103,3);
-- CREATE TABLE table_name(column_name type_name NOT NULL, ...)
-- DROP TABLE IF EXISTS vacation_plan;
-- CREATE TABLE vacation_plan (place_id INT PRIMARY KEY, Country VARCHAR(20), hotel_name CHAR (20) NOT NULL,EmployeeId INT, Vacation_length INT, budget REAL, FOREIGN KEY (EmployeeId) REFERENCES employees(EmployeeId));
-- INSERT INTO vacation_plan (place_id, country, hotel_name, EmployeeId, Vacation_length, budget) VALUES (1,"Canada", "Hilton", 1,5,10000), (2,"USA","Sheraton",1,5,10000), (3,"Turkey","Erzincan_plus",1,8,500);

-- ALTER TABLE
-- ALTER TABLE vacation_plan ADD city TEXT;
-- ALTER TABLE vacation_plan RENAME TO new_vacation_plan;
-- ALTER TABLE new_vacation_plan RENAME COLUMN city TO state;