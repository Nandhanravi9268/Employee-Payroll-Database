CREATE DATABASE employee_payroll_db;
USE employee_payroll_db;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    department_id INT,
    designation VARCHAR(100),
    joining_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE payroll (
    payroll_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    deductions DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO departments (department_name) VALUES
('Human Resources'),
('Finance'),
('Information Technology'),
('Marketing');

INSERT INTO employees
(employee_name, gender, department_id, designation, joining_date)
VALUES
('Ravi', 'Male', 3, 'Software Developer', '2024-01-15'),
('Priya', 'Female', 2, 'Accountant', '2023-08-20'),
('Arun', 'Male', 3, 'System Analyst', '2022-05-10'),
('Divya', 'Female', 1, 'HR Executive', '2024-03-01');

INSERT INTO payroll
(employee_id, basic_salary, bonus, deductions)
VALUES
(1, 50000, 5000, 2000),
(2, 45000, 3000, 1500),
(3, 60000, 7000, 2500),
(4, 40000, 2000, 1000);

CREATE VIEW employee_salary_report AS
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.designation,
    p.basic_salary,
    p.bonus,
    p.deductions,
    (p.basic_salary + p.bonus - p.deductions) AS net_salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN payroll p
ON e.employee_id = p.employee_id;

SELECT * FROM employee_salary_report;

SELECT
    employee_name,
    net_salary
FROM employee_salary_report
ORDER BY net_salary DESC;

SELECT
    department_name,
    AVG(net_salary) AS average_salary
FROM employee_salary_report
GROUP BY department_name;