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


CREATE PROC usp_EmployeesBySalaryLevel @LevelOfSalary NVARCHAR(7)
	AS
	SELECT FirstName, LastName
		FROM
		Employees
		WHERE dbo.ufn_GetSalaryLevel(Salary) = @LevelOfSalary

EXEC usp_EmployeesBySalaryLevel 'High'

CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters varchar(max), @word varchar(max))
    RETURNS bit AS
BEGIN
    DECLARE @WordLength int=LEN(@word);
    DECLARE @Index int=1;

    WHILE (@Index <= @WordLength)
        BEGIN
            IF (CHARINDEX(SUBSTRING(@word, @Index, 1), @setOfLetters)=0)
                BEGIN
                    RETURN 0
                END

            SET @Index+=1
        END
    RETURN 1
END
GO

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')
SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves')
SELECT dbo.ufn_IsWordComprised('bobr', 'Rob')
SELECT dbo.ufn_IsWordComprised('pppp', 'Guy')
GO


CREATE PROC usp_DeleteEmployeesFromDepartment(@departmentId INT)
AS
BEGIN
    --first delete all records from EmployeesProjects where EmployeeId is in to-be-deleted IDs

    DELETE
    FROM EmployeesProjects
    WHERE EmployeeID IN (SELECT EmployeeID
                         FROM Employees
                         WHERE DepartmentID = @departmentId);
    --set managerId to null where Manager is an Employee who is going to be deleted

    UPDATE Employees
    SET ManagerID=NULL
    WHERE ManagerID IN (SELECT EmployeeID
                        FROM Employees
                        WHERE DepartmentID = @departmentId);
--Alter column ManagerId in Departments table and make it nullable

    ALTER TABLE Departments
        ALTER COLUMN ManagerID int;

    UPDATE Departments
    SET ManagerID = NULL
    WHERE ManagerID IN (SELECT EmployeeID
                        FROM Employees
                        WHERE DepartmentID = @departmentId);

    --delete employees from departments

    DELETE FROM Employees
    WHERE DepartmentID=@departmentId

    DELETE FROM Departments
    where DepartmentID=@departmentId

    SELECT count(*)
    FROM Employees
    where DepartmentID=@departmentId

END

EXEC usp_DeleteEmployeesFromDepartment 10