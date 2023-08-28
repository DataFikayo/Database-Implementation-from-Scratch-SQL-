/* Sample queries for FastPark database*/

/* The first and last name of all drivers managed by a specific customer service representative*/
SELECT d.first_name, d.last_name 
FROM driver as d
JOIN customer_service as cs
ON d.customer_service_id=cs.customer_service_id
WHERE cs.customer_service_id = 1;

/*The first and last name of all space owners who own more than 5 spaces*/
SELECT `first_name`, `last_name` FROM `FastPark`.`space_owner`
WHERE `no_of_space_owned` > 5;

/*Select the vehicle type and hours used for all reservations with a date after January 1, 2023*/
SELECT `vehicle_type`, `hours_used` FROM `FastPark`.`reservation`
JOIN `FastPark`.`vehicle_type` ON `FastPark`.`reservation`.`Vehicle_Type_id` = `FastPark`.`vehicle_type`.`vehicle_type_id`
WHERE `date` > '2022-06-01';

/* View available parking space*/
SELECT ps.parking_space_id, pa.house_number, pa.street_name, pa.post_code, ps.parking_fee
FROM FastPark.parking_space ps
INNER JOIN FastPark.parking_address pa ON ps.parking_space_id = pa.parking_space_id
WHERE ps.parking_space_id NOT IN (
    SELECT parking_space_id FROM FastPark.reservation
    WHERE date = CURDATE() AND time_out IS NULL
);

/* Show reservation history for a driver*/
SELECT r.reservation_id, r.date, r.hours_used, r.time_in, r.time_out, vt.vehicle_type, pa.house_number, pa.street_name, pa.post_code, ps.parking_fee
FROM FastPark.reservation r
INNER JOIN FastPark.parking_space ps ON r.parking_space_id = ps.parking_space_id
INNER JOIN FastPark.parking_address pa ON ps.parking_space_id = pa.parking_space_id
INNER JOIN FastPark.driver d ON r.driver_id = d.driver_id
INNER JOIN FastPark.vehicle_type vt ON r.Vehicle_Type_id = vt.vehicle_type_id
WHERE d.first_name = 'John' AND d.last_name = 'Doe';

/*Show space owner detailsand their parking space*/
SELECT so.owner_id, so.first_name, so.last_name, so.no_of_space_owned, cs.first_name AS manager_first_name, cs.last_name AS manager_last_name, ps.parking_space_id, pa.house_number, pa.street_name, pa.post_code, ps.parking_fee
FROM FastPark.space_owner so
INNER JOIN FastPark.customer_service cs ON so.managed_by = cs.customer_service_id
INNER JOIN FastPark.parking_space ps ON so.owner_id = ps.owner_id
INNER JOIN FastPark.parking_address pa ON ps.parking_space_id = pa.parking_space_id;

/*Show vehicle_type and parking_fee columns from the vehicle_type and parking_space tables, 
respectively, where the parking_fee is greater than 10*/
SELECT `vehicle_type`.`vehicle_type`, `parking_space`.`parking_fee` FROM `FastPark`.`vehicle_type`
JOIN `FastPark`.`reservation` ON `vehicle_type`.`vehicle_type_id` = `reservation`.`Vehicle_Type_id`
JOIN `FastPark`.`parking_space` ON `reservation`.`parking_space_id` = `parking_space`.`parking_space_id`
WHERE `parking_space`.`parking_fee` > 10;

/*All parking spaces that are charging and have a fee greater than $10*/
SELECT *
FROM FastPark.parking_space
WHERE charging = 'True' AND parking_fee > 10;

/*Query space owners managed by a specific customer service representative*/
SELECT *
FROM FastPark.space_owner
WHERE managed_by = (
    SELECT customer_service_id
    FROM FastPark.customer_service
    WHERE first_name = 'Tricia'
);

/*Find the minimum and maximum parking fees of all parking spaces*/
SELECT MIN(parking_fee) AS min_parking_fee, MAX(parking_fee) AS max_parking_fee FROM parking_space;