USE SoftUni

SELECT DepartmentID, SUM(Salary) AS TotalSalary
	FROM Employees
	GROUP BY DepartmentID


SELECT DepartmentID, MIN(Salary) as MinimumSalary
FROM Employees
WHERE DepartmentID IN (2, 5, 7)
  AND HireDate > '2000-01-01'
GROUP BY DepartmentID


SELECT DepartmentID,
       AVG(IIF(DepartmentID = 1, Salary + 5000, Salary)) AS AverageSalary
FROM (
         SELECT *
         FROM Employees
         WHERE Salary > 30000
           AND ManagerID != 42 OR ManagerID IS NULL
     ) AS FilteredQuery
GROUP BY DepartmentID


/*SECOND SOLUTION*/

SELECT * INTO EmployeesWithHightSalaries
FROM Employees
WHERE Salary>30000

DELETE
FROM EmployeesWithHightSalaries
WHERE ManagerID=42

UPDATE EmployeesWithHightSalaries
SET Salary += 5000
WHERE DepartmentID=1

SELECT DepartmentID, avg(Salary) as AverageSalary
FROM EmployeesWithHightSalaries
GROUP BY DepartmentID


SELECT DepartmentID, MAX(Salary) AS MaxSalary
	FROM Employees
	GROUP BY DepartmentID
	HAVING MAX(Salary) < 30000 OR  MAX(Salary) > 70000


SELECT COUNT(Salary) [Count]
	FROM Employees
	WHERE ManagerID IS NULL
