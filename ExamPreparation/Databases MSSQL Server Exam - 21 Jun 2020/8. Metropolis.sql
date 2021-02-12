USE TripService

SELECT TOP(10) c.Id,
			c.Name AS City,
			c.CountryCode AS Country,
			COUNT(a.Id) AS Accounts
		FROM Cities c
			LEFT JOIN Accounts a ON a.CityId = c.Id
		GROUP BY c.Id, c.Name, c.CountryCode
		ORDER BY Accounts DESC