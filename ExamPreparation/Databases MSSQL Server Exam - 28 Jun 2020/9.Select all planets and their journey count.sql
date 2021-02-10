SELECT p.Name AS PlanetName,
		COUNT(*) AS JourneysCount
	FROM Journeys j
	RIGHT JOIN Spaceports s ON s.Id = j.DestinationSpaceportId
	RIGHT JOIN Planets p ON p.Id = s.PlanetId
	GROUP BY p.Name
	ORDER BY JourneysCount DESC, PlanetName