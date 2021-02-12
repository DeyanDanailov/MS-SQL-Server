SELECT FlightId, SUM(t.Price) AS Price
	FROM Flights f
		JOIN Tickets t ON t.FlightId = f.Id
	GROUP BY FlightId
	ORDER BY Price DESC, FlightId