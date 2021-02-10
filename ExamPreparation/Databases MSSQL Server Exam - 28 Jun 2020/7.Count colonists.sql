SELECT COUNT(*) AS [count]
	FROM Colonists c
	JOIN TravelCards t ON t.ColonistId = c.Id
	JOIN Journeys j ON j.Id = t.JourneyId
	WHERE j.Purpose = 'Technical'