SELECT TOP ( 50) [Name], FORMAT([Start], 'yyyy-MM-dd') as [Start]	
	FROM Games
	WHERE YEAR([Start]) IN (2011, 2012)
	ORDER BY [Start], [Name]

SELECT Username, RIGHT(Email, LEN(Email) - CHARINDEX('@',[Email])) AS [Email Provider]
	FROM Users
	ORDER BY [Email Provider], [Username]
	