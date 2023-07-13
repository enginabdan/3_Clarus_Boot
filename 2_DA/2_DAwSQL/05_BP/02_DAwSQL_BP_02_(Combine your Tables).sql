SELECT tracks.Name AS name_track, genres.Name AS genre_track
FROM genres
INNER JOIN tracks
ON genres.Genreid = tracks.Genreid
LIMIT 10;

SELECT invoices.InvoiceId, customers.FirstName, customers.LastName
FROM invoices
INNER JOIN customers
ON invoices.Customerid = customers.Customerid
LIMIT 10;

SELECT artists.ArtistId, artists.Name, albums.AlbumId, albums.Title
FROM artists
INNER JOIN albums
ON artists.ArtistId = albums.ArtistId
ORDER BY artists.ArtistId
LIMIT 10;

SELECT A.FirstName, A.LastName, B.FirstName AS ManagerFirstName, B.LastName AS ManagerLastName
FROM employees A 
INNER JOIN employees B
ON B.EmployeeId = A.ReportsTo;

	
