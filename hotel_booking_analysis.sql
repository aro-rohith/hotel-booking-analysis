create database hotel_booking;
use hotel_booking;

SELECT count(*) FROM hotel_booking;
select * from hotel_booking limit 5;

-- Business Question 1:
-- Which hotel type has the highest number of bookings?

select
	hotel,
	count(*) as total_booking
from hotel_booking
group by hotel
order by total_booking desc;
	
-- Business Question 2:
-- Which hotel has the highest cancellation rate?

select
	hotel,
    round(sum(is_canceled) / (count(*)) * 100,2) as cancellation_percentage
from hotel_booking
group by hotel
order by cancellation_percentage desc;

-- Business Question 3:
-- Which hotel has the most repeat guests?

select
	hotel,
    sum(is_repeated_guest) as total_repeated_guests
from hotel_booking
group by hotel
order by total_repeated_guests desc;

-- Business Question 4:
-- How many current bookings are from customers with previous cancellations, by hotel?

select
	hotel,
    count(*) as customers_with_previous_cancellations
from hotel_booking
where previous_cancellations > 0
group by hotel
order by customers_with_previous_cancellations desc;

-- Business Question 5:
-- How many customers have at least one previous successful booking, by hotel?

select
	hotel,
    count(*) as customers_with_previous_successful_booking
from hotel_booking
where previous_bookings_not_canceled > 0
group by hotel
order by customers_with_previous_successful_booking desc;

-- Business Question 6:
-- How many bookings include weekend stays vs weekday stays for each hotel?

select
	hotel,
    sum(case when stays_in_weekend_nights > 0 then 1 else 0 end) as weekend_bookings,
    sum(case when stays_in_week_nights > 0 then 1 else 0 end) as weekday_bookings
    from hotel_booking
    group by hotel;

-- Business Question 7:
-- Does the number of booking changes affect cancellation rates?

select
	booking_changes,
	count(*) as total_booking_changes,
    sum(is_canceled) as cancelled,
    round(sum(is_canceled) / count(*) * 100 , 2) as cancellation_percentage
from hotel_booking
group by booking_changes
order by booking_changes asc;

-- Business Question 8:
-- Did customers receive the room type they reserved?

select
	case
		when reserved_room_type = assigned_room_type then 'Same room' 
        else 'Different Room' 
	end as received_reserved_room,
    count(*) as total_booking
from hotel_booking
group by received_reserved_room;

-- Business Question 9:
-- Which assigned room type is most frequently given after a room change?

select
	assigned_room_type,
    count(assigned_room_type) as total_assigned
from hotel_booking
where assigned_room_type <> reserved_room_type
group by assigned_room_type
order by total_assigned desc;

-- Business Question 10:
-- Which hotel has the most bookings with a waiting list?

select
	hotel,
    count(*) as waiting_list
from hotel_booking
where days_in_waiting_list > 0
group by hotel
order by waiting_list desc;

-- Business Question 11:
-- Which hotel has the highest average waiting-list duration?

select 
	hotel,
    avg(days_in_waiting_list) as average_waiting_list
from hotel_booking
where days_in_waiting_list > 0
group by hotel
order by average_waiting_list desc;

-- Business Question 12:
-- Does time on the waiting list increase the likelihood of cancellation?

select
	days_in_waiting_list,
    count(*) as total_booking,
    sum(is_canceled) as cancelled,
    round(sum(is_canceled) / count(*) * 100,2) as cancellation_percentage
from hotel_booking
group by days_in_waiting_list
order by days_in_waiting_list asc;

-- Business Question 13:
-- What is the average daily room rate (ADR)?

select
	round(avg(adr),2) as average_daily_room
from hotel_booking;

-- Business Question 14:
-- Which hotel has the highest and lowest average ADR?

select
	hotel,
    round(avg(adr),2) as average_adr
from hotel_booking
group by hotel 
order by average_adr desc;

-- Business Question 15:
-- Which market segment has the highest average ADR?

select
	market_segment,
	round(avg(adr),2) as average_daily_room
from hotel_booking
group by market_segment
order by average_daily_room desc;

-- Business Question 16:
-- Which hotel has the highest number of bookings with special requests?

select
	hotel,
    count(*) as special_request_bookings
from hotel_booking
where total_of_special_requests > 0
group by hotel 
order by special_request_bookings desc;

-- Business Question 17:
-- Do customers with more special requests have a higher or lower cancellation rate?

select
	total_of_special_requests,
    count(*) as total_booking,
    sum(is_canceled) as cancellation,
    round(sum(is_canceled) / count(*) * 100,2) as cancellation_rate
from hotel_booking
group by total_of_special_requests
order by total_of_special_requests asc;

-- Business Question 18:
-- Which market segment has the highest cancellation rate?

select
	market_segment,
    count(*) as total_booking,
    sum(is_canceled) as cancelled,
    round(sum(is_canceled) / count(*) * 100,2) as cancellation_rate
from hotel_booking
group by market_segment
order by cancellation_rate desc;

-- Business Question 19:
-- Which customer type makes the most bookings?

select
	customer_type,
    count(*) as total_booking
from hotel_booking
group by customer_type
order by total_booking desc;

-- Business Question 20:
-- Which deposit type is most commonly used?

select
	deposit_type,
    count(*) as total_booking
from hotel_booking
group by deposit_type
order by total_booking desc;

-- Business Question 21:
-- Which market segment generates the highest number of bookings?

select
	market_segment,
    count(*) as total_booking
from hotel_booking
group by market_segment
order by total_booking desc;
