-- MySQL Source Database

CREATE DATABASE source_ecommerce;

USE source_ecommerce;

CREATE TABLE departments (
department_id INT AUTO_INCREMENT PRIMARY KEY,
department_name VARCHAR(50) NOT NULL UNIQUE,
location VARCHAR(50) DEFAULT 'Main Campus'
);

INSERT INTO departments (department_name, location)
VALUES
('Engineering', 'Building A'),
('Data Science', 'Building A'),
('Human Resources', 'Building B'),
('Marketing', 'Remote'),
('Finance', 'Building B');

-- Verify data
SELECT * FROM departments;
