-- Data cleaning --

-- Separating location into individual columns for address, citystate and country; using parse */

SELECT Location
FROM space_missions

-- Replace periods with commas

SELECT
PARSENAME(REPLACE(Location, ',', '.'), 3) 
, PARSENAME(REPLACE(Location, ',', '.'), 2) 
, PARSENAME(REPLACE(Location, ',', '.'), 1) 
FROM space_missions

-- create 3 new columns for the newly split location

ALTER TABLE space_missions
ADD LaunchAddress NVARCHAR(200);

UPDATE space_missions
SET LaunchAddress = PARSENAME(REPLACE(location, ',', '.'), 3)

ALTER TABLE space_missions
ADD LaunchCitystate  NVARCHAR(200);

UPDATE space_missions
SET LaunchCitystate = PARSENAME(REPLACE(location, ',', '.'), 2)

ALTER TABLE space_missions
ADD LaunchCountry  NVARCHAR(200);

UPDATE space_missions
SET LaunchCountry = PARSENAME(REPLACE(location, ',', '.'), 1)

-- setting the null price to zero

UPDATE space_missions
SET price = 0 
WHERE price is NULL;

-- Data Exploration --

-- Total Country count 

SELECT COUNT(DISTINCT LaunchCountry) FROM space_missions As Total_Country;

-- Total rocket count

SELECT COUNT(DISTINCT Rocket) FROM space_missions As TotalRockets;

-- Total mission count

SELECT COUNT (DISTINCT mission) FROM space_missions As TotalMissions;

-- Company count

Select DISTINCT Company, COUNT(Company) 
From space_missions
Group BY Company 
Order BY 2 DESC;

-- Most active country on space

Select DISTINCT LaunchCountry, COUNT(LaunchCountry) as rocket_launched
from space_missions
Group BY LaunchCountry
Order BY rocket_launched DESC;

-- Rocket Status Count

SELECT DISTINCT RocketStatus, COUNT(RocketStatus) As NumberOfRockets
From space_missions
Group BY RocketStatus
ORDER BY 2 DESC;

-- Number of missions per year

With temptable as (
		SELECT *,
		YEAR(Date)as year from space_missions
)
SELECT year, COUNT(year)
From temptable
Group BY YEAR
ORDER BY 2 DESC; 

-- Missions by missionstatus

SELECT DISTINCT missionstatus, COUNT(missionstatus) as NumberOfMissions
FROM space_missions
GROUP BY missionstatus
ORDER BY 2 DESC;

-- What is the number of years under study

SELECT DATEDIFF(year, '1957-10-04', '2022-07-29') as YearsOfStudy;

-- Trend in Daily count of Missions over the years of investigation

SELECT Date, COUNT(mission) As Total_mission
From space_missions
GROUP BY Date ORDER BY Total_mission;

-- Total count of Missions by country

SELECT DISTINCT LaunchCountry, COUNT(LaunchCountry) As TotalMissions
FROM space_missions
GROUP BY LaunchCountry 
ORDER BY 2 DESC;

-- Top 10 Countries having active rockets

SELECT TOP (10) LaunchCountry, COUNT(Rocket)
FROM space_missions
WHERE RocketStatus = 'Active'
GROUP BY LaunchCountry
ORDER BY 2 DESC;

-- Top 10 most successful Rocket

SELECT Top (10) Rocket, COUNT(missionstatus) As missions
FROM space_missions
WHERE MissionStatus = 'Success'
GROUP BY Rocket 
Order BY 2 DESC; 

-- Top 10 most successful mission

SELECT Top (10) Mission, COUNT(MissionStatus)
from space_missions
Where MissionStatus = 'Success'
GROUP BY Mission
ORDER BY 2 DESC;

-- Average spendings by countrys on space missions
WITH temptable as (
		SELECT *,
					CAST(REPLACE(Price, ',', '') as float) as amount
FROM space_missions
)
SELECT launchcountry, round(avg(amount),2)
from temptable
where launchcountry is not NULL
Group BY launchcountry
Order BY 2 DESC;