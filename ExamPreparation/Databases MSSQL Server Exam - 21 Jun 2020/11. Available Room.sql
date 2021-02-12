CREATE FUNCTION udf_GetAvailableRoom
				(@HotelId INT, @Date DATETIME, @People INT)
RETURNS NVARCHAR(MAX)
AS 
BEGIN
	DECLARE @ResultMesssage NVARCHAR(MAX);
	IF(@HotelId NOT IN (SELECT HotelId FROM Rooms))
	RETURN 'No rooms available'
	
	DECLARE @RoomId INT =
		(SELECT TOP(1) r.Id
			FROM Rooms r
			JOIN Trips t ON t.RoomId = r.Id
			WHERE r.HotelId = @HotelId
				AND 
				((@Date NOT BETWEEN t.ArrivalDate AND t.ReturnDate)
				OR t.CancelDate IS NOT NULL)
				AND r.Beds >= @People
			ORDER BY r.Price DESC)
	IF(@RoomId IS NULL)
	RETURN 'No rooms available'
	ELSE
		BEGIN
		DECLARE @RoomType NVARCHAR(MAX) = (SELECT [Type] FROM Rooms
										WHERE Id = @RoomId) 
		DECLARE @Beds INT = (SELECT Beds FROM Rooms
										WHERE Id = @RoomId)
		DECLARE @RoomPrice DECIMAL(18,2) = (SELECT Price FROM Rooms
										WHERE Id = @RoomId)
		DECLARE @BaseRate DECIMAL(18,2) = (SELECT BaseRate FROM Hotels
										WHERE Id = @HotelId)
		DECLARE @TotalPrice DECIMAL(18,2) = 
									(@BaseRate + @RoomPrice)* @People
		SET @ResultMesssage ='Room ' + CAST(@ROOMID AS NVARCHAR(3)) +': ' + @ROOMTYPE+
           ' (' + CAST(@BEDS AS NVARCHAR(2)) +' beds) - $' + CAST(@TOTALPRICE AS NVARCHAR(20))

		END
	
	RETURN @ResultMesssage;
END

SELECT dbo.udf_GetAvailableRoom(112, '2011-12-17', 2)