/*
DML -- Data Manipulation Language
C --> Create --> Insert
R --> Read   --> Select
U --> Update --> Update
D --> Delete --> Delete
*/

SELECT * FROM Customers -- Customers table'�n t�m kolonlar�n� g�sterir.

SELECT CustomerID, CompanyName, ContactName, ContactTitle, City -- Bu kolonlar� getirir
FROM Customers

-- Kolonlar� yeni isimle getirme
SELECT CustomerId As [�irket Ad�], City �ehir, Country �lke
FROM Customers

-- Kolon verilerinin manip�le edilmesi
SELECT CustomerID, CompanyName,
(ContactName + ' ' + ContactTitle) [Contact Info],
([Address] + ' - ' + ISNULL(PostalCode, 'N/A') + ' - ' + City + ' - ' + Country + '-' + ISNULL(Region, 'N/A')) [Full Address],
Phone, Fax
FROM Customers

-- Tablodaki eleman say�s�n� almak:
SELECT Count(*) [Customer Count] FROM Customers -- * null'lar� dahil eder
SELECT Count(Region) FROM Customers
SELECT Count(PostalCode) FROM Customers

-- Top x elementi getirir
SELECT TOP 10 * FROM Customers

SELECT TOP 5 PERCENT * FROM Customers

-- Filtreleme
SELECT * FROM Customers
WHERE (Country = 'Germany' OR Country = 'Mexico') AND ContactTitle = 'Owner'

-- S�ralama (Default: ASC)
SELECT * FROM Customers
ORDER BY Country DESC

-- Birden fazla kolon i�in s�ralama
SELECT * FROM Customers
ORDER BY Country, City DESC

-- Bir kolondaki farkl� kay�tlar� almak
SELECT DISTINCT Country FROM Customers

SELECT DISTINCT ContactTitle From Customers

SELECT * FROM Customers
WHERE Country = 'Germany' OR Country = 'Mexico' OR Country = 'Italy' OR Country = 'France'

-- Yukardakinin daha pratik yolu:
SELECT * FROM Customers
WHERE Country IN('Germany','Mexico', 'Italy', 'France')

-- Belirtilenlerin haricindekileri getirme:
SELECT * FROM Customers
WHERE Country NOT IN('Germany','Mexico', 'Italy', 'France', 'USA', 'UK')

SELECT * FROM Customers
WHERE CompanyName LIKE '%ON%' -- ��erisinde ON ge�en �irketler. %: birden fazla karakter

SELECT * FROM Customers
WHERE ContactTitle LIKE '%Manager%'

SELECT * FROM Customers
WHERE ContactTitle LIKE '%Sales%'

SELECT * FROM Customers
WHERE ContactTitle LIKE 'Sales%' -- Ba�lang�c� Sales

SELECT * FROM Customers
WHERE ContactTitle LIKE 'M%' -- Ba�lang�c� M

SELECT * FROM Customers
WHERE ContactTitle LIKE '_A%' -- Ba�lang�c� fark etmez, 2. harf A

SELECT * FROM Customers
WHERE ContactName LIKE '_[A-F]%' -- Ba�lang�c� fark etmez, 2. harf A-F aras�
-- WHERE ContactName LIKE '_[ABCDEF]%' -- B�yle de olur

SELECT * FROM Customers
WHERE ContactName LIKE '[A-G][H-M]_[A-T]%'

SELECT * FROM Customers
WHERE ContactName LIKE '___ _%'

SELECT * FROM Customers
WHERE ContactName LIKE '_%A'

SELECT * FROM Customers
WHERE ContactName LIKE '[^A-T]%' -- A-T aras�nda ba�lamayacak

SELECT * FROM Orders
WHERE Freight > 20 AND Freight < 30

SELECT * FROM Orders
WHERE Freight BETWEEN 20 AND 30

SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-11-24' AND '1996-12-24'

-------------------------------------------------
INSERT INTO [dbo].[NewCustomers]
SELECT * FROM Customers
WHERE Country IN ('France', 'Mexico', 'USA', 'Germany')

-- Yukarda sorun ��kmad� ��nk� table yap�s ayn�
-- Farkl� olmas� durumunda veya direkt bu �ekilde kolon ismi verebiliriz:
INSERT INTO [dbo].[NewCustomers]
([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax])
VALUES
('SAMCU', 'Sample Customer', 'John Doe', 'Sales Manager', 'Sample Address', 'Hatay', NULL, '1234500', 'Turkey', '555555500', '5x5x5')

-- Birden �ok sat�r eklemek i�in:
INSERT INTO [dbo].[NewCustomers]
([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax])
VALUES
('SAMC1', 'Sample Customer 1', 'John Doe', 'Sales Manager', 'Sample Address', 'Hatay', NULL, '1234500', 'Turkey', '555555500', '5x5x5'),
('SAMC2', 'Sample Customer 2', 'Jane Doe', 'Sales Manager', 'Sample Address', 'Hatay', NULL, '1234500', 'Turkey', '555555500', '5x5x5'),
('SAMC3', 'Sample Customer 3', 'Jim Doe', 'Sales Manager', 'Sample Address', 'Hatay', NULL, '1234500', 'Turkey', '555555500', '5x5x5')

-------------------------------
DELETE [dbo].[NewCustomers] -- T�m tabloyu siler

DELETE [dbo].[NewCustomers] 
WHERE CustomerId = 'SAMC3' -- Kriter vermek �nemli 

DELETE [dbo].[NewCustomers] 
WHERE Country = 'USA' -- USA olanlar� silecek

----------------------------------
UPDATE [dbo].[NewCustomers] -- T�m kolonlar� ayn� datayla doldurur

UPDATE [dbo].[NewCustomers] 
SET ContactTitle = 'Owner'
WHERE CustomerID = 'SAMC2' -- CustomerId'si SAMC2 olan�n ContactTitle'�n� Owner olarak set et.

UPDATE [dbo].[NewCustomers]
SET City = 'Milano', Country = 'Italy'
WHERE CustomerId = 'SAMC2'

UPDATE [dbo].[NewCustomers]
SET City = 'Milano', Country = 'Italy'

DELETE [dbo].[NewCustomers]

DROP TABLE [dbo].[NewCustomers]
