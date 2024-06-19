CREATE DATABASE company_db;

USE company_db;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name, location)
VALUES
    (1, 'Sales', 'New York'),
    (2, 'Marketing', 'Los Angeles'),
    (3, 'IT', 'Chicago'),
    (4, 'Finance', 'Boston'),
    (5, 'HR', 'Seattle');

INSERT INTO employees (employee_id, first_name, last_name, email, phone, hire_date, job_title, salary, department_id)
VALUES
    (1, 'Saurav', 'Singh', 'Saurav14@company.com', '555-1234', '2020-01-01', 'Sales Manager', 80000.00, 1),
    (2, 'Uttam', 'khatri', 'uttam@company.com', '555-5678', '2021-03-15', 'Marketing Coordinator', 50000.00, 2),
    (3, 'Rashmi', 'Sahray', 'rashmi@company.com', '555-9012', '2019-06-01', 'IT Specialist', 65000.00, 3),
    (4, 'Hardik', 'Chaudhary', 'hardik@company.com', '555-3456', '2022-09-01', 'Financial Analyst', 75000.00, 4),
    (5, 'Mike', 'Das', 'mikes@company.com', '555-7890', '2018-11-15', 'HR Coordinator', 55000.00, 5),
    (6, 'Japjot', 'Bhatia', 'japjot@company.com', '555-2345', '2021-05-01', 'Sales Representative', 60000.00, 1),
    (7, 'Sakshi', 'Sharma', 'sakshi@company.com', '555-6789', '2020-08-01', 'Marketing Manager', 70000.00, 2),
    (8, 'Tarun', 'Bhatt', 'taraun@company.com', '555-0123', '2019-02-15', 'IT Manager', 85000.00, 3),
    (9, 'Vansh', 'Arora', 'vansh@company.com', '555-4567', '2021-11-01', 'Financial Specialist', 65000.00, 4),
    (10, 'Jassii', 'Dhillon', 'jassi@company.com', '555-8901', '2018-04-01', 'HR Manager', 75000.00, 5);
    
    
/* 
1NF (First Normal Form)
In 1NF, each table cell must contain a single value. Your current database is already in 1NF, so no changes are needed.
*/


-- 2NF (Second Normal Form)
CREATE TABLE job_titles (
    job_title_id INT PRIMARY KEY,
    job_title VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO job_titles (job_title_id, job_title, salary)
VALUES
    (1, 'Sales Manager', 80000.00),
    (2, 'Marketing Coordinator', 50000.00),
    (3, 'IT Specialist', 65000.00),
    (4, 'Financial Analyst', 75000.00),
    (5, 'HR Coordinator', 55000.00),
    (6, 'Sales Representative', 60000.00),
    (7, 'Marketing Manager', 70000.00),
    (8, 'IT Manager', 85000.00),
    (9, 'Financial Specialist', 65000.00),
    (10, 'HR Manager', 75000.00);

ALTER TABLE employees
ADD COLUMN job_title_id INT;

UPDATE employees e
JOIN job_titles j ON e.job_title = j.job_title
SET e.job_title_id = j.job_title_id;

ALTER TABLE employees
DROP COLUMN job_title,
DROP COLUMN salary;

ALTER TABLE employees
add FOREIGN KEY (job_title_id) REFERENCES job_titles(job_title_id);



-- 3nf(3rd normal form)
CREATE TABLE department_locations (
    department_location_id INT PRIMARY KEY,
    location VARCHAR(50) NOT NULL
);

INSERT INTO department_locations (department_location_id, location)
VALUES
    (1, 'New York'),
    (2, 'Los Angeles'),
    (3, 'Chicago'),
    (4, 'Boston'),
    (5, 'Seattle');

ALTER TABLE departments
ADD COLUMN department_location_id INT;

UPDATE departments d
JOIN department_locations dl ON d.location = dl.location
SET d.department_location_id = dl.department_location_id;

ALTER TABLE departments
DROP COLUMN location;

ALTER TABLE departments
ADD  FOREIGN KEY (department_location_id) REFERENCES department_locations(department_location_id);


