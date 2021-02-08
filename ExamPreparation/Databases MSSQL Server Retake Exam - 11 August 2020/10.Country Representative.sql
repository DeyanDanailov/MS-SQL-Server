SELECT E.CountryName, E.DisributorName
	FROM
	(SELECT 
		c.Name AS CountryName,
		d.Name DisributorName,	
		DENSE_RANK() OVER (PARTITION BY c.Name ORDER BY COUNT(*) DESC) AS r
		FROM Distributors d
		JOIN Ingredients i ON i.DistributorId = d.Id
		JOIN Countries c ON c.Id = d.CountryId
		GROUP BY d.Name, c.Name) AS E
		ORDER BY E.CountryName, E.DisributorName