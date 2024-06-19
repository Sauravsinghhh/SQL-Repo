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
    
-- INNER JOIN: This will return only the employees who belong to a department listed in the departments table.

SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

-- LEFT JOIN: This will return all employees, and their respective department if they belong to one. If an employee doesn't belong to any department, the department_name will be NULL.
SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;

-- RIGHT JOIN: This will return all departments, and their respective employees if they have any. If a department doesn't have any employees, the employee details will be NULL.
SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
RIGHT JOIN departments ON employees.department_id = departments.department_id;


SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id
UNION
SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
RIGHT JOIN departments ON employees.department_id = departments.department_id;


SELECT 
    d.department_name,
    AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 60000;


SELECT 
    e1.first_name AS employee1_first_name,
    e1.last_name AS employee1_last_name,
    e2.first_name AS employee2_first_name,
    e2.last_name AS employee2_last_name,
    e1.job_title
FROM employees e1
JOIN employees e2 ON e1.job_title = e2.job_title AND e1.employee_id <> e2.employee_id;
