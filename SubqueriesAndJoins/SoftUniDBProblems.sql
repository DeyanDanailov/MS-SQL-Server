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