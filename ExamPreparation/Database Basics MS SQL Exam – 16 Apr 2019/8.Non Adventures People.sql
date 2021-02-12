SELECT FirstName, LastName, Age
	FROM Passengers p
		LEFT JOIN Tickets t ON t.PassengerId = p.Id
	WHERE t.Id IS NULL
	ORDER BY Age DESC, FirstName, LastName