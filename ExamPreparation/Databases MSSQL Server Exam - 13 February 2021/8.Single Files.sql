
SELECT 	pf.Id, 
		pf.Name,
		CONVERT(VARCHAR, pf.Size) + 'KB' AS Size
	FROM Files cf
	RIGHT JOIN Files pf ON pf.Id = cf.ParentId 
	WHERE Cf.ParentId  IS NULL 
	ORDER BY pf.Id, pf.Name, pf.Size DESC