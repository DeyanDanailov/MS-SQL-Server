CREATE OR
ALTER PROC usp_PlaceOrder(@jobId int, @partNumber varchar(50), @quantity int)
AS
BEGIN
    BEGIN TRANSACTION
        IF (@quantity <= 0)
            BEGIN
                THROW 50012, 'Part quantity must be more than zero!',1
            END
        IF (@jobId IN (SELECT JobId FROM Jobs WHERE Status LIKE 'Finished'))
            BEGIN
                THROW 50011, 'This job is not active!',1
            END

        IF (@jobId NOT IN (SELECT JobId FROM Jobs))
            BEGIN
                THROW 50013, 'Job not found!',1
            END
        IF (@partNumber NOT IN (SELECT SerialNumber FROM Parts))
            BEGIN
                THROW 50014, 'Part not found!',1
            END
        IF (@jobId IN (SELECT JobId FROM Orders) AND (SELECT IssueDate FROM Orders WHERE JobId = @jobId) IS NULL)
            BEGIN
                DECLARE @orderId int = (SELECT OrderId FROM Orders WHERE JobId = @jobId AND IssueDate IS NULL)
                DECLARE @partId int= (SELECT PartId FROM Parts WHERE SerialNumber = @partNumber)
                IF (@orderId IN (SELECT OrderId FROM OrderParts) AND @partId IN (SELECT PartId FROM OrderParts))
                    BEGIN
                        UPDATE OrderParts
                        SET Quantity+=@quantity
                        WHERE OrderId = @orderId
                          AND PartId = @partId
                    END
                ELSE
                    BEGIN
                        INSERT INTO OrderParts(OrderId, PartId, Quantity)
                        VALUES (@orderId, @partId, @quantity)
                    END


            END
    COMMIT
END

DECLARE @err_msg AS NVARCHAR(MAX);
BEGIN TRY
    EXEC usp_PlaceOrder 1, 'ZeroQuantity', 0
END TRY
BEGIN CATCH
    SET @err_msg = ERROR_MESSAGE();
    SELECT @err_msg
END CATCH