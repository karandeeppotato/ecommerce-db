-- Drop database if exists (for reset)
DROP DATABASE IF EXISTS EcommerceDB;
CREATE DATABASE EcommerceDB;
GO
USE EcommerceDB;
GO

-- Customers Table (Customer Management)
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    Country VARCHAR(50),
    ZipCode VARCHAR(10),
    CreatedDate DATETIME DEFAULT GETDATE()
);
--Products Table (Inventory Management)
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(255),
    Category VARCHAR(100),
    Price DECIMAL(10,2),
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- Orders Table (Sales & Orders)
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    OrderStatus VARCHAR(20) CHECK (OrderStatus IN ('Completed', 'Pending', 'Canceled')),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails Table (Sales & Orders)
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalPrice AS (Quantity * UnitPrice),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);



-- Inventory Table (Inventory Management)
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    StockQuantity INT,
    ReorderLevel INT,
    LastRestockDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Reviews Table (Customer Management)
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Customer Complaints Table (Customer Management)
CREATE TABLE CustomerComplaints (
    ComplaintID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    ComplaintText TEXT,
    Status VARCHAR(20) CHECK (Status IN ('Open', 'Resolved', 'Pending')),
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Payments Table (Finance & Payments)
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    CustomerID INT,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10,2),
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'COD')),
    PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Completed', 'Pending', 'Failed')),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, State, Country, CreatedDate) VALUES
