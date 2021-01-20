--Now create bigger database called SoftUni. You will use same database in the future tasks. It should hold information about
--•	Towns (Id, Name)
--•	Addresses (Id, AddressText, TownId)
--•	Departments (Id, Name)
--•	Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
--Id columns are auto incremented starting from 1 and increased by 1 (1, 2, 3, 4…). Make sure you use appropriate data types for each column. Add primary and foreign keys as constraints for each table. Use only SQL queries. Consider which fields are always required and which are optional.
 
 --CREATE DATABASE SoftUni

 --USE SoftUni

 CREATE  TABLE Towns
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL
)

	CREATE  TABLE Adresses
(
	Id INT PRIMARY KEY IDENTITY,
	AdressText NVARCHAR(500) NOT NULL,
	TownId INT FOREIGN KEY REFERENCES Towns(Id) 
)

CREATE  TABLE Departments
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL
)

CREATE  TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50),
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
	HireDate DATETIME2 NOT NULL,
	Salary DECIMAL(15,2) NOT NULL,
	AdressId INT FOREIGN KEY REFERENCES Adresses(Id),
)
