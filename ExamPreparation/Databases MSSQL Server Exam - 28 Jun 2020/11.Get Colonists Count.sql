CREATE FUNCTION dbo.udf_GetColonistsCount(@PlanetName VARCHAR (30))
RETURNS INT
AS
BEGIN
RETURN
	(SELECT COUNT(c.Id) AS [Count]
		FROM Colonists c 
		JOIN TravelCards t ON t.ColonistId = c.Id
		JOIN Journeys j ON j.Id = t.JourneyId
		JOIN Spaceports s ON s.Id = j.DestinationSpaceportId
		JOIN Planets P ON p.Id = s.PlanetId
		WHERE p.[Name] = @PlanetName)
END


SELECT dbo.udf_GetColonistsCount('Otroyphus')