('John', 'Doe', 'john.doe@email.com', '+1 416-555-1001', '123 Main St', 'Toronto', 'Ontario', 'Canada', '2024-01-15'),
('Alice', 'Smith', 'alice.smith@email.com', '+1 647-555-1002', '456 Queen St', 'Ottawa', 'Ontario', 'Canada', '2023-11-20'),
('Michael', 'Brown', 'michael.brown@email.com', '+1 905-555-1003', '789 King St', 'Mississauga', 'Ontario', 'Canada', '2023-12-05'),
('Sarah', 'Johnson', 'sarah.johnson@email.com', '+1 519-555-1004', '101 Bloor St', 'Brampton', 'Ontario', 'Canada', '2024-02-10'),
('David', 'Williams', 'david.williams@email.com', '+1 705-555-1005', '202 Yonge St', 'Hamilton', 'Ontario', 'Canada', '2024-02-01'),
('Emma', 'Taylor', 'emma.taylor@email.com', '+1 416-555-1006', '333 Lakeshore Blvd', 'Toronto', 'Ontario', 'Canada', '2023-08-25'),
('Liam', 'Anderson', 'liam.anderson@email.com', '+1 905-555-1007', '500 Dundas St', 'Mississauga', 'Ontario', 'Canada', '2023-09-30'),
('Olivia', 'Martinez', 'olivia.martinez@email.com', '+1 647-555-1008', '222 Bay St', 'Ottawa', 'Ontario', 'Canada', '2024-01-12'),
('Noah', 'Harris', 'noah.harris@email.com', '+1 519-555-1009', '777 Parliament St', 'Brampton', 'Ontario', 'Canada', '2023-12-28'),
('Sophia', 'Clark', 'sophia.clark@email.com', '+1 705-555-1010', '888 Richmond St', 'London', 'Ontario', 'Canada', '2023-10-20'),
('Mason', 'Walker', 'mason.walker@email.com', '+1 416-555-1011', '654 College St', 'Toronto', 'Ontario', 'Canada', '2024-02-03'),
('Isabella', 'King', 'isabella.king@email.com', '+1 905-555-1012', '321 Front St', 'Mississauga', 'Ontario', 'Canada', '2023-09-15'),
('James', 'Wright', 'james.wright@email.com', '+1 647-555-1013', '432 Wellington St', 'Ottawa', 'Ontario', 'Canada', '2024-01-22'),
('Charlotte', 'Allen', 'charlotte.allen@email.com', '+1 519-555-1014', '900 Carlton St', 'Brampton', 'Ontario', 'Canada', '2023-11-10'),
('Benjamin', 'Scott', 'benjamin.scott@email.com', '+1 705-555-1015', '112 River St', 'Hamilton', 'Ontario', 'Canada', '2023-12-05'),
('Amelia', 'Green', 'amelia.green@email.com', '+1 416-555-1016', '721 Adelaide St', 'Toronto', 'Ontario', 'Canada', '2024-01-29'),
('Ethan', 'Baker', 'ethan.baker@email.com', '+1 905-555-1017', '134 King Edward St', 'Mississauga', 'Ontario', 'Canada', '2023-10-10'),
('Harper', 'Adams', 'harper.adams@email.com', '+1 647-555-1018', '400 Bayview Ave', 'Ottawa', 'Ontario', 'Canada', '2023-12-18'),
('Alexander', 'Nelson', 'alexander.nelson@email.com', '+1 519-555-1019', '555 Main St', 'Brampton', 'Ontario', 'Canada', '2024-02-15'),
('Mia', 'Carter', 'mia.carter@email.com', '+1 705-555-1020', '789 College St', 'London', 'Ontario', 'Canada', '2023-09-05'),
('William', 'Mitchell', 'william.mitchell@email.com', '+1 416-555-1021', '987 Spadina Ave', 'Toronto', 'Ontario', 'Canada', '2024-01-19'),
('Evelyn', 'Perez', 'evelyn.perez@email.com', '+1 905-555-1022', '650 Dundas St', 'Mississauga', 'Ontario', 'Canada', '2023-10-28'),
('Daniel', 'Roberts', 'daniel.roberts@email.com', '+1 647-555-1023', '451 Bank St', 'Ottawa', 'Ontario', 'Canada', '2023-12-09'),
('Grace', 'Phillips', 'grace.phillips@email.com', '+1 519-555-1024', '321 Richmond St', 'Brampton', 'Ontario', 'Canada', '2024-01-07'),
('Henry', 'Evans', 'henry.evans@email.com', '+1 705-555-1025', '401 Wellington St', 'London', 'Ontario', 'Canada', '2023-08-15'),
('Victoria', 'Turner', 'victoria.turner@email.com', '+1 416-555-1026', '601 Queen St', 'Toronto', 'Ontario', 'Canada', '2024-02-06'),
('Samuel', 'Torres', 'samuel.torres@email.com', '+1 905-555-1027', '455 Yonge St', 'Mississauga', 'Ontario', 'Canada', '2023-11-11'),
('Scarlett', 'Collins', 'scarlett.collins@email.com', '+1 647-555-1028', '754 Carlton St', 'Ottawa', 'Ontario', 'Canada', '2023-12-21'),
('Jack', 'Morris', 'jack.morris@email.com', '+1 519-555-1029', '189 Dundas St', 'Brampton', 'Ontario', 'Canada', '2024-01-31'),
('Lily', 'Reed', 'lily.reed@email.com', '+1 705-555-1030', '372 Adelaide St', 'London', 'Ontario', 'Canada', '2023-09-22');

-- Display Inserted Customers
SELECT * FROM Customers;


