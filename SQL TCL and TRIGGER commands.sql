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
    
    -- TCL commands
    
    -- commit
START TRANSACTION;

-- Insert a new department
INSERT INTO departments (department_id, department_name, location)
VALUES (6, 'Legal', 'San Francisco');

-- Commit the transaction to make the changes permanent
COMMIT;

-- rollback

START TRANSACTION;

-- Insert a new employee
INSERT INTO employees (employee_id, first_name, last_name, email, phone, hire_date, job_title, salary, department_id)
VALUES (11, 'John', 'Doe', 'john.doe@company.com', '555-9876', '2024-06-24', 'Legal Advisor', 90000.00, 6);

-- Oops, we made a mistake. Roll back the transaction to undo the changes
ROLLBACK;

-- trigger commands

-- before insert trigger
DELIMITER $$

CREATE TRIGGER before_insert_employees
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    -- Example: Ensure the salary is above a certain minimum threshold
    IF NEW.salary < 30000 THEN
        SET NEW.salary = 30000;
    END IF;

    -- Example: Set default phone number if not provided
    IF NEW.phone IS NULL THEN
        SET NEW.phone = '555-0000';
    END IF;
END$$

DELIMITER ;


-- after insert trigger
DELIMITER $$

CREATE TRIGGER after_insert_employees
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    -- Example: Insert a record into an audit table for logging
    INSERT INTO employee_audit (employee_id, action, action_time)
    VALUES (NEW.employee_id, 'INSERT', NOW());
END$$

DELIMITER ;


-- before update trigger
DELIMITER $$

CREATE TRIGGER before_update_employees
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Example: Prevent salary from being decreased below the original value
    IF NEW.salary < OLD.salary THEN
        SET NEW.salary = OLD.salary;
    END IF;

    -- Example: Log the old email before it's updated
    INSERT INTO email_audit (employee_id, old_email, updated_at)
    VALUES (OLD.employee_id, OLD.email, NOW());
END$$

DELIMITER ;

-- after update trigger
DELIMITER $$

CREATE TRIGGER after_update_employees
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Example: Log update action into an audit table
    INSERT INTO employee_audit (employee_id, action, action_time)
    VALUES (NEW.employee_id, 'UPDATE', NOW());
END$$

DELIMITER ;


-- before delete trigger
DELIMITER $$

CREATE TRIGGER before_delete_employees
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    -- Example: Log the record that is about to be deleted
    INSERT INTO employee_audit (employee_id, action, action_time)
    VALUES (OLD.employee_id, 'DELETE', NOW());

    -- Example: Prevent deletion if employee is a manager
    IF OLD.job_title LIKE '%Manager%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Managers cannot be deleted';
    END IF;
END$$

DELIMITER ;


-- after delete trigger
DELIMITER $$

CREATE TRIGGER after_delete_employees
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    -- Example: Remove related data from another table (e.g., benefits)
    DELETE FROM employee_benefits WHERE employee_id = OLD.employee_id;

    -- Example: Log the deletion action
    INSERT INTO employee_audit (employee_id, action, action_time)
    VALUES (OLD.employee_id, 'DELETE', NOW());
END$$

DELIMITER ;


