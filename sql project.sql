#Project II for July Cohort, 2023
#Instruction: 
#Join the 3 tables
#Use the 3 tables to answer all questions below
#Deadline sept 2nd ,2023


use sql_cohort;
select * from airbnb_last_review;
select * from airbnb_price;
select * from airbnb_room_type;

select * from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`);

select state, count(*) from airbnb_last_review join airbnb_price using (`listing_id`) group by state;

select host_name , nbhood_full, state from airbnb_last_review join airbnb_price using (`listing_id`);

#what is the total number of rows
select count(*) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`);

#view the host name, nbhood and state from the dataset
select host_name, nbhood_full, state from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`);

#count the number of states available
select count(distinct state) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`);

# view different states and prices of bnb in the dataset
select distinct state, price from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`);

#highest airbnb price
select max(price) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`);

#lowest bnb orice
select min(price) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`);

#average bnb price
select avg(price) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`);

# host name and bnhood with the lowest bnb price
#host name and nhbood with the hihgest bnb price
select host_name, nbhood_full, price from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`) 
where price in (16,2500) group by nbhood_full, host_name,price;


#describe the room type with the highest and lowest room type/price
select price, description from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`)
 where price in (16,2500) group by `description`, price;



# average price for a private room
select avg(price) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`)
 where room_type = 'private room';


#lowest price for a share room
select min(price) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`)
 where room_type = 'shared room';


#highest price for an entire room
select max(price) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`)
 where room_type = 'entire home/apt';


#sum of bnb prices in the month of june
select sum(price) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`)
where last_review_mons like '%jun%';


# revenue in the 2nd quarter
select sum(price) from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`)
where last_review_mons like '%ap%' or last_review_mons like '%may%' or last_review_mons like'%jun%';


#the host name for the highest bnb shared apartment
select host_name
from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`)
where room_type = 'shared room' and price = 115;


#what is the difference in price between the highest shared apartment and lowest private apartment
select (max(price)) - (min(price)) `Difference in Price`
from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`)
where room_type = 'shared room'; 

#are there differences in the apartment ?


#which apartment is best for rent and why?
select room_type, price, `description`, state, nbhood_full
from airbnb_last_review join airbnb_price using (`listing_id`) join airbnb_room_type using (`listing_id`) order by price desc; 
 