-- Populate Orders (30 Unique Orders)
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, OrderStatus) VALUES
(1, '2024-02-01', 1299.98, 'Completed'),
(2, '2024-01-28', 799.99, 'Completed'),
(3, '2024-02-05', 179.98, 'Pending'),
(4, '2024-02-10', 399.99, 'Completed'),
(5, '2024-02-12', 99.99, 'Pending'),
(6, '2024-02-14', 249.99, 'Completed'),
(7, '2024-02-18', 59.99, 'Completed'),
(8, '2024-02-20', 199.99, 'Pending'),
(9, '2024-02-21', 149.99, 'Completed'),
(10, '2024-02-22', 499.99, 'Completed'),
(11, '2024-02-23', 29.99, 'Pending'),
(12, '2024-02-25', 399.99, 'Completed'),
(13, '2024-02-26', 699.99, 'Pending'),
(14, '2024-02-27', 899.99, 'Completed'),
(15, '2024-02-28', 29.99, 'Completed'),
(16, '2024-03-01', 219.99, 'Completed'),
(17, '2024-03-02', 139.99, 'Pending'),
(18, '2024-03-03', 599.99, 'Completed'),
(19, '2024-03-04', 109.99, 'Completed'),
(20, '2024-03-05', 319.99, 'Pending'),
(21, '2024-03-06', 99.99, 'Canceled'),
(22, '2024-03-07', 79.99, 'Completed'),
(23, '2024-03-08', 429.99, 'Completed'),
(24, '2024-03-09', 149.99, 'Pending'),
(25, '2024-03-10', 249.99, 'Completed'),
(26, '2024-03-11', 399.99, 'Pending'),
(27, '2024-03-12', 89.99, 'Completed'),
(28, '2024-03-13', 519.99, 'Completed'),
(29, '2024-03-14', 79.99, 'Completed'),
(30, '2024-03-15', 199.99, 'Completed');

-- Display Inserted Orders
SELECT * FROM Orders;





-- Populate Products (30 Unique Products)
INSERT INTO Products (ProductName, Category, Price, CreatedDate) VALUES
-- Electronics
('Apple iPhone 15', 'Electronics', 1099.99, '2023-09-20'),
('Samsung 4K TV 55-inch', 'Electronics', 799.99, '2023-08-15'),
('Sony Wireless Headphones', 'Electronics', 249.99, '2023-06-30'),
('Bose Bluetooth Speaker', 'Electronics', 179.99, '2023-10-05'),
('HP Pavilion Laptop', 'Electronics', 699.99, '2023-11-12'),
-- Home & Kitchen
('KitchenAid Stand Mixer', 'Home & Kitchen', 399.99, '2023-07-12'),
('Dyson Vacuum Cleaner', 'Home & Kitchen', 599.99, '2023-05-18'),
('Instant Pot 7-in-1', 'Home & Kitchen', 119.99, '2023-10-01'),
('Cuisinart Coffee Maker', 'Home & Kitchen', 89.99, '2023-08-22'),
('Philips Air Fryer', 'Home & Kitchen', 149.99, '2023-09-05'),
-- Clothing & Footwear
('Nike Running Shoes', 'Footwear', 149.99, '2023-10-10'),
('Adidas Sweatshirt', 'Clothing', 79.99, '2023-11-05'),
('Levis 501 Jeans', 'Clothing', 59.99, '2023-09-17'),
('Puma Mens Hoodie', 'Clothing', 49.99, '2023-08-25'),
('Under Armour Womens Leggings', 'Clothing', 45.99, '2023-07-20'),
-- Beauty & Health
('Loreal Paris Shampoo', 'Beauty & Health', 14.99, '2023-12-03'),
('Gillette Razor Pack', 'Beauty & Health', 29.99, '2023-10-15'),
('Neutrogena Face Wash', 'Beauty & Health', 12.99, '2023-11-11'),
('Dove Body Wash 1L', 'Beauty & Health', 9.99, '2023-09-30'),
('Maybelline Lipstick Pack', 'Beauty & Health', 19.99, '2023-06-27'),
-- Groceries
('Kirkland Organic Almonds 1kg', 'Groceries', 19.99, '2023-10-20'),
('Quaker Oats Family Pack', 'Groceries', 6.99, '2023-12-15'),
('Nestle Pure Life Water 24-pack', 'Groceries', 5.99, '2023-11-02'),
('Heinz Tomato Ketchup 1L', 'Groceries', 4.99, '2023-09-10'),
('Tropicana Orange Juice 2L', 'Groceries', 7.99, '2023-08-05'),
-- Sports & Outdoors
('Wilson Tennis Racket', 'Sports & Outdoors', 79.99, '2023-07-28'),
('Spalding Basketball', 'Sports & Outdoors', 29.99, '2023-05-19'),
('Adidas Soccer Ball', 'Sports & Outdoors', 24.99, '2023-06-13'),
('Fitbit Smartwatch', 'Sports & Outdoors', 199.99, '2023-09-10'),
('Camping Tent 4-Person', 'Sports & Outdoors', 149.99, '2023-10-23');

