SELECT c.Name, COUNT(h.Id) AS Hotels
	FROM Cities c
	JOIN Hotels h ON h.CityId = c.Id
	GROUP BY c.Name
	ORDER BY COUNT(h.Id) DESC, c.Name