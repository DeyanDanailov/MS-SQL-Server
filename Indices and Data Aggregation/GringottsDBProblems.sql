SELECT count(*) as Count
	FROM WizzardDeposits;


SELECT MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits


SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup


SELECT TOP(2) DepositGroup
	FROM WizzardDeposits
	GROUP BY DepositGroup
	ORDER BY AVG(MagicWandSize)

SELECT [avg].DepositGroup
	FROM (
SELECT  DepositGroup, AVG(MagicWandSize) as [AvgWandSize],
		ROW_NUMBER() OVER ( ORDER BY AVG(MagicWandSize) ) AS [Rank]
	FROM WizzardDeposits
	GROUP BY DepositGroup) as [avg]
	WHERE [avg].[Rank] IN (1,2)
	


SELECT  [DepositGroup], SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits	
	GROUP BY [DepositGroup]


SELECT  [DepositGroup], SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits	
	GROUP BY [DepositGroup], MagicWandCreator
	HAVING MagicWandCreator = 'Ollivander family'


SELECT  [DepositGroup], MagicWandCreator, MIN(DepositCharge)
	FROM WizzardDeposits	
	GROUP BY [DepositGroup], MagicWandCreator
	ORDER BY MagicWandCreator, [DepositGroup]

SELECT AgeGroup, COUNT(*) AS WizardCount
	FROM
(SELECT CASE
	WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	ELSE '[61+]'
	END AS AgeGroup

	FROM WizzardDeposits) AS AgeRankQuery
	GROUP BY AgeGroup
	