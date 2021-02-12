SELECT t.Id,
		CONCAT(a.FirstName, ' ', a.MiddleName, ' ', a.LastName) AS [Full Name],
		hc.Name AS [From],
		c.Name AS [To],
		CASE 
		WHEN t.CancelDate IS NOT NULL THEN 'Canceled'
		WHEN t.CancelDate IS NULL THEN
		CONVERT( VARCHAR, DATEDIFF(DAY, ArrivalDate, ReturnDate))  + ' days'
		END AS Duration
	FROM Accounts a
		JOIN AccountsTrips at ON at.AccountId = a.Id
		JOIN Trips t ON t.Id = at.TripId
		JOIN Rooms r ON r.Id = t.RoomId
		JOIN Hotels h ON h.Id = r.HotelId
		JOIN Cities c ON c.Id = h.CityId
		JOIN Cities hc ON hc.Id = a.CityId	
	ORDER BY [Full Name], t.Id