
-------- DAwSQL Session 6 String Functions 08.08.2022 ----------

-- Data Types

-- char		>>> 10 dersek herþey için 10 tutar
-- varchar	>>> 20 dedik, giriþ 5 char o zaman 5 yer tutat (var)
-- text		>>> uzun metinler için çok büyük karakterde
-- nchar	>>> unique karakter kullanýlabilir ð, ü ...
-- nvchar	>>> unique karakter kullanýlabilir ð, ü ...
-- ntext	>>> unique karakter kullanýlabilir ð, ü ...

--LEN

select len (123344)

select len ('Welcome')

select len (' Welcome')

select len ('"Welcome"')

--CHARINDEX

select charindex ('c', 'Character')

select charindex ('c', 'Character', 4)

select charindex ('ct', 'Character')

SELECT CHARINDEX ('CT', 'CHARACtER')

SELECT CHARINDEX ('ct', 'CHARACTER')

--PATINDEX

SELECT PATINDEX ('R', 'CHARACTER')

SELECT PATINDEX ('%R%', 'CHARACTER')

SELECT PATINDEX ('%R', 'CHARACTER')

SELECT PATINDEX ('%r', 'CHARACTER')

SELECT PATINDEX ('%A____', 'CHARACTER')

--LEFT

SELECT LEFT ('CHARACTER', 3)

SELECT LEFT (' CHARACTER', 3)

--RIGHT

SELECT RIGHT ('CHARACTER', 3)

SELECT RIGHT ('CHARACTER ', 3)

--SUBSTRING

SELECT SUBSTRING ('CHARACTER', 3, 5)

SELECT SUBSTRING ('12345689', 3, 5)

SELECT SUBSTRING ('CHARACTER', -1, 5)

SELECT SUBSTRING ('CHARACTER', 0, 5)

--LOWER

SELECT LOWER ('CHARACTER')

--UPPER

SELECT UPPER ('character')

--STRING_SPLIT

SELECT	VALUE
FROM	string_split('John,Sarah,Jack' , ',')

SELECT	VALUE
FROM	string_split('John/Sarah/Jack' , '/')

SELECT	VALUE
FROM	string_split('John//Sarah//Jack' , '/')

SELECT	*
FROM	string_split('John//Sarah//Jack' , '/')

-- character >>>>>> Character

SELECT UPPER (LEFT('character', 1))

select LEN('character')-1

SELECT RIGHT ('character', LEN('character')-1)

SELECT UPPER (LEFT('character', 1)) + RIGHT ('character', LEN('character')-1)

--TRIM

SELECT TRIM(' CHARACTER ')

SELECT TRIM (' CHARACT ER')

SELECT TRIM('./' FROM '/character..') result

---

--LTRIM

SELECT LTRIM(' CHARACTER ')

--RTRIM

SELECT RTRIM(' CHARACTER ')

--REPLACE

SELECT REPLACE ('CHARACTER', 'RAC' , '')

SELECT REPLACE ('CHARACTER', 'RAC' , '/')

--STR

SELECT STR (1234.573, 7, 2)

SELECT STR (1234.573, 7, 1)

--JACK_10

SELECT 'JACK' + '_' + '10'

SELECT 'JACK' + '_' + STR (10, 2)

SELECT 'JACK' + '_' + STR (10000, 2)

--CAST

SELECT CAST (123456 AS CHAR(6))

SELECT CAST (123456 AS VARCHAR(10))    

SELECT CAST (123456 AS VARCHAR(10)) + ' CHRIS'   

SELECT CAST (GETDATE() AS DATE)

--CONVERT

SELECT CONVERT (INT, 30.30)

SELECT CONVERT (FLOAT, 30.30)

--COALECE()
--Bulduðu ilk NULL olmayaný getirir.

SELECT COALESCE(NULL, NULL, 'JACK', 'HANS', NULL)

--NULLIF
--Her 2 deðer de ayný ise NULL döndürür
--Eþit deðilse ilkini getirir

SELECT NULLIF ('JACK', 'JACK')

SELECT NULLIF ('JACK', 'HANS')

SELECT first_name
FROM	sales.customers

SELECT NULLIF (first_name, 'Debra')
from	sales.customers

SELECT	COUNT (NULLIF (first_name, 'Debra'))
from	sales.customers

SELECT	COUNT (*)
from	sales.customers

--ROUND

SELECT ROUND (432.368, 2, 0)

SELECT ROUND (432.368, 2)

SELECT ROUND (432.368, 1, 0)

SELECT ROUND (432.368, 1, 1)

SELECT ROUND (432.300, 1, 1)

SELECT ROUND (432.368, 3, 0)

-- How many yahoo mails in customer’s email column?

-- Method-1
select sum (case when patindex ('%yahoo%', email) > 0 then 1 else 0 end) as yahoo
from sales.customers

-- Method-2
select count(*)
from sales.customers
where email like '%yahoo%'

-- Write a query that returns the characters before the '.' character in the email column.

select email, substring (email, 1, charindex ('.', email)-1)
from sales.customers

-- Add a new column to the customers table that contains the customers' contact information. 
-- If the phone is available, the phone information will be printed, if not, the email information will be printed.

-- Method-1
select *, coalesce (phone, email) as cont_info
from sales.customers

-- Method-2
select*,
	  case
		when phone is not null then phone
		when phone is NULL and email is not null then email
		else NULL
	  end as cont_info
 from sales.customers

-- Write a query that returns streets. The third character of the streets is numerica

select street, substring(street, 3, 1)
from sales.customers
where substring(street, 3, 1) like '[0-9]'

select street, substring(street, 3, 1)
from sales.customers
where substring(street, 3, 1) not like '[^0-9]'

select isnumeric (substring(street, 3, 1))
from sales.customers

select street, substring(street, 3, 1)
from sales.customers
where isnumeric (substring(street, 3, 1)) = 1

--In the street column, clear the string characters that were accidentally added to the end of the initial numeric expression.

-- Method-1
select street,
	   right(left(street, charindex(' ', street)-1), 1),
	   isnumeric(right(left(street, charindex(' ', street)-1), 1)),
	   case
		when isnumeric(right(left(street, charindex(' ', street)-1), 1))=0
		then replace (street, right(left(street, charindex(' ', street)-1), 1), '')
		else street
	   end as new_strt
from sales.customers

-- Method-2
SELECT	street, 
		LEFT(street,CHARINDEX(' ',street)-1),
		RIGHT(street,LEN(street)-CHARINDEX(' ',street)+1),
		LEFT(street,CHARINDEX(' ',street)-2)+ ' '+ RIGHT(street,LEN(street)-CHARINDEX(' ',street)+1) AS new_street
FROM	sales.customers
WHERE	ISNUMERIC(LEFT(street,CHARINDEX(' ',street)-1))=0

-- Method-3
SELECT
	street,
	REPLACE(street,
	SUBSTRING(LEFT(street,
	CHARINDEX(' ', street)-1), 1,
	CHARINDEX(' ', street)-1),
	SUBSTRING(LEFT(street,
	CHARINDEX(' ', street)-1), 1,
	CHARINDEX(' ', street)-2))
FROM sales.customers
WHERE ISNUMERIC(LEFT(street,CHARINDEX(' ',street)-1))=0

--MAC ve WIN da database oluþturduk.
--Bu database içine hazýr xlsx veya csv dosyalarýný tablo olarak ekledik
--Bu arada primary key veya date format seçimi yapýp farklý kaydedip ekledik
--Özellikle MAC azure studio üzerinde csv olan dosyalarý tablo olarak ekledik FARKLI KAYDEDEREK
--Bu arada csv farklý kaydettik