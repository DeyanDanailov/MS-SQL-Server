SELECT rq.CountryName, rq.DisributorName
	FROM
	(SELECT 
		c.Name AS CountryName,
		d.Name DisributorName,	
		DENSE_RANK() OVER (PARTITION BY c.Name ORDER BY COUNT(i.Id) DESC) AS r
	FROM Countries c
		JOIN Distributors d ON c.Id = d.CountryId
		LEFT JOIN Ingredients i ON i.DistributorId = d.Id		
		GROUP BY c.Name, d.Name) AS rq
		WHERE rq.r =1
		ORDER BY rq.CountryName, rq.DisributorName