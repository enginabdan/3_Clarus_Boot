SELECT AlbumId, COUNT(*) AS number_of_tracks FROM tracks GROUP BY AlbumId ORDER BY number_of_tracks DESC; 
SELECT tracks.Name AS Track_Name, albums.Title AS Album_Title FROM tracks JOIN albums ON albums.AlbumId = tracks.AlbumId;
SELECT albums.AlbumId, albums.Title AS Album_Title, MIN(tracks.Milliseconds) AS Min_Duration FROM albums JOIN tracks ON albums.AlbumId = tracks.AlbumId GROUP BY albums.AlbumId ORDER BY tracks.Milliseconds DESC;
SELECT albums.AlbumId, albums.Title AS Album_Title, SUM(tracks.Milliseconds) AS Sum_Duration FROM albums JOIN tracks ON albums.AlbumId = tracks.AlbumId GROUP BY albums.AlbumId ORDER BY Sum_Duration DESC;
SELECT albums.Title AS Album_Title, SUM(tracks.Milliseconds) AS Sum_Duration FROM albums JOIN tracks ON albums.AlbumId = tracks.AlbumId WHERE Sum_Duration>4200000 GROUP BY albums.Title ORDER BY Sum_Duration DESC;