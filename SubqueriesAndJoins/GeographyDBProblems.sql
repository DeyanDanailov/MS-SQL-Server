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

SELECT COUNT(*) AS [Count] 
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	WHERE mc.MountainId IS NULL


SELECT TOP(5) c.CountryName, 
		MAX(p.Elevation) AS HighestPeakElevation,
		MAX(r.Length) AS LongestRiverLength
	FROM Countries AS c
	LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
	LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Mountains AS m  ON mc.MountainId = m.Id
	LEFT JOIN Peaks AS p ON m.Id = p.MountainId
	GROUP BY c.CountryName
	ORDER BY HighestPeakElevation DESC, 
				LongestRiverLength DESC, 
				c.CountryName;


SELECT TOP (5) Country,
               CASE
                   WHEN PeakName IS NULL THEN '(no highest peak)'
                   ELSE PeakName
                   END AS [Highest Peak Name],
               CASE
                   WHEN Elevation IS NULL THEN 0
                   ELSE Elevation
                   END AS [Highest Peak Elevation],
               CASE
                   WHEN Mountain IS NULL THEN '(no mountain)'
                   ELSE Mountain
                   END AS Mountain
FROM (
         SELECT *,
                DENSE_RANK() OVER (PARTITION BY Country ORDER BY Elevation DESC)
                    AS PeakRank
         FROM (SELECT CountryName     AS Country,
                      p.PeakName,
                      p.Elevation,
                      M.MountainRange AS Mountain
               FROM Countries AS c
                        LEFT OUTER JOIN MountainsCountries MC
                                        ON c.CountryCode = MC.CountryCode
                        LEFT OUTER JOIN Mountains M
                                        ON MC.MountainId = M.Id
                        LEFT OUTER JOIN Peaks P
                                        ON M.Id = P.MountainId)
                  AS AllPeaksQuery)
         AS PeakRankingQuery
WHERE PeakRank = 1
ORDER BY Country, [Highest Peak Name]