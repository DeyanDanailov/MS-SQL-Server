SELECT TOP(5) e.EmployeeID, e.JobTitle, E.AddressID, A.AddressText
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = A.AddressID
	ORDER BY A.AddressID