#this is a basic example for your project

#Data Analyst SQL Project 1:
#Instruction: 
#Create a table  of your choice 
#Example: #Table: clubs
#Columns: club name, club id, club staff, club colour, club location, club no of trophies, club years of existences
#Entries:.. man u, man city, arsenal……….up to 20


use sql_cohort;
drop table if exists Football_Clubs;
create table Football_Clubs
(Name varchar (250),
Age int,
Total_Staff int,
Location varchar (300),
Goals int,
Trophies varchar (500),
No_Of_Trophies int);

insert into Football_Clubs values
('Arsenal FC', 123, 1034, 'England', 33440, "EPL,FA CUP, EFL, COMMUNITY SHIELD", 70),
('Chelsea FC', 95, 2230, 'England', 33549, "EPL,FA CUP, EFL, CL, COMMUNITY SHIELD", 35),
('Eyimba FC', 20, 75, 'Nigeria', 1422, "NPL,FA CUP", 15),
('Lobbi Stars', 12, 1000, 'Nigeria', 440, "	NPL,FA CUP", 5),
('Real Madrid', 325, 45091, 'Spain', 233641, "La Liga,CL, CWC", 350),
('Barcelona', 301, 10039, 'Spain', 193450, "La Liga,CL, CWC", 240),
('Liverpool', 230, 2084, 'England', 173440, "EPL,FA CUP, EFL, COMMUNITY SHIELD", 145),
('Manchester United', 249, 34034, 'England', 192541, "EPL,FA CUP, EFL, CL, COMMUNITY SHIELD", 200),
('Bayern Muchen', 99, 12067, 'Germany', 133999, "Bundesliga,CL", 95),
('PSG', 56, 1610, 'France', 14498, "CL, FL", 45);


select * from Football_Clubs;

#club and no of trophies
select name, no_of_trophies from Football_Clubs order by no_of_trophies desc;

#oldest club
select name, age from football_clubs order by age desc limit 1;

#most goals by a club
select name, goals from football_clubs order by goals desc limit 1;

# club with most staff
select name, total_staff from football_clubs order by total_staff desc limit 1;

#total tophies won by a english club
select sum(no_of_trophies) trophies from football_clubs where location = 'England';

#count total entries
select count(*) from football_clubs;

#average goals by a club
select avg(goals) from football_clubs;

#avg goals scored in england
select avg(goals) from football_clubs where location = 'England';

#clubs in england with champions league trophy
select * from football_clubs where trophies like '%Cl%' and location = 'England';
