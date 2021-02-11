CREATE PROC usp_ChangeJourneyPurpose (@JourneyId INT, @NewPurpose VARCHAR(11))
AS
	BEGIN
		IF(@JourneyId NOT IN (SELECT Id FROM Journeys))
		THROW  50001, 'The journey does not exist!',1  
		IF (@JourneyId IN (SELECT Id FROM Journeys
							WHERE Purpose LIKE @NewPurpose))
		THROW  50002, 'You cannot change the purpose!',1
		ELSE 
			UPDATE Journeys
			SET Purpose = @NewPurpose
			WHERE Id = @JourneyId
	END

EXEC usp_ChangeJourneyPurpose 196, 'Educational'