USE SoftUni

INSERT INTO Towns VALUES

('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments VALUES

('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO Employees(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary) VALUES
		('Ivan', 'Ivanov', 'Ivanov', '.NET Developer',
		4,'02/01/2013',3500.00),
		('Petar','Petrov', 'Petrov', 'Senior Engineer',
		1, '03/02/2004', 4000.00),
		('Maria', 'Petrova', 'Ivanova', 'Intern', 
		5, '08/28/2016', 525.25),
		('Georgi', 'Teziev', 'Ivanov', 'CEO',
		2, '12/09/2007', 3000.00),
		('Peter', 'Pan', 'Pan', 'Intern', 
		3, '08/28/2016', 599.88)



ALTER TABLE Employees
ALTER COLUMN HireDate DATE NOT NULL

SELECT [Name] FROM Towns
ORDER BY [Name] ASC
SELECT [Name] FROM Departments
ORDER BY [Name] ASC
SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

UPDATE Employees
SET Salary +=Salary*0.1

SELECT Salary FROM Employees