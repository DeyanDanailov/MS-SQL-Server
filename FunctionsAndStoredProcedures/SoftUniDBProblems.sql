CREATE PROC usp_GetEmployeesSalaryAbove35000
	AS
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary > 35000

EXEC usp_GetEmployeesSalaryAbove35000

CREATE PROC usp_GetEmployeesSalaryAboveNumber @Salary DECIMAL(18,4)
	AS
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary >= @Salary

EXEC usp_GetEmployeesSalaryAboveNumber 48100


CREATE PROC usp_GetTownsStartingWith @StartingLetter NVARCHAR(50)
	AS
	SELECT [Name] AS Town
	FROM Towns
	WHERE [Name] LIKE @StartingLetter + N'%';
	GO

EXEC usp_GetTownsStartingWith 'C' 


CREATE PROC usp_GetEmployeesFromTown @TownName NVARCHAR(50)
	AS
	SELECT FirstName, LastName
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	WHERE t.[Name] = @TownName

EXEC usp_GetEmployeesFromTown 'Sofia'


CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18, 4))
    RETURNS varchar(7)
AS
BEGIN
    DECLARE @salaryLevel varchar(7);

    IF (@salary < 30000)
        SET @salaryLevel = 'Low';
    ELSE
        IF (@salary <= 50000)
            SET @salaryLevel = 'Average';
        ELSE
            SET @salaryLevel = 'High';
    RETURN @salaryLevel
END

SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) AS [Salary Level]
	FROM Employees

	ufn_IsWordComprised(@setOfLetters, @word) 