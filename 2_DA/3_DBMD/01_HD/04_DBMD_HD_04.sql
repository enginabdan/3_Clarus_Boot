
---------------------------------------------------4 DERS-----------------------------------------------------------------------

--Update iþleminde koþul tanýmlamaya dikkat ediniz.
--Eðer herhangi bir koþul tanýmlamazsanýz, sütundaki tüm deðerlere deðiþiklik uygulanacaktýr.

UPDATE Person.Person_2
SET Person_Name = 'Default_Name'--burayý çalýþtýrmadan önce yukarýdaki scripti çalýþtýrýn

--Where ile koþul vererek 88963212466 Person_ID ' ye sahip kiþinin adýný Can þeklinde güncelliyoruz.
--Kiþinin önceki Adý Kerem' di.

UPDATE Person.Person_2
SET Person_Name = 'Can'
WHERE Person_ID = 78962212466

SELECT *
FROM Person.Person_2

--JOIN ile UPDATE

--Aþaðýda Person_2 tablosunda person id' si 78962212466 olan þahsýn (yukarýdaki þahýs) adýný,
--Asýl tablomuz olan Person tablosundaki haliyle deðiþtiriyoruz.
--Bu iþlemi yaparken iki tabloyu Person_ID üzerinden Join ile birleþtiriyoruz
--Ve kaynak tablodaki Person_ID' ye istediðimiz þartý veriyoruz.

UPDATE Person.Person_2
SET Person_Name = B.Person_Name 
FROM Person.Person_2 A
INNER JOIN Person.Person B
ON A.Person_ID=B.Person_ID
WHERE B.Person_ID = 78962212466

--Subquery ile Update

--Aþaðýda Person_2 tablosundaki bir ismin deðerini bir sorgu neticesinde gelen bir deðere eþitleme iþlemi yapýlmaktadýr.

UPDATE Person.Person_2
SET Person_Name = (SELECT Person_Name
				   FROM Person.Person
				   WHERE Person_ID = 78962212466)
WHERE Person_ID = 78962212466

--DELETE

--Delete' nin ne anlama geldiðini artýk biliyor olmalýsýnýz.
--Delete kullanýmýnda, Delete ile tüm verilerini sildiðiniz bir tabloya yeni bir kayýt eklediðinizde,
--Eðer tablonuzda otomatik artan bir identity sütunu var ise eklenen yeni kaydýn identity'si, 
--silinen son kaydýn identity'sinden sonra devam edecektir.
--örneðin aþaðýda otomatik artan bir identity primary keye sahip Book.Publisher tablosuna örnek olarak veri ekleniyor.

INSERT Book.Publisher
VALUES ('Ýþ Bankasý Kültür Yayýncýlýk'), ('Can Yayýncýlýk'), ('Ýletiþim Yayýncýlýk')

--Delete ile Book.Publisher tablosunun içi tekrar boþaltýlýyor.

DELETE
FROM Book.Publisher 

--kontrol
SELECT *
FROM Book.Publisher 

--Book.Publisher tablosuna yeni bir veri insert ediliyor
INSERT Book.Publisher
VALUES ('Paris')

--Tekrar kontrol ettiðimizde yeni insert edilen kaydýn identity'sinin eski tablodaki sýradan devam ettiði görülecektir.
SELECT *
FROM Book.Publisher

--Buradan sonraki kýsýmda Constraint ve Alter Table örnekleri yapýlacaktýr.
--Yapacaðýmýz iþlemlerin tutarlý olmasý için öncelikle yukarýda örnek olarak veri insert ettiðimiz tablolarýmýzý boþaltalým.

DROP TABLE Person.Person_2;--Artýk ihtiyacýmýz yok.

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
--Author tablomuza primary key atamamýz gerekli, çünkü oluþtururken atanmamýþ

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

--Person.Person tablosundaki Person_ID sütununa 11 haneli olmasý gerektiði için check constraint ekleyelim.

ALTER TABLE Person.Person
ADD CONSTRAINT FK_PersonID_check CHECK (Person_ID BETWEEN 9999999999 AND 99999999999)

--Alttaki constraint' te check ile bir fonksiyonun doðrulanma durumunu sorguluyoruz.
--Fonksiyon gerçek hayatta kullanýlan TC kimlik no algoritmasýný çalýþtýrýyor.
--Yapýlan check kontrolu bu fonksiyonun süzgecinden geçiyor, eðer ID numarasý fonksiyona uyuyorsa fonksiyon 1 deðeri üretiyor ve
--iþlem gerçekleþtiriliyor. Fonksiyon 0 deðerini üretirse bu ID numarasýnýn istenen koþullarý saðlamadýðý anlamýna geliyor ve 
--Ýþlem yapýlmýyor.
--Fonksiyonu çalýþtýrabilmeniz için fonksiyonu bu database altýnda create etmeniz gerekmektedir.
--Fonksiyonun scriptini ayrýca göndereceðim.

ALTER TABLE Person.Person
ADD CONSTRAINT FK_PersonID_check2 CHECK (dbo.KIMLIKNO_KONTROL(Person_ID) = 1)

--Person_Book 
--Person_Book tablosuna Composite bir primary key eklememiz gerekmektedir.
--sonrasýnda iki ID sütununa Foreign key constraint tanýmlamlayalým.

ALTER TABLE Person.Person_Book
ADD CONSTRAINT PK_Person PRIMARY KEY (Person_ID,Book_ID)

ALTER TABLE Person.Person_Book
ADD CONSTRAINT FK_Person1 FOREIGN KEY (Person_ID) REFERENCES Person.Person(Person_ID)

ALTER TABLE Person.Person_Book
ADD CONSTRAINT FK_Book1 FOREIGN KEY (Book_ID) REFERENCES Book.Book(Book_ID)

--Person.Person_Phone
--Person_Phone tablosuna person_ID için foreign key constraint oluþturmamýz gerekli.

ALTER TABLE Person.Person_Phone
ADD CONSTRAINT FK_Person3 FOREIGN KEY (Person_ID) REFERENCES Person.Person(Person_ID)

--Phone_Number için check...

ALTER TABLE Person.Person_Phone
ADD CONSTRAINT FK_Phone_check CHECK (Phone_Number BETWEEN 999999999 AND 9999999999)

--Person.Person_Mail için Foreign key tanýmlamamýz gerekli

ALTER TABLE Person.Person_Mail
ADD CONSTRAINT FK_Person4 FOREIGN KEY (Person_ID) REFERENCES Person.Person(Person_ID)

--Bu aþamada Database diagramýnýzý çizip tüm tablolar arasýndaki baðlantýlarýn oluþtuðundan emin olmanýzý bekliyorum.
--Insert iþlemlerini size býrakýyorum, hata alarak, constraintlerin ne anlama geldiðini kendiniz tecrübe ederek yapmanýz daha deðerli.