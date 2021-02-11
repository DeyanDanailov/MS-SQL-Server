SELECT j.JobId, 
		SUM(p.Price) AS Total
	FROM Jobs j
		JOIN PartsNeeded pn ON pn.JobId = j.JobId
		JOIN Parts p ON p.PartId = pn.PartId
	WHERE j.Status LIKE 'Finished'
	GROUP BY j.JobId
	ORDER BY Total DESC, j.JobId