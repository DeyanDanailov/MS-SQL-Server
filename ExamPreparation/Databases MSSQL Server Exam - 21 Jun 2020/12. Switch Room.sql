CREATE PROCEDURE usp_SwitchRoom(@TripId INT, @TargetRoomId INT)
AS 
BEGIN
	DECLARE @TargetRoomHotel INT = (SELECT HotelId FROM Rooms
								WHERE Id = @TargetRoomId)
	DECLARE @TripHotel INT = (SELECT R.HotelId
								FROM Trips t
								JOIN Rooms r ON t.RoomId = r.Id
								WHERE t.Id = @TripId)
	IF(@TripHotel <> @TargetRoomHotel)
	THROW 50001, 'Target room is in another hotel!', 1

	DECLARE @TargetRoomBeds INT = (SELECT Beds FROM Rooms
							WHERE Id = @TargetRoomId)

	DECLARE @NumberOfAccounts INT = (SELECT COUNT(AccountId) FROM AccountsTrips
									WHERE TripId = @TripId)
	IF(@NumberOfAccounts > @TargetRoomBeds)
	THROW 50002, 'Not enough beds in target room!', 1

	--DECLARE @TripRoomId INT = (SELECT r.Id FROM Rooms r
	--							JOIN Trips t ON t.RoomId = r.Id
	--							WHERE t.Id = @TripId)
	UPDATE Trips
	SET RoomId = @TargetRoomId
	WHERE Id = @TripId
END
GO

EXEC usp_SwitchRoom 10, 8
