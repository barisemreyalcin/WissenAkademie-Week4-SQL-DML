/*
DML -- Data Manipulation Language
C --> Create --> Insert
R --> Read   --> Select
U --> Update --> Update
D --> Delete --> Delete
*/

SELECT * FROM Customers -- Customers table'ýn tüm kolonlarýný gösterir.

SELECT CustomerID, CompanyName, ContactName, ContactTitle, City -- Bu kolonlarý getirir
FROM Customers

-- Kolonlarý yeni isimle getirme
SELECT CustomerId As [Þirket Adý], City Þehir, Country Ülke
FROM Customers

-- Kolon verilerinin manipüle edilmesi
SELECT CustomerID, CompanyName,
(ContactName + ' ' + ContactTitle) [Contact Info],
([Address] + ' - ' + ISNULL(PostalCode, 'N/A') + ' - ' + City + ' - ' + Country + '-' + ISNULL(Region, 'N/A')) [Full Address],
Phone, Fax
FROM Customers

-- Tablodaki eleman sayýsýný almak:
SELECT Count(*) [Customer Count] FROM Customers -- * null'larý dahil eder
SELECT Count(Region) FROM Customers
SELECT Count(PostalCode) FROM Customers

-- Top x elementi getirir
SELECT TOP 10 * FROM Customers

SELECT TOP 5 PERCENT * FROM Customers

-- Filtreleme
SELECT * FROM Customers
WHERE (Country = 'Germany' OR Country = 'Mexico') AND ContactTitle = 'Owner'

-- Sýralama (Default: ASC)
SELECT * FROM Customers
ORDER BY Country DESC

-- Birden fazla kolon için sýralama
SELECT * FROM Customers
ORDER BY Country, City DESC

-- Bir kolondaki farklý kayýtlarý almak
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
WHERE CompanyName LIKE '%ON%' -- Ýçerisinde ON geçen þirketler. %: birden fazla karakter

SELECT * FROM Customers
WHERE ContactTitle LIKE '%Manager%'

SELECT * FROM Customers
WHERE ContactTitle LIKE '%Sales%'

SELECT * FROM Customers
WHERE ContactTitle LIKE 'Sales%' -- Baþlangýcý Sales

SELECT * FROM Customers
WHERE ContactTitle LIKE 'M%' -- Baþlangýcý M

SELECT * FROM Customers
WHERE ContactTitle LIKE '_A%' -- Baþlangýcý fark etmez, 2. harf A

SELECT * FROM Customers
WHERE ContactName LIKE '_[A-F]%' -- Baþlangýcý fark etmez, 2. harf A-F arasý
-- WHERE ContactName LIKE '_[ABCDEF]%' -- Böyle de olur

SELECT * FROM Customers
WHERE ContactName LIKE '[A-G][H-M]_[A-T]%'

SELECT * FROM Customers
WHERE ContactName LIKE '___ _%'

SELECT * FROM Customers
WHERE ContactName LIKE '_%A'

SELECT * FROM Customers
WHERE ContactName LIKE '[^A-T]%' -- A-T arasýnda baþlamayacak

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

-- Yukarda sorun çýkmadý çünkü table yapýs ayný
-- Farklý olmasý durumunda veya direkt bu þekilde kolon ismi verebiliriz:
INSERT INTO [dbo].[NewCustomers]
([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax])
VALUES
('SAMCU', 'Sample Customer', 'John Doe', 'Sales Manager', 'Sample Address', 'Hatay', NULL, '1234500', 'Turkey', '555555500', '5x5x5')

-- Birden çok satýr eklemek için:
INSERT INTO [dbo].[NewCustomers]
([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax])
VALUES
('SAMC1', 'Sample Customer 1', 'John Doe', 'Sales Manager', 'Sample Address', 'Hatay', NULL, '1234500', 'Turkey', '555555500', '5x5x5'),
('SAMC2', 'Sample Customer 2', 'Jane Doe', 'Sales Manager', 'Sample Address', 'Hatay', NULL, '1234500', 'Turkey', '555555500', '5x5x5'),
('SAMC3', 'Sample Customer 3', 'Jim Doe', 'Sales Manager', 'Sample Address', 'Hatay', NULL, '1234500', 'Turkey', '555555500', '5x5x5')

-------------------------------
DELETE [dbo].[NewCustomers] -- Tüm tabloyu siler

DELETE [dbo].[NewCustomers] 
WHERE CustomerId = 'SAMC3' -- Kriter vermek önemli 

DELETE [dbo].[NewCustomers] 
WHERE Country = 'USA' -- USA olanlarý silecek

----------------------------------
UPDATE [dbo].[NewCustomers] -- Tüm kolonlarý ayný datayla doldurur

UPDATE [dbo].[NewCustomers] 
SET ContactTitle = 'Owner'
WHERE CustomerID = 'SAMC2' -- CustomerId'si SAMC2 olanýn ContactTitle'ýný Owner olarak set et.

UPDATE [dbo].[NewCustomers]
SET City = 'Milano', Country = 'Italy'
WHERE CustomerId = 'SAMC2'

UPDATE [dbo].[NewCustomers]
SET City = 'Milano', Country = 'Italy'

DELETE [dbo].[NewCustomers]

DROP TABLE [dbo].[NewCustomers]
