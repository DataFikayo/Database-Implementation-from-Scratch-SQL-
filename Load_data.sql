
use fastpark;
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_service.csv" into table customer_service
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Vehicle_type.csv" into table vehicle_type
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Space_owner.csv" into table space_owner
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Drivers.csv" into table driver
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Parking_space.csv" into table parking_space
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Parking_address.csv" into table parking_address
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Reservation.csv" into table reservation
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Payment.csv" into table payment
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Refund.csv" into table Refund
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
