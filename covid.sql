/****** view dataset  ******/
SELECT * FROM project.dbo.covid

---------------------------------delete serial number column as it is not needed----------------------------------
alter table project.dbo.covid
drop column "serial Number"

------------------------------------view distinct cells in each column in the data set
select distinct country from project.dbo.covid order by country

select distinct "total cases" from project.dbo.covid order by "total cases"

select distinct "active cases" from project.dbo.covid order by "active cases"

select distinct "total deaths" from project.dbo.covid order by "total deaths"

select distinct "total recovered" from project.dbo.covid order by "total recovered"

select distinct "total test" from project.dbo.covid order by "total test"

select distinct population from project.dbo.covid order by population

-----------------------------------Data exploration--------------------------------------------------

--------------------------------------country vs population----------------------------------
select country, population
from project.dbo.covid
order by population desc

-----------------------------country vs total cases/population--------------------
Select Country, Population, [Total Cases], ([Total Cases] / population)*100 as PercentInfected
From project.dbo.covid
group by Country, Population, [Total Cases]
order by PercentInfected desc

Select	Country, Population, MAX([Total Cases]) as InfectionCount,  Max(([Total Cases]/population))*100 as PercentInfected
From project.dbo.covid
Group by Country, Population
order by PercentInfected desc


-----------------------------------------country vs total cases-----------------------------------------
Select Country, MAX([Total Cases]) as TotalCase
From project.dbo.covid
Group by Country
order by TotalCase desc

-------------------------------------------total cases by country----------------------------------------------
Select Country, MAX([Total Deaths]) as TotalCase
From project.dbo.covid
Group by Country
order by TotalCase desc

----------------------------------------------total recovered by country------------------------------------
Select Country, [Total Cases], MAX([Total Recovered]) as TotalRecovered
From project.dbo.covid
Group by Country, [Total Cases]
order by TotalRecovered desc

-------------------------------total test by country------------------------------

Select Country, MAX([Total Test]) as TotalTest
From project.dbo.covid
Group by Country
order by TotalTest desc


---------------active cases-------------------------------------------------
Select Country, MAX([Active Cases]) as Active
From project.dbo.covid
Group by Country
order by Active desc

select * from project.dbo.covid



