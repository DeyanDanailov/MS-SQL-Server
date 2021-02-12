USE TripService

--Find the longest and shortest trip for each account, in days.
--Filter the results to accounts with no middle name and trips, 
--which are not cancelled (CancelDate is null).
--Order the results by Longest Trip days (descending), 
--then by Shortest Trip (ascending).

SELECT *
	FROM
	(SELECT a.Id AS AccountId,
				CONCAT(a.FirstName,' ', a.LastName) AS FullName,
				MAX(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate)) AS LongestTrip,
				MIN(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate)) AS ShortestTrip
		FROM Accounts a
			JOIN AccountsTrips at ON at.AccountId = a.Id
			JOIN Trips t ON t.Id = at.TripId
			GROUP BY a.Id, a.FirstName, a.LastName, a.MiddleName, t.CancelDate
			HAVING a.MiddleName IS NULL 
				AND t.CancelDate IS NULL) AS t
			ORDER BY t.LongestTrip DESC, t.ShortestTrip