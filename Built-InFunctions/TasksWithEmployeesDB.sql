SELECT FirstName, LastName
	FROM Employees
	WHERE FirstName LIKE 'SA%'

SELECT FirstName, LastName
	FROM Employees
	WHERE LastName LIKE '%ei%'

SELECT FirstName
	FROM Employees
	WHERE DepartmentID in (3,10)
    AND YEAR(HireDate) BETWEEN 1995 AND 2005

SELECT FirstName, LastName
	FROM Employees
	WHERE JobTitle NOT LIKE '%ENGINEER%'

SELECT [Name]
	FROM Towns
	WHERE LEN(Name) = 5 OR LEN(Name) = 6
	ORDER BY [Name]

SELECT *
	FROM Towns
	WHERE [NAME] LIKE '[M,K,B,E]%'
	ORDER BY [Name]

SELECT *
	FROM Towns
	WHERE [NAME] NOT LIKE '[R,D,B]%'
	ORDER BY [Name]
	GO

CREATE VIEW [V_EmployeesHiredAfter2000] AS
	SELECT FirstName, LastName
		FROM Employees
		WHERE YEAR(HireDate) > 2000
		GO

SELECT FirstName, LastName
	FROM Employees
	WHERE LEN(LastName) = 5

SELECT *
	FROM
(SELECT E.EmployeeID, E.FirstName, E.LastName, E.Salary
    ,DENSE_RANK() OVER   
    (PARTITION BY E.Salary ORDER BY E.EmployeeID) AS [Rank]
FROM Employees AS E
WHERE E.Salary BETWEEN 10000 AND 50000
) AS R
	WHERE R.[Rank] = 2
	ORDER BY R.Salary DESC;