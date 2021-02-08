SELECT c.FirstName + ' ' + c.LastName AS [CustomerName],
		c.PhoneNumber,
		C.Gender
	FROM Customers c
	LEFT JOIN Feedbacks f ON f.CustomerId = c.Id
	WHERE f.CustomerId IS NULL
	ORDER BY c.Id