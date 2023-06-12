-- 03_SQL_BD_03

-- JOIN TYPES
-- INNER JOIN
-- LEFT OUTER JOIN
-- RIGHT OUTER JOIN
-- FULL OUTER JOIN
-- CROSS JOIN
-- SELF JOIN

-- PRIMARY KEY(PK)
-- FOREIGN KEY (FK)

-- INNER JOIN (JOIN)
-- SELECT * FROM tracks JOIN genres ON tracks.GenreId=genres.GenreId;
-- SELECT tracks.name, genres.name FROM tracks JOIN genres ON tracks.GenreId=genres.GenreId;
-- SELECT t.name, g.name FROM tracks t JOIN genres g ON t.GenreId = g.GenreId;
-- SELECT t.name, g.name FROM tracks AS t JOIN genres AS g ON t.GenreId = g.GenreId;
-- SELECT * FROM (SELECT t.name, g.name FROM tracks t JOIN genres g ON t.GenreId = g.GenreId) eng;
-- SELECT c.CustomerId, i.InvoiceId, c.FirstName, c.LastName FROM customers c JOIN invoices i ON c.CustomerId = i.CustomerId;
-- SELECT c.CustomerId, i.InvoiceId, c.FirstName, c.LastName FROM customers c INNER JOIN invoices i ON c.CustomerId = i.CustomerId;
-- SELECT * FROM artists ar LEFT JOIN albums a ON ar.ArtistId = a.ArtistId;

-- LEFT JOIN
-- SELECT ar.ArtistId, ar.name, a.Title FROM artists ar LEFT JOIN albums a ON ar.ArtistId = a.ArtistId; 

-- WRITTEN  ///   RUNNING
-- SELECT		--FROM+JOIN
-- FROM+JOIN	--WHERE
-- WHERE		--GROUP BY
-- GROUP BY		--HAVING
-- HAVING		--SELECT
-- ORDER BY		--ORDER BY
-- LIMIT		--LIMIT

-- SUBQUERY
-- SUBQUERY (IN >>> SELECT, WHERE, FROM)
-- SINGLE AND MULTIPLE ROW QUERIES
-- SINGLE ROW QUERIES (=,!=,>,<,>=,<=,><) IN WHERE
-- SELECT FirstName, LastName, HireDate FROM employees WHERE HireDate > (SELECT HireDate FROM employees WHERE FirstName = "Andrew");
-- SELECT TrackId, name, AlbumId FROM tracks WHERE AlbumId = (SELECT AlbumId FROM albums WHERE Title = "Faceless");
-- SELECT t.TrackId, t.name, a.AlbumId, a.Title FROM tracks t LEFT JOIN albums a ON t.AlbumId = a.AlbumId WHERE Title = "Faceless"; 
-- SELECT TrackId, name, AlbumId FROM tracks WHERE AlbumId IN (SELECT AlbumId FROM albums WHERE Title = "Faceless");
-- SELECT TrackId, name, AlbumId FROM tracks WHERE AlbumId IN (SELECT AlbumId FROM albums WHERE Title IN ("Faceless", "Let There Be Rock"));