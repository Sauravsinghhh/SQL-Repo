CREATE DATABASE company_db;

USE company_db;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    budget DECIMAL(12, 2)
);

    CREATE TABLE project_assignments (
    project_id INT,
    employee_id INT,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
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
    
    INSERT INTO projects (project_id, project_name, start_date, end_date, budget)
VALUES
    (1, 'Website Redesign', '2022-01-01', '2022-06-30', 20000.00),
    (2, 'New Marketing Campaign', '2022-03-01', '2022-12-31', 15000.00),
    (3, 'Product Launch', '2022-05-01', NULL, 50000.00),
    (4, 'System Upgrade', '2022-07-01', '2023-01-31', 30000.00),
    (5, 'Employee Training', '2022-08-01', '2022-11-30', 10000.00);
    
INSERT INTO project_assignments (project_id, employee_id)
VALUES
    (1, 1),
    (1, 3),
    (2, 2),
    (2, 7),
    (3, 4),
    (4, 8),
    (4, 9),
    (5, 5),
    (5, 10);

SELECT e.employee_id, e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

SELECT d.department_name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

SELECT p.project_name, p.budget, COUNT(pa.employee_id) AS assigned_employees, 
       COUNT(pa.employee_id) * 0.1 * p.budget AS budget_used
FROM projects p
LEFT JOIN project_assignments pa ON p.project_id = pa.project_id
GROUP BY p.project_name, p.budget;

SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
LEFT JOIN project_assignments pa ON e.employee_id = pa.employee_id
WHERE pa.project_id IS NULL;

SELECT p.project_name, e.first_name, e.last_name
FROM projects p
JOIN project_assignments pa ON p.project_id = pa.project_id
JOIN employees e ON pa.employee_id = e.employee_id;

    
