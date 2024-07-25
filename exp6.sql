CREATE DATABASE Exp6
GO

USE Exp6
GO

-- tạo bảng
CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Address NVARCHAR(150),
    Tel VARCHAR(15)
);

CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products(
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Descriptions NVARCHAR(100),
    Unit NVARCHAR(10),
    Price MONEY CHECK (Price>0),
    Quantity INT
);

CREATE TABLE OrderDetails(
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price MONEY CHECK (Price>0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
)
GO

-- thêm dữ liệu
INSERT INTO Customers
VALUES (2004, N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', 0987654321)
GO

INSERT INTO Orders
VALUES (123, 2004, '2024/06/15')
GO

INSERT INTO Products
VALUES (1, N'Máy Tính T450', N'Máy nhập mới', N'Chiếc', 10000000, 1),
       (2, N'Điện Thoại Nokia5670', N'Điện thoại đang hot', N'Chiếc', 2000000, 2),
       (3, N'Máy In SamSung450', N'Máy in đang ế', N'Chiếc', 1000000, 1)
GO

INSERT INTO OrderDetails
VALUES (123, 1, 1, 10000000),
       (123, 2, 2, 2000000),
       (123, 3, 1, 1000000)
GO

-- dữ liệu tương tự
INSERT INTO Customers 
VALUES (2003, N'Trần Anh Thư', N'12 Ô Chợ Dừa, Đống Đa, Hà Nội', 0357831398)
GO

INSERT INTO Orders
VALUES (124, 2003, '2024/07/23')
GO

INSERT INTO Products
VALUES (4, N'Quạt cầm tay', N'Phiên bản giới hạn', N'Chiếc', 5000000, 1),
       (5, N'Lightstick BlackPink', N'Quẩy concert', N'Chiếc', 1000000, 10),
       (6, N'Chai nước Ong', N'Bán đấu giá', N'Chiếc', 1500000, 1),
       (7, N'Áo thun BabyMonster', N'Dành cho các BeMon', N'Chiếc', 1200000, 20)
GO

INSERT INTO OrderDetails
VALUES (124, 4, 1, 5000000),
       (124, 5, 10, 1000000),
       (124, 6, 1, 1500000),
       (124, 7, 20, 1200000)
GO

INSERT INTO Customers 
VALUES (2002, N'Đặng Thu Trang', N'30 Hồng Phúc, Hà Nội', 0324363868)
GO

INSERT INTO Orders
VALUES (125, 2003, '2024/07/08')
GO

INSERT INTO Products
VALUES (8, N'Vé The Eras Tour', N'Khu A', N'Chiếc', 5000000, 4),
       (9, N'Vé trở về tuổi thơ', N'Hứa không thất vọng', N'Chiếc', 1000000, 5)
GO

INSERT INTO OrderDetails
VALUES (125, 8, 4, 5000000),
       (125, 9, 5, 1000000)
GO

-- liệt kê danh sách khách hàng đã mua hàng ở cửa hàng
SELECT Name, Address, Tel FROM Customers;

-- liệt kê danh sách sản phẩm của cửa hàng
SELECT ProductName FROM Products;

-- liệt kê dsach các đơn đặt hàng của cửa hàng
SELECT * FROM Orders;

-- liệt kê dsach khách hàng theo thứ tự al
SELECT Name FROM Customers ORDER BY Name;

-- liệt kê dsach sp của shop theo thứ tự giá giảm
SELECT ProductName, Price FROM Products ORDER BY Price DESC;

-- liệt kê các sp khách An đã mua
SELECT DISTINCT P.ProductName
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Name = N'Nguyễn Văn An';

-- số khách hàng đã mua ở cửa hàng
SELECT COUNT(DISTINCT Name) AS TotalCustomersOnlineStore
FROM Customers;

-- số mặt hàng mà cửa hàng bán
SELECT ProductName, COUNT(ProductName) AS TotalProdcuts
FROM Products
GROUP BY ProductName;

-- tổng tiền của từng đơn
SELECT OrderID, SUM(Price * Quantity) AS Revenue
FROM OrderDetails
GROUP BY OrderID
ORDER BY OrderID;
