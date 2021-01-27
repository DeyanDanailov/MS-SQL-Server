SELECT TOP(5) e.EmployeeID, e.JobTitle, E.AddressID, A.AddressText
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = A.AddressID
	ORDER BY A.AddressID

SELECT TOP(50) e.FirstName, e.LastName,t.[Name], A.AddressText
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = A.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	ORDER BY e.FirstName, e.LastName

SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.[Name] AS DepartmentName
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary > 15000
	ORDER BY d.DepartmentID


SELECT TOP(3) e.EmployeeID, E.FirstName
	FROM Employees AS e
	LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID	
	WHERE ep.ProjectID IS NULL
	ORDER BY EmployeeID


SELECT e.FirstName, e.LastName, E.HireDate, d.[Name] AS DeptName
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID	
	WHERE e.HireDate > '1999-01-01' 
	AND d.[Name] IN ('Sales', 'Finance')

SELECT TOP(5) e.EmployeeID, E.FirstName, p.[Name] AS ProjectName
	FROM Employees AS e
	JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
	JOIN Projects AS p ON ep.ProjectID = p.ProjectID
	WHERE p.StartDate > '2002-08-13'
	AND P.EndDate IS NULL
	ORDER BY EmployeeID

SELECT TOP(5) e.EmployeeID, e.FirstName,
	CASE
		WHEN YEAR(p.StartDate) >= 2005 THEN NULL
		ELSE p.[Name]
		END AS [ProjectName]
FROM Employees AS e
	JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
	JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24


SELECT TOP(50) e.EmployeeID, 
		e.FirstName + ' ' + e.LastName AS [EmployeeName], 
		m.FirstName + ' ' + m.LastName AS ManagerName, 
		d.[Name] AS [DepartmentName]
	FROM Employees AS e
	JOIN Employees AS m ON e.ManagerID = m.EmployeeID
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	ORDER BY e.EmployeeID

SELECT MIN(a.AvgSalary) AS MinAverageSalary
	FROM
	(SELECT AVG(e.Salary) AS AvgSalary
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	GROUP BY d.[Name]) 
	AS a