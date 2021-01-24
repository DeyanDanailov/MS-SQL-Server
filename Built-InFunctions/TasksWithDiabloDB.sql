SELECT TOP ( 50) [Name], FORMAT([Start], 'yyyy-MM-dd') as [Start]	
	FROM Games
	WHERE YEAR([Start]) IN (2011, 2012)
	ORDER BY [Start], [Name]

SELECT Username, RIGHT(Email, LEN(Email) - CHARINDEX('@',[Email])) AS [Email Provider]
	FROM Users
	ORDER BY [Email Provider], [Username]

SELECT Username, IpAddress
	FROM Users
	WHERE IpAddress LIKE '___.1_%._%.___'
	ORDER BY [Username]
	
SELECT Name,
       CASE
           WHEN DATEPART(HOUR, Start) BETWEEN 0 AND 11 THEN 'Morning'
           WHEN DATEPART(HOUR, Start) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
           END AS [Part of the Day],
       CASE
           WHEN Duration <= 3 THEN 'Extra Short'
           WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
           WHEN Duration > 6 THEN 'Long'
           ELSE 'Extra Long'
           END AS [Duration]
FROM Games AS g
ORDER BY Name, Duration

SELECT ProductName,
       OrderDate,
       DATEADD(DAY, 3, OrderDate)   AS [Pay Due],
       DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
FROM Orders

SELECT Name,
       DATEDIFF(YEAR, Birthdate, GETDATE())   AS [Age in Years],
       DATEDIFF(MONTH, Birthdate, GETDATE())  AS [Age in Months],
       DATEDIFF(DAY, Birthdate, GETDATE())    AS [Age in Days],
       DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
FROM People