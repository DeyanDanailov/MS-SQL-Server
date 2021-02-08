SELECT f.ProductId, f.Rate, f.Description, c.Id, c.Age, c.Gender
	FROM Feedbacks f
	JOIN Customers c ON c.Id = f.CustomerId
	WHERE f.Rate < 5.0
	ORDER BY f.ProductId DESC, f.Rate