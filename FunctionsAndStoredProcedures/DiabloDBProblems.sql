USE Diablo

GO

CREATE FUNCTION ufn_CashInUsersGames (@GameName NVARCHAR(50))
RETURNS TABLE
	AS
	RETURN SELECT SUM(Cash) AS SumCash
			FROM(
				SELECT 
					g.[Name],
					ug.Cash,
					ROW_NUMBER() OVER (PARTITION BY g.Name ORDER BY ug.Cash DESC ) AS [Row]
				FROM Games AS g
					JOIN UsersGames AS ug ON ug.GameId = g.Id
				WHERE g.[Name] = @GameName
				) AS Ranking
				WHERE [Row] % 2 <> 0
		
GO

SELECT * 
	FROM dbo.ufn_CashInUsersGames('Love in a mist')