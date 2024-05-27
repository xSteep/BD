CREATE TABLE hotel
(
	id_hotel SERIAL PRIMARY KEY,
	name VARCHAR(70),
	stars SMALLINT
);

CREATE TABLE room_category
(
	id_room_category SERIAL PRIMARY KEY,
	name VARCHAR(40),
	square SMALLINT
);

CREATE TABLE room
(
	id_room SERIAL PRIMARY KEY,
	id_hotel INT REFERENCES hotel(id_hotel), 
	id_room_category INT REFERENCES room_category(id_room_category),
	number SMALLINT,
	price MONEY
);

CREATE TABLE client
(
	id_client SERIAL PRIMARY KEY,
	name VARCHAR(50), 
	phone VARCHAR(20)
);

CREATE TABLE booking
(
	id_booking SERIAL PRIMARY KEY,
	id_client INT REFERENCES client(id_client),
	booking_date DATE
);

CREATE TABLE room_in_booking
(
	id_room_in_booking SERIAL PRIMARY KEY,
	id_booking INT REFERENCES booking(id_booking),
	id_room INT REFERENCES room(id_room),
	checkin_date DATE,
	checkout_date DATE
)


COPY hotel FROM 'D:\Works\DATABASE\lw5\hotel.csv' DELIMITER ';' CSV HEADER;
COPY room_category FROM 'D:\Works\DATABASE\lw5\room_category.csv' DELIMITER ';' CSV HEADER;
COPY room FROM 'D:\Works\DATABASE\lw5\room.csv' DELIMITER ';' CSV HEADER;
COPY client FROM 'D:\Works\DATABASE\lw5\client.csv' DELIMITER ';' CSV HEADER;
COPY booking FROM 'D:\Works\DATABASE\lw5\booking.csv' DELIMITER ';' CSV HEADER;
COPY room_in_booking FROM 'D:\Works\DATABASE\lw5\room_in_booking.csv' DELIMITER ';' CSV HEADER;