-- Display Inserted Products
SELECT * FROM Products;


-- Populate OrderDetails (40 Unique Order Details)
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
-- Order 1 (Multiple items)
(1, 1, 1, 1099.99), -- iPhone 15
(1, 3, 1, 149.99),  -- Nike Running Shoes
-- Order 2
(2, 2, 1, 799.99),  -- Samsung 4K TV
-- Order 3 (Multiple items)
(3, 4, 2, 79.99),   -- Adidas Sweatshirt (x2)
(3, 10, 1, 29.99),  -- Gillette Razor Pack
-- Order 4
(4, 5, 1, 399.99),  -- KitchenAid Mixer
-- Order 5
(5, 6, 1, 99.99),   -- LEGO Star Wars Set
-- Order 6 (Multiple items)
(6, 7, 1, 249.99),  -- Sony Headphones
(6, 9, 1, 199.99),  -- Fitbit Smartwatch
-- Order 7
(7, 8, 1, 599.99),  -- Dyson Vacuum
-- Order 8
(8, 14, 1, 49.99),  -- Puma Hoodie
-- Order 9
(9, 12, 1, 59.99),  -- Levi's Jeans
-- Order 10 (Multiple items)
(10, 13, 2, 45.99), -- Under Armour Leggings (x2)
(10, 20, 1, 7.99),  -- Tropicana Orange Juice
-- Order 11
(11, 18, 1, 12.99), -- Neutrogena Face Wash
-- Order 12
(12, 16, 1, 29.99), -- Gillette Razor Pack
-- Order 13 (Multiple items)
(13, 24, 1, 4.99),  -- Heinz Tomato Ketchup
(13, 25, 1, 7.99),  -- Tropicana Orange Juice
-- Order 14
(14, 19, 1, 9.99),  -- Dove Body Wash
-- Order 15
(15, 21, 1, 6.99),  -- Quaker Oats
-- Order 16
(16, 22, 1, 5.99),  -- Nestle Water 24-pack
-- Order 17 (Multiple items)
(17, 11, 1, 149.99), -- Nike Running Shoes
(17, 23, 1, 79.99),  -- Wilson Tennis Racket
-- Order 18
(18, 26, 1, 29.99), -- Spalding Basketball
-- Order 19
(19, 27, 1, 24.99), -- Adidas Soccer Ball
-- Order 20
(20, 28, 1, 199.99), -- Fitbit Smartwatch
-- Order 21
(21, 15, 1, 14.99), -- L'Oreal Shampoo
-- Order 22
(22, 30, 1, 149.99), -- Camping Tent
-- Order 23
(23, 17, 1, 19.99), -- Maybelline Lipstick Pack
-- Order 24
(24, 29, 1, 79.99), -- Adidas Soccer Ball
-- Order 25 (Multiple items)
(25, 1, 1, 1099.99), -- iPhone 15
(25, 4, 1, 79.99),   -- Adidas Sweatshirt
-- Order 26
(26, 5, 1, 399.99),  -- KitchenAid Mixer
-- Order 27
(27, 7, 1, 249.99),  -- Sony Headphones
-- Order 28
(28, 10, 1, 29.99),  -- Gillette Razor Pack
-- Order 29
(29, 12, 1, 59.99),  -- Levi's 501 Jeans
-- Order 30
(30, 14, 1, 49.99);  -- Puma Hoodie

-- Display Inserted OrderDetails
SELECT * FROM OrderDetails;


