
---------------------------------------------------4 DERS-----------------------------------------------------------------------

--Update i�leminde ko�ul tan�mlamaya dikkat ediniz.
--E�er herhangi bir ko�ul tan�mlamazsan�z, s�tundaki t�m de�erlere de�i�iklik uygulanacakt�r.

UPDATE Person.Person_2
SET Person_Name = 'Default_Name'--buray� �al��t�rmadan �nce yukar�daki scripti �al��t�r�n

--Where ile ko�ul vererek 88963212466 Person_ID ' ye sahip ki�inin ad�n� Can �eklinde g�ncelliyoruz.
--Ki�inin �nceki Ad� Kerem' di.

UPDATE Person.Person_2
SET Person_Name = 'Can'
WHERE Person_ID = 78962212466

SELECT *
FROM Person.Person_2

--JOIN ile UPDATE

--A�a��da Person_2 tablosunda person id' si 78962212466 olan �ahs�n (yukar�daki �ah�s) ad�n�,
--As�l tablomuz olan Person tablosundaki haliyle de�i�tiriyoruz.
--Bu i�lemi yaparken iki tabloyu Person_ID �zerinden Join ile birle�tiriyoruz
--Ve kaynak tablodaki Person_ID' ye istedi�imiz �art� veriyoruz.

UPDATE Person.Person_2
SET Person_Name = B.Person_Name 
FROM Person.Person_2 A
INNER JOIN Person.Person B
ON A.Person_ID=B.Person_ID
WHERE B.Person_ID = 78962212466

--Subquery ile Update

--A�a��da Person_2 tablosundaki bir ismin de�erini bir sorgu neticesinde gelen bir de�ere e�itleme i�lemi yap�lmaktad�r.

UPDATE Person.Person_2
SET Person_Name = (SELECT Person_Name
				   FROM Person.Person
				   WHERE Person_ID = 78962212466)
WHERE Person_ID = 78962212466

--DELETE

--Delete' nin ne anlama geldi�ini art�k biliyor olmal�s�n�z.
--Delete kullan�m�nda, Delete ile t�m verilerini sildi�iniz bir tabloya yeni bir kay�t ekledi�inizde,
--E�er tablonuzda otomatik artan bir identity s�tunu var ise eklenen yeni kayd�n identity'si, 
--silinen son kayd�n identity'sinden sonra devam edecektir.
--�rne�in a�a��da otomatik artan bir identity primary keye sahip Book.Publisher tablosuna �rnek olarak veri ekleniyor.

INSERT Book.Publisher
VALUES ('�� Bankas� K�lt�r Yay�nc�l�k'), ('Can Yay�nc�l�k'), ('�leti�im Yay�nc�l�k')

--Delete ile Book.Publisher tablosunun i�i tekrar bo�alt�l�yor.

DELETE
FROM Book.Publisher 

--kontrol
SELECT *
FROM Book.Publisher 

--Book.Publisher tablosuna yeni bir veri insert ediliyor
INSERT Book.Publisher
VALUES ('Paris')

--Tekrar kontrol etti�imizde yeni insert edilen kayd�n identity'sinin eski tablodaki s�radan devam etti�i g�r�lecektir.
SELECT *
FROM Book.Publisher

--Buradan sonraki k�s�mda Constraint ve Alter Table �rnekleri yap�lacakt�r.
--Yapaca��m�z i�lemlerin tutarl� olmas� i�in �ncelikle yukar�da �rnek olarak veri insert etti�imiz tablolar�m�z� bo�altal�m.

DROP TABLE Person.Person_2;--Art�k ihtiyac�m�z yok.

TRUNCATE TABLE Person.Person_Mail;
TRUNCATE TABLE Person.Person;
TRUNCATE TABLE Book.Publisher;

--ALTER TABLE

SELECT Person_Name, Person_Surname
INTO Sample_Person
FROM Person.Person

SP_Rename 'dbo.Sample_Person', 'Person_New'

sp_rename 'Person_New.Person_Name', 'First_Name', 'Column'

--Book tablomuz bir primary key' e sahip
--Author tablomuza primary key atamam�z gerekli, ��nk� olu�tururken atanmam��

ALTER TABLE Book.Author
ALTER COLUMN Author_ID INT NOT NULL

