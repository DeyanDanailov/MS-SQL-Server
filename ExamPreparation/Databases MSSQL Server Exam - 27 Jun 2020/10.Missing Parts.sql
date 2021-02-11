SELECT *
	FROM
(SELECT p.PartId,
		P.Description,
		SUM(pn.Quantity) AS Required,
		SUM(p.StockQty) AS [In Stock],
		SUM(op.Quantity) AS [Ordered]
	FROM Parts p
		JOIN OrderParts op ON op.PartId = p.PartId
		JOIN Orders o ON o.OrderId = op.OrderId
		JOIN Jobs j ON j.JobId = o.JobId
		JOIN PartsNeeded pn ON pn.PartId = p.PartId
	WHERE j.Status <> 'Finished'
	GROUP BY p.PartId, p.Description) AS K
	WHERE K.Required > K.[In Stock]
	ORDER BY K.PartId 