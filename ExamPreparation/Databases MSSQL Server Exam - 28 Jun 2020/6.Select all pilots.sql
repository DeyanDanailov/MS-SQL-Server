SELECT c.Id,
		CONCAT(c.FirstName, ' ', c.LastName) AS full_name
	FROM Colonists c
	JOIN TravelCards t ON T.ColonistId = c.Id
	WHERE t.JobDuringJourney = 'Pilot'
	ORDER BY c.Id