SELECT FirstName + ' ' + LastName AS [Full Name],
		pl.Name AS [Plane Name],
		f.Origin + ' - ' + f.Destination AS Trip,
		lt.Type AS [Luggage Type]
	FROM Passengers p
		JOIN Tickets t ON t.PassengerId = p.Id
		JOIN Flights f ON f.Id = t.FlightId
		JOIN Planes pl ON pl.Id = f.PlaneId
		JOIN Luggages l ON l.PassengerId = p.Id
		JOIN LuggageTypes lt ON lt.Id = l.LuggageTypeId
	ORDER BY [Full Name], pl.Name, f.Origin, f.Destination, lt.Type