SELECT DistributorName, IngredientName, ProductName, AVG
FROM (
SELECT D.Name AS DistributorName,
       I.Name AS IngredientName,
        P.Name AS ProductName,
        AVG(F.Rate) AS AVG
FROM Distributors AS D
JOIN Ingredients I on D.Id = I.DistributorId
JOIN ProductsIngredients PI on I.Id = PI.IngredientId
JOIN Products P on P.Id = PI.ProductId
JOIN Feedbacks F on P.Id = F.ProductId
GROUP BY D.Name, I.Name, P.Name) AS RANK
WHERE AVG BETWEEN 5.0 AND 8.0
ORDER BY DistributorName, IngredientName,ProductName