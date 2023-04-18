/****** VIEW DATASET  ******/
select * from Laptop

------------------------------------DATA CLEANING---------------------------------------------
alter table laptop
 drop column f1

 alter table laptop
 drop column imgurl 

--------------------------------------Data Exploration-----------------------------------------
select distinct Company from [Laptop] 
select distinct Rating from [Laptop] 
select distinct No_of_ratings from [Laptop] 
select distinct Review from [Laptop] 
select distinct Size from [Laptop] 
select distinct Processor from [Laptop] 
select distinct RAM from [Laptop] 
 select distinct Memory from [Laptop]
select distinct OpSys from [Laptop] 
select distinct Price from [Laptop] 
select distinct MRP from [Laptop] 
 
 
select Company, No_of_ratings, Processor, OpSys, price memory, ram from Laptop where Company = 'hp' order by memory desc

select top 5 Processor, Company, MRP from Laptop

select company, sum(No_of_ratings) rate from Laptop group by Company order by rate desc

select company, RAM, round(AVG(price), 2) averageprice from Laptop group by Company, RAM order by Company desc

select company, Processor, round(AVG(price), 2) averageprice from Laptop group by Company, Processor order by Company desc

select company, Size, round(AVG(price), 2) averageprice from Laptop group by Company, Size order by Company desc


 SELECT * FROM Laptop



