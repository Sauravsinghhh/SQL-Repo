CREATE DATABASE CollegeDB;
USE CollegeDB;

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100) NOT NULL,
    Age INT,
    Major VARCHAR(100),
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Courses (CourseName, Credits) VALUES 
('Computer Science', 4),
('Mathematics', 3),
('Physics', 4),
('Chemistry', 3);

INSERT INTO Students (StudentName, Age, Major, CourseID) VALUES 
('Saurav', 20, 'Computer Science', 1),
('Japjot', 22, 'Mathematics', 2),
('Vansh', 21, 'Physics', 3),
('Sakshi', 23, 'Chemistry', 4);

-- SQL Operations

-- Arithmetic Operators
SELECT StudentName, Age, Age + 1 AS AgeNextYear FROM Students;
SELECT StudentName, Age, Age * 2 AS DoubleAge FROM Students;

-- Comparison Operators
SELECT * FROM Students WHERE Age > 21;

SELECT * FROM Students WHERE Age BETWEEN 20 AND 22;

-- Logical Operators
SELECT * FROM Students WHERE Age = 21 AND Major = 'Physics';

SELECT * FROM Students WHERE NOT Age = 21;

-- Aggregate Functions
SELECT COUNT(*) AS TotalStudents FROM Students;

SELECT SUM(Age) AS TotalAge FROM Students;

SELECT AVG(Age) AS AverageAge FROM Students;

SELECT MIN(Age) AS YoungestStudent FROM Students;

SELECT MAX(Age) AS OldestStudent FROM Students;


-- Set Operators
SELECT StudentName FROM Students WHERE Age > 21
UNION
SELECT StudentName FROM Students WHERE Major = 'Physics';

-- Bitwise Operators
SELECT 5 & 3 AS BitwiseAND;
