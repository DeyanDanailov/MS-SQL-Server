CREATE FUNCTION udf_GetCost (@JobId INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
DECLARE @sum decimal(18, 2)= (SELECT SUM(P.Price)
                                      FROM Orders AS O
                                               JOIN OrderParts OP ON O.OrderId = OP.OrderId
                                               JOIN Parts AS P ON OP.PartId = P.PartId
                                      WHERE O.JobId = @jobId
                                      GROUP BY O.JobId
        )
        IF (@sum IS NULL)
            BEGIN
                RETURN 0;
            END
        RETURN @sum;
END

SELECT dbo.udf_GetCost (1)