--  Populate Inventory (30 Unique Inventory Records)
INSERT INTO Inventory (ProductID, StockQuantity, ReorderLevel, LastRestockDate) VALUES
-- Electronics (Low stock, high value)
(1, 15, 5, '2024-02-01'),  -- Apple iPhone 15
(2, 10, 3, '2024-01-25'),  -- Samsung 4K TV
(3, 25, 5, '2024-01-30'),  -- Sony Wireless Headphones
(4, 30, 5, '2024-02-05'),  -- Bose Bluetooth Speaker
(5, 12, 4, '2024-02-08'),  -- HP Pavilion Laptop

-- Home & Kitchen (Medium stock)
(6, 20, 7, '2024-02-03'),  -- KitchenAid Mixer
(7, 15, 5, '2024-01-20'),  -- Dyson Vacuum Cleaner
(8, 40, 10, '2024-01-18'), -- Instant Pot 7-in-1
(9, 35, 10, '2024-02-01'), -- Cuisinart Coffee Maker
(10, 30, 10, '2024-01-15'), -- Philips Air Fryer

-- Clothing & Footwear (Moderate stock)
(11, 50, 15, '2024-01-29'), -- Nike Running Shoes
(12, 40, 10, '2024-02-02'), -- Adidas Sweatshirt
(13, 55, 15, '2024-01-27'), -- Levi's Jeans
(14, 48, 12, '2024-01-30'), -- Puma Hoodie
(15, 60, 15, '2024-01-25'), -- Under Armour Leggings

-- Beauty & Health (Higher stock)
(16, 80, 20, '2024-02-03'), -- L'Oreal Paris Shampoo
(17, 100, 25, '2024-01-28'), -- Gillette Razor Pack
(18, 90, 25, '2024-02-04'), -- Neutrogena Face Wash
(19, 85, 25, '2024-02-02'), -- Dove Body Wash
(20, 75, 20, '2024-01-29'), -- Maybelline Lipstick Pack

-- Groceries (Fast-moving, high stock)
(21, 200, 50, '2024-01-22'), -- Kirkland Almonds 1kg
(22, 300, 80, '2024-02-01'), -- Quaker Oats Family Pack
(23, 400, 100, '2024-01-30'), -- Nestle Water 24-pack
(24, 250, 60, '2024-01-27'), -- Heinz Tomato Ketchup
(25, 180, 50, '2024-01-25'), -- Tropicana Orange Juice

-- Sports & Outdoors (Moderate stock)
(26, 35, 10, '2024-01-26'), -- Wilson Tennis Racket
(27, 45, 15, '2024-02-03'), -- Spalding Basketball
(28, 55, 15, '2024-02-05'), -- Adidas Soccer Ball
(29, 30, 10, '2024-02-01'), -- Fitbit Smartwatch
(30, 25, 8, '2024-01-29');  -- Camping Tent

-- Display Inserted Inventory
SELECT * FROM Inventory;


-- Populate Reviews (30 Unique Customer Reviews)
INSERT INTO Reviews (CustomerID, ProductID, Rating, ReviewText, ReviewDate) VALUES
-- Electronics
(1, 1, 5, 'Amazing phone with great battery life!', '2024-02-02'),
(2, 2, 4, 'Picture quality is outstanding!', '2024-01-30'),
(3, 3, 5, 'Crystal clear sound and comfortable to wear.', '2024-02-06'),
(4, 4, 4, 'Good speaker, but a bit pricey.', '2024-02-08'),
(5, 5, 5, 'Fast and reliable laptop, great for work.', '2024-02-10'),

-- Home & Kitchen
(6, 6, 5, 'Makes cooking so much easier! Highly recommended.', '2024-02-12'),
(7, 7, 4, 'Great suction power but a bit noisy.', '2024-02-14'),
(8, 8, 5, 'This Instant Pot is a game-changer.', '2024-02-16'),
(9, 9, 3, 'Decent coffee maker, but slow brewing.', '2024-02-18'),
(10, 10, 4, 'Crispy fries with little oil, love it!', '2024-02-20'),

