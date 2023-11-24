use master
GO

CREATE DATABASE BrandMarket

GO

USE BrandMarket


GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Brands')
BEGIN
    CREATE TABLE Brands(
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(255) NOT NULL
    )
END

insert into Brands VALUES('APPLE'),
('SAMSUNG'),
('XIAOMI'),
('NOKIA')
GO
SELECT * FROM Brands

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Laptops')
BEGIN
    CREATE TABLE Laptops(
        Id INT IDENTITY(100,1) PRIMARY KEY,
        Name NVARCHAR(255) NOT NULL,
        Price MONEY NOT NULL,
        BrandId INT FOREIGN KEY REFERENCES Brands(Id)
    )
END

insert into Laptops VALUES('Macbook Air M1', 1999,1),
('Macbook Pro M2', 2999,1),
('Galaxy Book3', 899,2),
('Galaxy Book3 Ultra', 1399,2),
('RedmiBook 15E',799,3),
('RedmiBook Pro 16', 1549,3),
('NokiaBook 12', 799,4),
('NokiaBook 15Pro', 1299, 4),
('NokiaPhone 15Ultra', 1999, 4)

GO

select * from Laptops

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Phones')
BEGIN
    CREATE TABLE Phones(
        Id INT IDENTITY(1000,1) PRIMARY KEY,
        Name NVARCHAR(255) NOT NULL,
        Price MONEY NOT NULL,
        BrandId INT FOREIGN KEY REFERENCES Brands(Id)
    )
END

insert into Phones VALUES('Iphone 8 Plus', 799,1),
('Iphone 15 Pro Max', 2799,1),
('Galaxy S8', 599,2),
('Galaxy S23 Ultra', 2999,2),
('Mi8', 1299,3),
('Mi13 Pro', 3999,3),
('NokiaPhone 5', 399,4),
('NokiaPhone 13Plus', 1289, 4),
('NokiaPhone 15Ultra', 1999, 4)
GO

GO

--Laptops Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT
l.Name AS LaptopName, b.Name AS BrandName
FROM
Brands b
INNER JOIN Laptops l ON b.Id = l.BrandId

GO

--Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
SELECT
p.Name + ' ' + b.Name AS BrandName
FROM
Brands b
INNER JOIN Phones p ON b.Id = p.BrandId


GO

--Brand Adinin Terkibinde s Olan Butun Laptoplari Cixardan Query.

SELECT b.Name AS BrandName, l.Name AS LaptopName
FROM 
Brands b
INNER JOIN Laptops l ON b.Id = l.BrandId
WHERE b.Name LIKE '%S%'

GO

--Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Laptoplari Cixardan Query.

SELECT b.Name AS BrandName, l.Name AS LaptopName
FROM 
Brands b
INNER JOIN Laptops l ON b.Id = l.BrandId
WHERE (l.Price BETWEEN 2000 and 5000)

GO

--Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.

SELECT b.Name AS BrandName, p.Name AS PhoneName
FROM 
Brands b
INNER JOIN Phones p ON b.Id = p.BrandId
WHERE p.Price BETWEEN 1000 AND 1500 OR p.Price>1500

GO

--Her Branda Aid Nece dene Laptop Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.

SELECT b.Name AS BrandName, count(l.Id) AS LaptopCount
FROM 
Brands b
INNER JOIN Laptops l ON b.Id = l.BrandId
GROUP BY(b.Name)

GO

--Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.

SELECT b.Name AS BrandName, COUNT(p.Id) AS PhoneCount
FROM
Brands b
INNER JOIN Phones p ON b.Id = p.BrandId
GROUP BY(b.Name)

GO

--Hem Phone Hem de Laptoplda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.

SELECT b.Name AS BrandName, p.Name AS PhoneName, l.Name AS LaptopName
FROM 
Brands b
INNER JOIN Phones p ON b.Id = p.BrandId
INNER JOIN Laptops l ON b.Id = l.BrandId

GO

--Phone ve Laptop da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.


SELECT 
p.Id AS PhoneId, p.Name AS PhoneName, p.Price AS PhonePrice,
l.Id AS LaptopId, l.Name AS LaptopName, l.Price AS LaptopPrice
FROM Brands b
INNER JOIN Phones p ON b.Id = p.BrandId
INNER JOIN Laptops l ON b.Id = l.BrandId


--12)Phone ve Laptop da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.

SELECT 
p.Id AS PhoneId, p.Name AS PhoneName, p.Price AS PhonePrice,
l.Id AS LaptopId, l.Name AS LaptopName, l.Price AS LaptopPrice,
b.Name AS BrandName
FROM Brands b
INNER JOIN Phones p ON b.Id = p.BrandId
INNER JOIN Laptops l ON b.Id = l.BrandId

--Phone ve Laptop da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
GO

SELECT
p.Id AS PhoneId, p.Name AS PhoneName, p.Price AS PhonePrice,
l.Id AS LaptopId, l.Name AS LaptopName, l.Price AS LaptopPrice,
b.Name AS BrandName
FROM Brands b
INNER JOIN Phones p ON b.Id = p.BrandId
INNER JOIN Laptops l ON b.Id = l.BrandId
WHERE p.Price>1000 AND l.Price>1000;

--14)Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan

GO

SELECT 
b.Name AS BrandName, SUM(p.Price) AS TotalPrice, count(*) AS ProductCount
FROM Brands b
INNER JOIN Phones p ON b.Id = p.BrandId
GROUP BY(b.Name)

--Laptops Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query.

GO

SELECT 
b.Name AS BrandName, SUM(p.Price) AS TotalPrice, count(*) AS ProductCount
FROM Brands b
INNER JOIN Phones p ON b.Id = p.BrandId
GROUP BY (b.Name)
HAVING COUNT(*)>=3;