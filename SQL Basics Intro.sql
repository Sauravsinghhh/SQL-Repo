CREATE DATABASE CompanyEmployees;
USE CompanyEmployees;


CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY ,
    EmployeeName VARCHAR(100) NOT NULL,
    Age INT,
    Position VARCHAR(100),
    CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

INSERT INTO Companies (CompanyName, Location) VALUES 
('Tech Solutions', 'New York'),
('Green Energy', 'San Francisco'),
('Health Plus', 'Chicago');

INSERT INTO Employees (EmployeeName,EmployeeID, Age, Position, CompanyID) VALUES 
('Saurav', 2343,26, 'Software Engineer', 1),
('Uttam', 2346,25, 'Project Manager', 1),
('Rashmi',2789,24 ,'Sales Executive', 2),
('Hardik', 2309,26, 'HR Manager', 3);

select * from Employees;

ALTER TABLE Employees ADD Email VARCHAR(100);

UPDATE Employees
SET Email = 'saurav@example.com'
WHERE EmployeeName = 'Saurav';

UPDATE Employees
SET Email = 'uttam@example.com'
WHERE EmployeeName = 'Uttam';

UPDATE Employees
SET Email = 'rashmi@example.com'
WHERE EmployeeID = '2789';

UPDATE Employees
SET Email = 'hardik@example.com'
WHERE EmployeeID = '2309';


SELECT e.EmployeeName, e.Age, e.Position, e.Email, c.CompanyName
FROM Employees e
JOIN Companies c ON e.CompanyID = c.CompanyID
WHERE c.CompanyName = 'Tech Solutions';

DROP TABLE Companies;
