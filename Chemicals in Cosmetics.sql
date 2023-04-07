---------------------------------------------------------------------------------- 
--DATA EXPLORATION
SELECT * FROM  [project].[dbo].['chemicals]

SELECT DISTINCT(BrandName) FROM  [project].[dbo].['chemicals]
ORDER BY BrandName

SELECT DISTINCT ProductName FROM  [project].[dbo].['chemicals]

SELECT DISTINCT(PrimaryCategory) FROM  [project].[dbo].['chemicals]
ORDER BY PrimaryCategory

SELECT DISTINCT(MostRecentDateReported) FROM  [project].[dbo].['chemicals]
ORDER BY MostRecentDateReported

SELECT DISTINCT(InitialDateReported) FROM  [project].[dbo].['chemicals]
ORDER BY InitialDateReported

SELECT DISTINCT(DiscontinuedDate) FROM  [project].[dbo].['chemicals]
ORDER BY DiscontinuedDate

SELECT DISTINCT(ChemicalDateRemoved) FROM  [project].[dbo].['chemicals]
ORDER BY ChemicalDateRemoved

SELECT DISTINCT(CompanyName), CompanyId FROM  [project].[dbo].['chemicals]
GROUP BY CompanyName, CompanyId
ORDER BY CompanyName

SELECT * FROM  [project].[dbo].['chemicals]
where CompanyName like '%added extras%' 


---------------------------------------------------------------------------------- 
-- DATA CLEANING

SELECT MostRecentDateReported, CONVERT(DATE,MostRecentDateReported) AS DATE 
FROM  [project].[dbo].['chemicals]

ALTER TABLE  [project].[dbo].['chemicals]
ALTER COLUMN MostRecentDateReported DATE

ALTER TABLE  [project].[dbo].['chemicals]
ALTER COLUMN InitialDateReported DATE

ALTER TABLE  [project].[dbo].['chemicals]
ALTER COLUMN DiscontinuedDate DATE

ALTER TABLE  [project].[dbo].['chemicals]
ALTER COLUMN ChemicalCreatedAt DATE

ALTER TABLE  [project].[dbo].['chemicals]
ALTER COLUMN ChemicalUpdatedAt DATE

ALTER TABLE  [project].[dbo].['chemicals]
ALTER COLUMN ChemicalDateRemoved DATE

SELECT * FROM  [project].[dbo].['chemicals]

SELECT DISTINCT(BrandName),CDPHId,CSFId,SubCategoryId,ChemicalId
FROM  [project].[dbo].['chemicals]
WHERE BrandName IS NULL
GROUP BY CDPHId,CSFId,SubCategoryId,ChemicalId,BrandName

-- CLEANING CHARACTERS '�' 
SELECT DISTINCT ProductName, REPLACE(ProductName, '�', '') AS ProductNameUpdated
FROM  [project].[dbo].['chemicals]
WHERE ProductName LIKE '%�%'

SELECT DISTINCT BrandName, REPLACE(BrandName, '', '') AS BrandNameUpdated
FROM  [project].[dbo].['chemicals]
WHERE BrandName LIKE '%�%'

SELECT DISTINCT CompanyName, REPLACE(CompanyName, '�', '') AS CompanyNameUpdated
FROM  [project].[dbo].['chemicals]
WHERE CompanyName LIKE '%�%'

UPDATE  [project].[dbo].['chemicals]
SET ProductName = REPLACE(ProductName, '�', '')

UPDATE  [project].[dbo].['chemicals]
SET BrandName = REPLACE(BrandName, '�', '')

UPDATE  [project].[dbo].['chemicals]
SET CompanyName = REPLACE(CompanyName, '�', '')

-- CORRECTING ERRORS IN COMPANY
SELECT DISTINCT(CompanyName)
FROM  [project].[dbo].['chemicals]
ORDER BY CompanyName DESC

UPDATE  [project].[dbo].['chemicals]
SET CompanyName = CASE 
						WHEN CompanyName LIKE '%Vi-Jon%' THEN 'Vi-Jon, Inc.'
						WHEN CompanyName LIKE '%Stila Style%' THEN 'Stilla Styles LLC'
						WHEN CompanyName LIKE '%Shiseido%' THEN 'Shiseido Americas Corporation'
						WHEN CompanyName LIKE '%Neostrata%' THEN 'Neostrata Company Inc.'
						WHEN CompanyName LIKE '%LVMH%' THEN 'LVMH Fragrance Brands LLC'
						WHEN CompanyName LIKE '%Lush%' THEN 'Lush Manufacturing Ltd'
						WHEN CompanyName LIKE '%PAYOT%' THEN 'Laboratories Dr N.G. Payot'
						WHEN CompanyName LIKE '%Interparfums%' THEN 'Inter Parfums, Inc.'
						WHEN CompanyName LIKE '%Fresh%' THEN 'Fresh Inc.'
						WHEN CompanyName LIKE '%Cover FX%' THEN 'Cover FX Skin Care Inc.'
						WHEN CompanyName LIKE '%Arcadia Beauty%' THEN 'Arcadia Beauty Labs LLC'
						WHEN CompanyName LIKE '%Apollo Health%' THEN 'Apollo Health and Beauty Care Inc.'
						WHEN CompanyName LIKE '%American Consumer%' THEN 'American Consumer Products LLC'
						ELSE CompanyName
					END


SELECT * FROM  [project].[dbo].['chemicals]

-- DATA ANALYSIS (SOLUTION TO QUESTIONS)

-- 1) To Find out which chemicals were used the most in cosmetics and personal care products.

SELECT TOP 10 ChemicalName, COUNT(ChemicalName) as TotalChemicals
FROM [project].[dbo].['chemicals]
WHERE PrimaryCategoryId = 74 OR PrimaryCategoryId = 44
GROUP BY ChemicalName
ORDER BY TotalChemicals DESC


-- 2) Find out which companies used the most reported chemicals in their cosmetics and personal care products.

select CompanyName, count(MostRecentDateReported) as ReportedChem 
from [project].[dbo].['chemicals]
where PrimaryCategoryId=74 or PrimaryCategoryId=44
group by ChemicalName,companyName, PrimaryCategory order by ReportedChem desc

-- 3) Which brands had chemicals that were removed and discontinued? Identify the chemicals.

select distinct BrandName, chemicalname
from [project].[dbo].['chemicals] 
where DiscontinuedDate is not NULL and ChemicalDateRemoved is not null

-- 4) Identify the brands that had chemicals which were mostly reported in 2018.

SELECT BrandName, COUNT(MostRecentDateReported) AS TimesReported
FROM [project].[dbo].['chemicals]
WHERE YEAR(MostRecentDateReported) = 2018
GROUP BY BrandName
ORDER BY TimesReported DESC

-- 5) Which brands had chemicals discontinued and removed?

select distinct BrandName 
from [project].[dbo].['chemicals]
where ChemicalDateRemoved is not NULL and DiscontinuedDate is not NULL

-- 6) Identify the period between the creation of the removed chemicals and when they were actually removed.

SELECT ChemicalName, MIN(YEAR(ChemicalCreatedAt)) AS FirstYearCreated, 
					 MAX(YEAR(ChemicalDateRemoved)) AS LastestYearRemoved, 
					 MAX(DATEDIFF(DAY, ChemicalCreatedAt, ChemicalDateRemoved)) AS DaysBetween
FROM [project].[dbo].['chemicals]
WHERE ChemicalDateRemoved IS NOT NULL
GROUP BY ChemicalName
ORDER BY DaysBetween DESC


-- 7) Can you tell if discontinued chemicals in bath products were removed.

select ChemicalName,DiscontinuedDate,ChemicalRemovedDate,PrimaryCategory 
from [project].[dbo].['chemicals]
where DiscontinuedDate is not NULL and ChemicalRemovedDate is not NULL
and PrimaryCategoryId=6
order by ChemicalName


-- 8) How long were removed chemicals in baby products used? (Tip: Use creation date to tell)

SELECT PrimaryCategory, ChemicalName, ChemicalCreatedAt, ChemicalDateRemoved, MAX(DATEDIFF(DAY, ChemicalCreatedAt, ChemicalDateRemoved)) AS DaysBetween
FROM [project].[dbo].['chemicals]
WHERE PrimaryCategory LIKE '%Baby Products%'
	 AND ChemicalDateRemoved IS NOT NULL and ChemicalCreatedAt IS NOT NULL
GROUP BY PrimaryCategory, ChemicalName, ChemicalCreatedAt, ChemicalDateRemoved
ORDER BY DaysBetween DESC

--9) Identify the relationship between chemicals that were mostly recently reported and discontinued. (Does most recently reported chemicals equal discontinuation of such chemicals?)

SELECT ChemicalName, MIN(MostRecentDateReported) EarliestDateReported, 
					 MAX(DiscontinuedDate) AS LatestDateDiscontinued
FROM [project].[dbo].['chemicals]
WHERE MostRecentDateReported IS NOT NULL AND DiscontinuedDate IS NOT NULL
GROUP BY ChemicalName

-- 10) Identify the relationship between CSF and chemicals used in the most manufactured sub categories. (Tip: Which chemicals gave a certain type of CSF in sub categories?)

SELECT ChemicalName, CSF, SubCategory, COUNT(SubCategory) AS MostManufactured
FROM [project].[dbo].['chemicals]
WHERE CSF IS NOT NULL AND ChemicalName IS NOT NULL
GROUP BY ChemicalName, CSF, SubCategory
ORDER BY MostManufactured DESC