USE SoftUni

SELECT DepartmentID, SUM(Salary) AS TotalSalary
	FROM Employees
	GROUP BY DepartmentID


SELECT DepartmentID, MIN(Salary) as MinimumSalary
FROM Employees
WHERE DepartmentID IN (2, 5, 7)
  AND HireDate > '2000-01-01'
GROUP BY DepartmentID


SELECT DepartmentID,
       AVG(IIF(DepartmentID = 1, Salary + 5000, Salary)) AS AverageSalary
FROM (
         SELECT *
         FROM Employees
         WHERE Salary > 30000
           AND ManagerID != 42 OR ManagerID IS NULL
     ) AS FilteredQuery
GROUP BY DepartmentID


/*SECOND SOLUTION*/

SELECT * INTO EmployeesWithHightSalaries
FROM Employees
WHERE Salary>30000

DELETE
FROM EmployeesWithHightSalaries
WHERE ManagerID=42

UPDATE EmployeesWithHightSalaries
SET Salary += 5000
WHERE DepartmentID=1

SELECT DepartmentID, avg(Salary) as AverageSalary
FROM EmployeesWithHightSalaries
GROUP BY DepartmentID


SELECT DepartmentID, MAX(Salary) AS MaxSalary
	FROM Employees
	GROUP BY DepartmentID
	HAVING MAX(Salary) < 30000 OR  MAX(Salary) > 70000


SELECT COUNT(Salary) [Count]
	FROM Employees
	WHERE ManagerID IS NULL


SELECT DepartmentID, Salary AS ThirdHighestSalary
FROM (
	SELECT DepartmentID, Salary,
		DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS r
	FROM Employees
		GROUP BY DepartmentID, Salary) AS q
		WHERE q.r = 3

	/*SecondSolution*/
SELECT DISTINCT DepartmentID, FORMAT(Salary, 'F2') AS ThirdHightestSalary
FROM (SELECT DepartmentID,
             Salary,
             DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC)
                 AS SalaryRank
      FROM Employees
      ) AS SalaryRankingQuery
WHERE SalaryRank = 3


SELECT TOP(10) FirstName, LastName, e.DepartmentID
FROM (
	SELECT DepartmentID, AVG(Salary) AS AvgSalary
		FROM Employees
		GROUP BY DepartmentID) AS asq
		JOIN Employees e ON asq.DepartmentID = e.DepartmentID
		WHERE e.Salary > asq.AvgSalary

SELECT TOP (10) E.FirstName, E.LastName, E.DepartmentID
FROM Employees AS E
WHERE E.Salary >
      (
          SELECT AVG(Salary) AS AverageSalary
          FROM Employees AS eAverageSalary
          WHERE eAverageSalary.DepartmentID = E.DepartmentID
          GROUP BY DepartmentID)
ORDER BY DepartmentID