SELECT CONCAT(FirstName, ' ', LastName) AS Available
	FROM Mechanics
	WHERE Mechanics.MechanicId NOT IN 
	(SELECT 
		j.MechanicId
		FROM Mechanics m
		LEFT JOIN Jobs j ON j.MechanicId = m.MechanicId
		WHERE j.Status IN ('In Progress', 'Pending')
		GROUP BY m.FirstName, m.LastName, J.MechanicId
		)
	ORDER BY MechanicId