-- Clothing & Footwear
(11, 11, 5, 'Very comfortable running shoes.', '2024-02-22'),
(12, 12, 4, 'Nice sweatshirt but sizing runs small.', '2024-02-24'),
(13, 13, 4, 'Great quality jeans, worth the price.', '2024-02-26'),
(14, 14, 3, 'Hoodie is warm but material is thin.', '2024-02-28'),
(15, 15, 5, 'Perfect for workouts, very stretchable.', '2024-03-01'),

-- Beauty & Health
(16, 16, 4, 'Smells great and lasts long.', '2024-03-02'),
(17, 17, 5, 'Sharp blades, excellent for shaving.', '2024-03-03'),
(18, 18, 3, 'Good face wash but dries skin.', '2024-03-04'),
(19, 19, 5, 'Soft and refreshing body wash.', '2024-03-05'),
(20, 20, 4, 'Beautiful lipstick shades, long-lasting.', '2024-03-06'),

-- Groceries
(21, 21, 5, 'Great quality almonds, fresh and tasty.', '2024-03-07'),
(22, 22, 4, 'Healthy breakfast choice, but packaging could be better.', '2024-03-08'),
(23, 23, 2, 'Water tastes weird compared to other brands.', '2024-03-09'),
(24, 24, 3, 'Classic ketchup, nothing special.', '2024-03-10'),
(25, 25, 4, 'Good orange juice but a bit expensive.', '2024-03-11'),

-- Sports & Outdoors
(26, 26, 5, 'Great balance and grip on this racket.', '2024-03-12'),
(27, 27, 4, 'Good basketball but loses air fast.', '2024-03-13'),
(28, 28, 3, 'Not very durable, started peeling.', '2024-03-14'),
(29, 29, 5, 'This Fitbit is very useful for tracking workouts.', '2024-03-15'),
(30, 30, 4, 'Nice tent, easy to set up.', '2024-03-16');

-- Display Inserted Reviews
SELECT * FROM Reviews;


-- Populate Customer Complaints (30 Unique Rows)
INSERT INTO CustomerComplaints (CustomerID, ComplaintText, Status, CreatedDate) VALUES
-- 🛒 Late Delivery Complaints
(1, 'Order arrived 3 days late.', 'Resolved', '2024-02-05'),
(2, 'My package was delayed by a week.', 'Pending', '2024-01-30'),
(3, 'Expected delivery was missed twice.', 'Resolved', '2024-02-10'),
(4, 'Package tracking was inaccurate.', 'Pending', '2024-02-15'),
(5, 'Paid for express delivery but arrived late.', 'Resolved', '2024-02-08'),

-- Damaged Product Complaints
(6, 'TV screen cracked upon arrival.', 'Resolved', '2024-02-12'),
(7, 'Vacuum cleaner does not work.', 'Pending', '2024-02-18'),
(8, 'Shoes arrived with visible stains.', 'Resolved', '2024-02-20'),
(9, 'Item had scratches and signs of prior use.', 'Pending', '2024-02-22'),
(10, 'Laptop came with a broken keyboard.', 'Resolved', '2024-02-25'),

-- Wrong Item Received
(11, 'Received the wrong shoe size.', 'Resolved', '2024-02-28'),
(12, 'Ordered black but received blue.', 'Pending', '2024-03-01'),
(13, 'Item description was misleading.', 'Resolved', '2024-03-03'),
(14, 'Was expecting a 4-pack, got only 2.', 'Pending', '2024-03-06'),
(15, 'Got the wrong phone model.', 'Resolved', '2024-03-07'),

-- Billing Issues
(16, 'Charged twice for a single order.', 'Resolved', '2024-03-08'),
(17, 'Refund not processed yet.', 'Pending', '2024-03-09'),
(18, 'Coupon was not applied at checkout.', 'Resolved', '2024-03-10'),
(19, 'Incorrect total charged.', 'Pending', '2024-03-12'),
(20, 'Extra charges added to my bill.', 'Resolved', '2024-03-14'),

