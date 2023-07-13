-- Single-Row Subqueries:
SELECT TrackId, Name, MAX (Milliseconds) AS Milliseconds FROM tracks;

SELECT TrackId, Name, MIN (Milliseconds) AS Milliseconds FROM tracks;

SELECT TrackId, Name, Bytes, (SELECT AVG(Bytes) FROM tracks) AS General_Average FROM tracks WHERE Bytes > (SELECT AVG(Bytes) FROM tracks) ORDER BY Bytes DESC;

-- Multiple-Row Subqueries:

SELECT CustomerId, FirstName, LastName FROM customers WHERE SupportRepId = (SELECT EmployeeId FROM employees WHERE EmployeeId=3 OR EmployeeId=4); 

SELECT c.CustomerId, c.FirstName, c.LastName FROM customers AS c JOIN employees AS e ON c.SupportRepId=e.EmployeeId WHERE c.SupportRepId = (SELECT EmployeeId FROM employees WHERE EmployeeId=3 OR EmployeeId=4);

-- DDL (CREATE, ALTER, DELETE) and DML (SELECT, INSERT, UPDATE, DELETE) Statements

CREATE TABLE courses (CourseId INT, CourseName TEXT NOT NULL, EmployeeId INT, CoursePrice INT, PRIMARY KEY (CourseId) FOREIGN KEY(EmployeeId) REFERENCES employees(EmployeeId));

INSERT INTO courses (CourseId, CourseName, EmployeeId, CoursePrice) VALUES (1800,"Python",3,1500),(1801,"SQL",4,1200),(1802,"STSTCS",5,1000),(1803,"MATH",6,1000),(1804,"JIRA",6,1200); 

DELETE FROM courses WHERE CourseId=1804;

ALTER TABLE courses ADD COLUMN StartDate DATE NOT NULL;

ALTER TABLE courses DROP COLUMN CoursePrice;

DROP TABLE courses;

