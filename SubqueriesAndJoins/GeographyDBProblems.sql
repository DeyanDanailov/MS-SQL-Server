SELECT c.CountryCode, m.MountainRange, p.PeakName, p.Elevation
	FROM Countries AS c
	JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	JOIN Mountains AS m ON mc.MountainId = m.Id
	JOIN Peaks AS p ON m.Id = p.MountainId
	WHERE c.CountryCode = 'BG'
	AND p.Elevation > 2835
	ORDER BY p.Elevation DESC


SELECT c.CountryCode, COUNT(m.MountainRange) AS [MountainRanges]
	FROM Countries AS c
	JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	JOIN Mountains AS m ON mc.MountainId = m.Id
	WHERE c.CountryCode IN ('US', 'RU', 'BG')
	GROUP BY C.CountryCode

SELECT TOP(5) c.CountryName, r.RiverName
	FROM Countries AS c
	LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
	JOIN Continents AS co ON C.ContinentCode = co.ContinentCode
	WHERE co.ContinentName = 'Africa'
	ORDER BY c.CountryName
	

SELECT c.ContinentCode, cu.CurrencyCode, COUNT(C.CurrencyCode)
	FROM Countries AS c
	JOIN Continents AS co ON c.ContinentCode = co.ContinentCode
	JOIN Currencies AS cu ON c.CurrencyCode = cu.CurrencyCode
	GROUP BY C.CurrencyCode


SELECT ContinentCode, CurrencyCode, CurrencyCount AS CurrencyUsage
FROM (SELECT ContinentCode,
             CurrencyCode,
             CurrencyCount,
             DENSE_RANK()
                     OVER (PARTITION BY ContinentCode
                         ORDER BY CurrencyCount DESC) AS CurrencyRank
      FROM (SELECT ContinentCode,
                   CurrencyCode,
                   COUNT(*) AS CurrencyCount
            FROM Countries
            GROUP BY ContinentCode, CurrencyCode
           ) AS CurrencyCountQuery
      WHERE CurrencyCount > 1) AS CurrencyRankingQuery
WHERE CurrencyRank=1
ORDER BY ContinentCode