ALTER TABLE Book.Author
ADD CONSTRAINT pk_author PRIMARY KEY (Author_ID)

--Book_Author tablosuna FOREIGN KEY constraint eklemeliyiz

ALTER TABLE Book.Book_Author
ADD CONSTRAINT FK_Author FOREIGN KEY (Author_ID) REFERENCES Book.Author (Author_ID)
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE Book.Book_Author
ADD CONSTRAINT FK_Book2 FOREIGN KEY (Book_ID) REFERENCES Book.Book (Book_ID)
ON UPDATE NO ACTION
ON DELETE CASCADE

--Publisher tablosu normal.

--Book_Publisher tablosuna iki tane FOREIGN KEY constraint eklememiz gerekiyor.

ALTER TABLE Book.Book_Publisher
ADD CONSTRAINT FK_Publisher FOREIGN KEY (Publisher_ID) REFERENCES Book.Publisher (Publisher_ID)

ALTER TABLE Book.Book_Publisher
ADD CONSTRAINT FK_Book FOREIGN KEY (Book_ID) REFERENCES Book.Book (Book_ID)

--Person.Person tablosundaki Person_ID s�tununa 11 haneli olmas� gerekti�i i�in check constraint ekleyelim.

ALTER TABLE Person.Person
ADD CONSTRAINT FK_PersonID_check CHECK (Person_ID BETWEEN 9999999999 AND 99999999999)

--Alttaki constraint' te check ile bir fonksiyonun do�rulanma durumunu sorguluyoruz.
--Fonksiyon ger�ek hayatta kullan�lan TC kimlik no algoritmas�n� �al��t�r�yor.
--Yap�lan check kontrolu bu fonksiyonun s�zgecinden ge�iyor, e�er ID numaras� fonksiyona uyuyorsa fonksiyon 1 de�eri �retiyor ve
--i�lem ger�ekle�tiriliyor. Fonksiyon 0 de�erini �retirse bu ID numaras�n�n istenen ko�ullar� sa�lamad��� anlam�na geliyor ve 
--��lem yap�lm�yor.
--Fonksiyonu �al��t�rabilmeniz i�in fonksiyonu bu database alt�nda create etmeniz gerekmektedir.
--Fonksiyonun scriptini ayr�ca g�nderece�im.

ALTER TABLE Person.Person
ADD CONSTRAINT FK_PersonID_check2 CHECK (dbo.KIMLIKNO_KONTROL(Person_ID) = 1)

--Person_Book 
--Person_Book tablosuna Composite bir primary key eklememiz gerekmektedir.
--sonras�nda iki ID s�tununa Foreign key constraint tan�mlamlayal�m.

ALTER TABLE Person.Person_Book
ADD CONSTRAINT PK_Person PRIMARY KEY (Person_ID,Book_ID)

ALTER TABLE Person.Person_Book
ADD CONSTRAINT FK_Person1 FOREIGN KEY (Person_ID) REFERENCES Person.Person(Person_ID)

ALTER TABLE Person.Person_Book
ADD CONSTRAINT FK_Book1 FOREIGN KEY (Book_ID) REFERENCES Book.Book(Book_ID)

--Person.Person_Phone
--Person_Phone tablosuna person_ID i�in foreign key constraint olu�turmam�z gerekli.

ALTER TABLE Person.Person_Phone
ADD CONSTRAINT FK_Person3 FOREIGN KEY (Person_ID) REFERENCES Person.Person(Person_ID)

--Phone_Number i�in check...

ALTER TABLE Person.Person_Phone
ADD CONSTRAINT FK_Phone_check CHECK (Phone_Number BETWEEN 999999999 AND 9999999999)

--Person.Person_Mail i�in Foreign key tan�mlamam�z gerekli

ALTER TABLE Person.Person_Mail
ADD CONSTRAINT FK_Person4 FOREIGN KEY (Person_ID) REFERENCES Person.Person(Person_ID)

--Bu a�amada Database diagram�n�z� �izip t�m tablolar aras�ndaki ba�lant�lar�n olu�tu�undan emin olman�z� bekliyorum.
--Insert i�lemlerini size b�rak�yorum, hata alarak, constraintlerin ne anlama geldi�ini kendiniz tecr�be ederek yapman�z daha de�erli.