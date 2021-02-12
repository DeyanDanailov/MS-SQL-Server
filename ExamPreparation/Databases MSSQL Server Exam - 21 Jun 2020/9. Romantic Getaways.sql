USE TripService

--Find all accounts, which have had one or more trips
--to a hotel in their hometown.
--Order them by the trips count (descending),
--then by Account ID.

SELECT a.Id,
		a.Email,
		c.Name as City,
		COUNT(A.Id) AS Trips
	FROM Accounts a
		JOIN AccountsTrips at ON at.AccountId = a.Id
		JOIN Trips t ON t.Id = at.TripId
		JOIN Rooms r ON r.Id = t.RoomId
		JOIN Hotels h ON h.Id = r.HotelId
		JOIN Cities c ON c.Id = h.CityId	
	WHERE a.CityId = h.CityId
	GROUP BY a.Id,a.Email, c.Name
	ORDER BY Trips DESC, Id