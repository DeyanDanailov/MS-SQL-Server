CREATE PROCEDURE usp_SearchForFiles @fileExtension VARCHAR(10)
AS 
BEGIN
SELECT Id, Name, CONVERT(VARCHAR, Size) + 'KB' AS Size
	FROM Files
	WHERE Name LIKE '%.' + @fileExtension 
	ORDER BY Id, Name, Size DESC
END

EXEC usp_SearchForFiles 'txt'