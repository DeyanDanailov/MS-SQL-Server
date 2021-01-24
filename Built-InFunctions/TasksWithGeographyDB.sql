SELECT CountryName, IsoCode
	FROM Countries
	WHERE CountryName LIKE '%A%A%A%'
	ORDER BY IsoCode

SELECT PeakName,
       RiverName,
       LOWER(
               CONCAT(P.PeakName,
                      SUBSTRING(
                              R.RiverName, 2,
                              LEN(R.RiverName) - 1)))
           AS Mix
	FROM Peaks AS P
	JOIN Rivers AS R
	ON RIGHT(P.PeakName, 1) = LEFT(R.RiverName, 1)
	ORDER BY Mix
	
SELECT PeakName,
       RiverName,
       LOWER(
               CONCAT(P.PeakName,
                      SUBSTRING(
                              R.RiverName, 2,
                              LEN(R.RiverName) - 1)))
           AS Mix
FROM Peaks AS P,
     Rivers AS R
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix