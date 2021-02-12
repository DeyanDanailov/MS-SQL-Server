CREATE OR ALTER FUNCTION udf_CalculateTickets(@origin VARCHAR(50), @destination VARCHAR(50), @peopleCount INT)
RETURNS VARCHAR(MAX)
AS 
BEGIN
	IF @peopleCount <= 0
	BEGIN
		RETURN 'Invalid people count!'
	END

	DECLARE @FlightId INT = (SELECT Id FROM Flights
							WHERE Origin = @origin AND
							Destination = @destination)
	IF(@FlightId IS NULL)
	BEGIN
		RETURN 'Invalid flight!'
	END

	DECLARE @Total DECIMAL(15,2) = @peopleCount*(SELECT Price FROM Tickets
									WHERE FlightId = @FlightId)

	RETURN 'Total price ' + CONVERT(VARCHAR(MAX), @Total)

END

SELECT dbo.udf_CalculateTickets('Kolyshley','Rancabolang', 33)
SELECT dbo.udf_CalculateTickets('Kolyshley','Rancabolang', -1)
SELECT dbo.udf_CalculateTickets('Invalid','Rancabolang', 33)