-- Customer Service Issues
(21, 'Customer service was unhelpful.', 'Resolved', '2024-03-15'),
(22, 'Waited 30 minutes on the helpline.', 'Pending', '2024-03-16'),
(23, 'Agent was rude and unprofessional.', 'Resolved', '2024-03-17'),
(24, 'Support ticket was ignored.', 'Pending', '2024-03-18'),
(25, 'Did not receive callback from support.', 'Resolved', '2024-03-19'),

-- Miscellaneous Complaints
(26, 'Received an expired grocery item.', 'Resolved', '2024-03-20'),
(27, 'Packaging was torn and messy.', 'Pending', '2024-03-21'),
(28, 'Product warranty was missing.', 'Resolved', '2024-03-22'),
(29, 'Received an empty box instead of the product.', 'Pending', '2024-03-23'),
(30, 'Website kept crashing during checkout.', 'Resolved', '2024-03-24');

-- Display Inserted Complaints
SELECT * FROM CustomerComplaints;


USE EcommerceDB;
GO

-- Populate Payments (30 Unique Payment Records)
INSERT INTO Payments (OrderID, CustomerID, PaymentDate, Amount, PaymentMethod, PaymentStatus) VALUES
-- Credit Card Payments
(1, 1, '2024-02-01', 1299.98, 'Credit Card', 'Completed'),
(2, 2, '2024-01-28', 799.99, 'Credit Card', 'Completed'),
(3, 3, NULL, 179.98, 'Credit Card', 'Pending'),
(4, 4, '2024-02-10', 399.99, 'Credit Card', 'Completed'),
(5, 5, '2024-02-12', 99.99, 'Credit Card', 'Completed'),

-- PayPal Payments
(6, 6, '2024-02-14', 249.99, 'PayPal', 'Completed'),
(7, 7, '2024-02-18', 59.99, 'PayPal', 'Completed'),
(8, 8, NULL, 199.99, 'PayPal', 'Pending'),
(9, 9, '2024-02-21', 149.99, 'PayPal', 'Completed'),
(10, 10, '2024-02-22', 499.99, 'PayPal', 'Completed'),

-- Bank Transfers
(11, 11, NULL, 29.99, 'Bank Transfer', 'Pending'),
(12, 12, '2024-02-25', 399.99, 'Bank Transfer', 'Completed'),
(13, 13, '2024-02-26', 699.99, 'Bank Transfer', 'Completed'),
(14, 14, NULL, 899.99, 'Bank Transfer', 'Failed'),
(15, 15, '2024-02-28', 29.99, 'Bank Transfer', 'Completed'),

-- Cash on Delivery (COD)
(16, 16, '2024-03-01', 219.99, 'COD', 'Completed'),
(17, 17, '2024-03-02', 139.99, 'COD', 'Completed'),
(18, 18, NULL, 599.99, 'COD', 'Pending'),
(19, 19, '2024-03-04', 109.99, 'COD', 'Completed'),
(20, 20, '2024-03-05', 319.99, 'COD', 'Completed'),

-- Failed Payments
(21, 21, NULL, 99.99, 'Credit Card', 'Failed'),
(22, 22, '2024-03-07', 79.99, 'PayPal', 'Completed'),
(23, 23, '2024-03-08', 429.99, 'Credit Card', 'Completed'),
(24, 24, NULL, 149.99, 'Bank Transfer', 'Failed'),
(25, 25, '2024-03-10', 249.99, 'PayPal', 'Completed'),

-- Additional Payments
(26, 26, '2024-03-11', 399.99, 'Credit Card', 'Completed'),
(27, 27, NULL, 89.99, 'Bank Transfer', 'Pending'),
(28, 28, '2024-03-13', 519.99, 'Credit Card', 'Completed'),
(29, 29, '2024-03-14', 79.99, 'COD', 'Completed'),
(30, 30, '2024-03-15', 199.99, 'PayPal', 'Completed');

-- Display Inserted Payments
SELECT * FROM Payments;