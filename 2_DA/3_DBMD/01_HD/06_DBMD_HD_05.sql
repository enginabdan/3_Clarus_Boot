
---------------------------------------------------5 DERS-----------------------------------------------------------------------

--------- DATABASE INDEXES
/*
-- There are several different scanning methods, the query planner tries to bring the 
query result using the most appropriate one.

-- The correct scanning method to use is highly dependent on the use case and 
the state of the database at the time of scanning.

A clustered index defines the order in which data is physically stored in a table. 
Table data can be sorted in only way, therefore, there can be only one clustered index per table. 
In SQL Server, the primary key constraint automatically creates a clustered index on that particular column.

A non-clustered index doesn’t sort the physical data inside the table. 
In fact, a non-clustered index is stored at one place and table data is stored in another place. 
This is similar to a textbook where the book content is located in one place and the index is located in another. 
This allows for more than one non-clustered index per table.
*/

-- we create table 

CREATE TABLE website_visitor (visitor_id int,
							  first_name varchar(50),
							  last_name varchar(50),
							  phone_number bigint,
							  city varchar(50));

-- We are throwing random data into the table, it is out of our subject.

DECLARE @i int = 1
DECLARE @RAND AS INT
WHILE @i<200000
BEGIN
	SET @RAND = RAND()*81
	INSERT website_visitor
		SELECT @i ,
			   'visitor_name' + cast (@i as varchar(20)),
			   'visitor_surname' + cast (@i as varchar(20)),
			   5326559632 + @i,
			   'city' + cast(@RAND as varchar(2))
	SET @i +=1
END;

-- we check top 10

SELECT top 10*
FROM website_visitor

-- We open statistics (Process and time), you don't have to open it, we just opened it to see the details of the transactions.

SET STATISTICS IO ON
SET STATISTICS TIME ON

-- Without any index, we condition the visitor_id and call the whole table

SELECT *
FROM website_visitor
WHERE visitor_id = 100

-- When you look at the execution plan, you will see Table Scan, that is, it searches the entire table by looking at all the values ​​one by one.
-- We create an index on the visitor_id

CREATE CLUSTERED INDEX CLS_INX_1 ON website_visitor (visitor_id);

-- visitor_id' ye şart verip sadece visitor_id'yi çağırıyoruz 

SELECT visitor_id
FROM website_visitor
WHERE visitor_id = 100

-- execution plan baktığınızda Clustered Index Seek
-- yani sadece clustered indexte aranılan değeri B-Tree yöntemiyle bulup getirdiğini görüyoruz.
-- visitor id'ye şart verip tüm tabloyu çağırıyoruz

SELECT *
FROM website_visitor
WHERE visitor_id = 100

-- execution plan baktığınızda Clustered Index Seek yaptığını görüyoruz
-- Cluster Index tablodaki tüm bilgileri leaf node'larda sakladığı için ayrıca bir yere gitmek ihtiyacı olmadan
-- primary key bilgisiyle (clustered index) tüm bilgileri getiriyor.
-- Peki farklı bir sütuna şart verirsek;

SELECT first_name
FROM website_visitor
WHERE first_name = 'visitor_name17'

-- Non Clustered index tanımlayalım ad sütununa

CREATE NONCLUSTERED INDEX ix_NoN_CLS_1 ON website_visitor (first_name);

-- Ad sütununa şart verip kendisini çağıralım:

SELECT first_name
FROM website_visitor
WHERE first_name = 'visitor_name17'

-- Peki 2nci bir sütun çağırırsak
-- Normal hayatta ad soyad çağırılır

SELECT first_name, last_name
FROM website_visitor
WHERE first_name = 'visitor_name17'

-- Include indexi oluşturalım:

CREATE UNIQUE NONCLUSTERED INDEX ix_NoN_CLS_1 ON website_visitor (first_name) INCLUDE (last_name);

-- ad ve soyadı ad sütununa şart vererek birlikte çağıralım

SELECT first_name, last_name
FROM website_visitor
WHERE first_name = 'visitor_name17'

-- Sadece last_name çağırırsak ne oluyor ona bakalım

SELECT last_name
FROM website_visitor
WHERE first_name = 'visitor_name10'