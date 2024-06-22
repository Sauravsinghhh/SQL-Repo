create database Restaurants;

use restaurants;

CREATE TABLE Customers (
    CID INT(20) NOT NULL PRIMARY KEY,
    Cname VARCHAR(50) NOT NULL,
    age INT(10) NOT NULL
);

CREATE TABLE Restaurants (
    RID INT(10) NOT NULL PRIMARY KEY,
    Rname VARCHAR(30) NOT NULL,
    City VARCHAR(40) NOT NULL,
    r_range VARCHAR(45) CHECK (r_range IN ('expensive', 'cheap', 'budget friendly')),
    cuisines VARCHAR(35) CHECK (cuisines IN ('North', 'South', 'Chinese'))
);

CREATE TABLE Orders (
    OID INT(10) PRIMARY KEY,
    CID INT(20) NOT NULL,
    RID INT(10) NOT NULL,
    o_status VARCHAR(50) CHECK (o_status IN ('Delivered', 'Cancelled', 'Rejected')),
    duration VARCHAR(34) NOT NULL,
    FOREIGN KEY (CID) REFERENCES Customers(CID),
    FOREIGN KEY (RID) REFERENCES Restaurants(RID)
);

CREATE TABLE Items_Ordered (
    OID INT(10) NOT NULL,
    Item_name VARCHAR(20) NOT NULL,
    Category VARCHAR(40) CHECK (Category IN ('Veg', 'Non-Veg')),
    PRIMARY KEY (OID, Item_name),
    FOREIGN KEY (OID) REFERENCES Orders(OID)
);

CREATE TABLE Payment (
    PID INT(10) NOT NULL,
    OID INT(10) NOT NULL,
    AMNT INT(20) NOT NULL,
    P_MODE VARCHAR(30) CHECK (P_MODE IN ('UPI', 'DEBIT CARD', 'COD')),
    FOREIGN KEY (OID) REFERENCES Orders(OID)
);

INSERT INTO Customers (CID, Cname, age) VALUES
(3456, 'Saurav', 20),
(3458, 'Rashmi', 20),
(3459, 'Uttam', 20),
(34501, 'Hardik', 20),
(3452, 'Japjot', 20),
(3455, 'Sakshi', 20);

INSERT INTO Restaurants (RID, Rname, City, r_range, cuisines) VALUES
(34509, 'Restaurant A', 'City A', 'expensive', 'North'),
(34508, 'Restaurant B', 'City B', 'cheap', 'Chinese');

INSERT INTO Orders (OID, CID, RID, o_status, duration) VALUES
(1, 3456, 34509, 'Delivered', '30 minutes'),
(2, 3458, 34508, 'Cancelled', '45 minutes');

INSERT INTO items_ordered (OID, Item_name, Category) VALUES
(1, 'Paneer Tikka', 'Veg'),
(1, 'Chicken Biryani', 'Non-Veg'),
(2, 'Gobi Manchurian', 'Veg');

INSERT INTO payment VALUES (1, 1, 500, 'UPI');
INSERT INTO payment VALUES (2, 2, 800, 'DEBIT CARD');

SELECT C.Cname, R.Rname, O.o_status, O.duration
FROM Customers C
JOIN Orders O ON C.CID = O.CID
JOIN Restaurants R ON O.RID = R.RID;

DELIMITER //

CREATE PROCEDURE AddCustomer(IN cust_id INT, IN cust_name VARCHAR(50), IN cust_age INT)
BEGIN
    INSERT INTO Customers (CID, Cname, age) VALUES (cust_id, cust_name, cust_age);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddOrder(IN order_id INT, IN cust_id INT, IN rest_id INT, IN status VARCHAR(50), IN order_duration VARCHAR(34))
BEGIN
    INSERT INTO Orders (OID, CID, RID, o_status, duration) VALUES (order_id, cust_id, rest_id, status, order_duration);
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION TotalPaymentByCustomer(cust_id INT) RETURNS INT
BEGIN
    DECLARE total_payment INT;
    SELECT SUM(P.AMNT) INTO total_payment
    FROM Payment P
    JOIN Orders O ON P.OID = O.OID
    WHERE O.CID = cust_id;
    RETURN total_payment;
END //

DELIMITER ;


