 CREATE PROC usp_GetHoldersFullName
 AS
 SELECT FirstName + ' ' + LastName AS FullName
	FROM AccountHolders
GO

CREATE PROC usp_GetHoldersWithBalanceHigherThan @Money DECIMAL(18,4)
AS
BEGIN
	SELECT FirstName, LastName
		FROM AccountHolders 
			JOIN (
			SELECT a.AccountHolderId
				FROM AccountHolders AS ah
				JOIN Accounts AS a ON a.AccountHolderId = ah.Id			
				GROUP BY AccountHolderId
				HAVING SUM(A.Balance) > @Money) AS b
				ON AccountHolders.Id = B.AccountHolderId
				ORDER BY FirstName, LastName
END

EXEC usp_GetHoldersWithBalanceHigherThan 100000

use Bank
GO

CREATE FUNCTION ufn_CalculateFutureValue ( @Sum DECIMAL(18,4), @YearlyInterestRate FLOAT, @NumberOfYears int )
	RETURNS DECIMAL(18,4)
AS
BEGIN
	DECLARE @FutureValue DECIMAL(18,4) = 0;
	SET @FutureValue = @Sum * (POWER(1 + @YearlyInterestRate, @NumberOfYears))
	RETURN @FutureValue;
END

GO 

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
GO

CREATE PROC usp_CalculateFutureValueForAccount @AccountId INT, @InterestRate FLOAT
AS
BEGIN
	SELECT ah.Id AS [Account Id],
			ah.FirstName AS [First Name],
			ah.LastName AS [Last Name],
			a.Balance AS [Current Balance],
			dbo.ufn_CalculateFutureValue(a.Balance, @InterestRate, 5) AS [Balance in 5 years]
		FROM AccountHolders AS ah
		JOIN Accounts AS a ON a.AccountHolderId = ah.Id
		WHERE ah.Id = @AccountId 
END

EXEC usp_CalculateFutureValueForAccount 1, 0.1