USE TripService

--Make all rooms’ prices 14% more expensive where the hotel ID
--is either 5, 7 or 9.

UPDATE Rooms
	SET Price *= 1.14
	WHERE HotelId IN (5,7,9)