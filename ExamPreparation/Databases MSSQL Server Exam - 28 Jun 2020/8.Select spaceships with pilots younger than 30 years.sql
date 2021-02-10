SELECT s.[Name], s.Manufacturer
	FROM Colonists c
	JOIN TravelCards t ON t.ColonistId = c.Id
	JOIN Journeys j ON j.Id = t.JourneyId
	JOIN Spaceships s ON s.Id = j.SpaceshipId
	WHERE BirthDate > '1989-01-01'
		AND t.JobDuringJourney = 'Pilot'
	ORDER BY s.[Name]