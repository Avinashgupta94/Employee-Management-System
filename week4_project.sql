CREATE DATABASE EmployeeDB;
GO

USE EmployeeDB;
GO


CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY IDENTITY(1,1),
DepartmentName NVARCHAR(100) NOT NULL
);
GO



CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY IDENTITY(1,1),
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Email NVARCHAR(100) NOT NULL UNIQUE,
DepartmentID INT,
Salary DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO




INSERT INTO Departments (DepartmentName)
VALUES
('Human Resources'),
('IT'),
('Sales'),
('Marketing');
GO



INSERT INTO Employees (FirstName, LastName, Email, DepartmentID, Salary)
VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', 1, 70000.00),
('Bob', 'Smith', 'bob.smith@example.com', 2, 80000.00),
('Charlie', 'Brown', 'charlie.brown@example.com', 3, 60000.00),
('David', 'Wilson', 'david.wilson@example.com', 2, 75000.00),
('Eva', 'Clark', 'eva.clark@example.com', 4, 55000.00);
GO




SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);
GO



SELECT FirstName, LastName
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'IT');
GO



CREATE FUNCTION dbo.GetFullName(@EmployeeID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @FullName NVARCHAR(100);
    SELECT @FullName = FirstName + ' ' + LastName
    FROM Employees
    WHERE EmployeeID = @EmployeeID;

    RETURN @FullName;
END;
GO




SELECT dbo.GetFullName(EmployeeID) AS FullName, Salary
FROM Employees;
GO
