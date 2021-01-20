--Display all mountain peaks in alphabetical order.
SELECT PeakName
	FROM Peaks
	ORDER BY PeakName

--Find the 30 biggest countries by population from Europe. 
--Display the country name and population. Sort the results by population 
--(from biggest to smallest), then by country alphabetically.
SELECT TOP(30) CountryName, [Population]
	FROM Countries
	WHERE ContinentCode = 'EU'
	ORDER BY [Population] DESC, CountryName

--Find all countries along with information about their currency.
--Display the country name, country code and information about its currency:
--either "Euro" or "Not Euro". Sort the results by country name alphabetically.
--*Hint: Use CASE … WHEN.
SELECT *FROM Currencies

SELECT CountryName,CountryCode,
       CASE
       when CurrencyCode='Eur' THEN 'Euro'
ELSE 'Not Euro'
         END  AS 'Currency'
FROM Countries
ORDER BY CountryName

