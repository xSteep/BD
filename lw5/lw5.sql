-- 1. Добавить внешние ключи.
ALTER TABLE room
ADD CONSTRAINT fk_room_hotel
FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel);

ALTER TABLE room
ADD CONSTRAINT fk_room_room_category
FOREIGN KEY (id_room_category) REFERENCES room_category (id_room_category);

ALTER TABLE room_in_booking
ADD CONSTRAINT fk_room_in_booking_booking
FOREIGN KEY (id_booking) REFERENCES booking (id_booking);

ALTER TABLE room_in_booking
ADD CONSTRAINT fk_room_in_booking_room
FOREIGN KEY (id_room) REFERENCES room (id_room);

ALTER TABLE booking
ADD CONSTRAINT fk_booking_client
FOREIGN KEY (id_client) REFERENCES client (id_client);


-- 2. Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах категории “Люкс” на 1 апреля 2019г.
SELECT c.name, c.phone
FROM client c
INNER JOIN booking b ON c.id_client = b.id_client
INNER JOIN room_in_booking rib ON b.id_booking = rib.id_booking
INNER JOIN room r ON rib.id_room = r.id_room
INNER JOIN room_category rc ON r.id_room_category = rc.id_room_category
INNER JOIN hotel h ON r.id_hotel = h.id_hotel
WHERE h.name = 'Космос'
  AND rc.name = 'Люкс'
  AND rib.checkin_date <= '2019-04-01'
  AND rib.checkout_date > '2019-04-01';


-- 3. Дать список свободных номеров всех гостиниц на 22 апреля
-- fix
-- обьяснить
SELECT r.id_room, h.name AS hotel_name
FROM room r
INNER JOIN hotel h ON r.id_hotel = h.id_hotel
LEFT JOIN room_in_booking rib ON r.id_room = rib.id_room
LEFT JOIN booking b ON rib.id_booking = b.id_booking
WHERE (rib.checkin_date > '2023-04-22' OR rib.checkout_date < '2023-04-22') OR rib.id_room IS NULL;


SELECT r.id_room, h.name AS hotel_name
FROM room r
INNER JOIN hotel h ON r.id_hotel = h.id_hotel
LEFT JOIN room_in_booking rib ON r.id_room = rib.id_room
WHERE r.id_room NOT IN (
  SELECT rib.id_room
  FROM room_in_booking rib
  WHERE rib.checkin_date <= '2023-04-22' AND rib.checkout_date >= '2023-04-23'
)


-- 4. Дать количество проживающих в гостинице “Космос” на 23 марта по каждой категории номеров
--  равенство поправить
SELECT rc.name AS category, COUNT(b.id_client) FROM hotel h
INNER JOIN room r ON r.id_hotel = h.id_hotel
INNER JOIN room_category rc ON rc.id_room_category = r.id_room_category
INNER JOIN room_in_booking rib ON rib.id_room = r.id_room
INNER JOIN booking b ON rib.id_booking = b.id_booking
WHERE h.name = 'Космос' AND '23-03-2019' BETWEEN rib.checkin_date AND rib.checkout_date
GROUP BY rc.name;

SELECT rc.name AS category, COUNT(b.id_client) FROM hotel h
INNER JOIN room r ON r.id_hotel = h.id_hotel
INNER JOIN room_category rc ON rc.id_room_category = r.id_room_category
INNER JOIN room_in_booking rib ON rib.id_room = r.id_room
INNER JOIN booking b ON rib.id_booking = b.id_booking
WHERE h.name = 'Космос' 
  AND rib.checkin_date <= '2019-03-23'
  AND rib.checkout_date >= '2019-03-23'
GROUP BY rc.name;


-- 5. Дать список последних проживавших клиентов по всем комнатам гостиницы “Космос”, выехавшим в апреле с указанием даты выезда. 
-- список последних проживающих
-- не работает
SELECT c.name AS client_name, rib.checkout_date
FROM client c
INNER JOIN booking b ON c.id_client = b.id_client
INNER JOIN room_in_booking rib ON b.id_booking = rib.id_booking
INNER JOIN room r ON rib.id_room = r.id_room
INNER JOIN hotel h ON r.id_hotel = h.id_hotel
WHERE h.name = 'Космос'
  AND rib.checkout_date >= '2019-04-01'
  AND rib.checkout_date < '2019-05-01'
ORDER BY rib.checkout_date ASC;


SELECT c.name AS client_name, rib.checkout_date
FROM client c
INNER JOIN booking b ON c.id_client = b.id_client
INNER JOIN room_in_booking rib ON b.id_booking = rib.id_booking
INNER JOIN room r ON rib.id_room = r.id_room
INNER JOIN hotel h ON r.id_hotel = h.id_hotel
WHERE h.name = 'Космос'
  AND rib.checkout_date >= '2019-04-01'
  AND rib.checkout_date < '2019-05-01'
  AND rib.checkout_date = (
    SELECT MAX(checkout_date)
    FROM room_in_booking
    WHERE id_room = rib.id_room
  )
ORDER BY rib.checkout_date ASC;

-- 6. Продлить на 2 дня дату проживания в гостинице “Космос” всем клиентам комнат категории “Бизнес”, которые заселились 10 мая.
UPDATE public.room_in_booking
SET checkout_date = room_in_booking.checkout_date + interval '1 day' * 2
WHERE room_in_booking.id_room_in_booking IN (
	SELECT rib.id_room_in_booking FROM public.hotel h
	INNER JOIN public.room r USING(id_hotel)
	INNER JOIN public.room_in_booking rib USING(id_room)
	INNER JOIN public.room_category rc USING(id_room_category)
	WHERE h.name = 'Космос' 
      AND rib.checkin_date = '10-05-2019' 
      AND rc.name = 'Бизнес'
);

-- это чтоб посмотреть

SELECT c.name AS client_name, rib.checkout_date
FROM client c
INNER JOIN booking b ON c.id_client = b.id_client
INNER JOIN room_in_booking rib ON b.id_booking = rib.id_booking
INNER JOIN room r ON rib.id_room = r.id_room
INNER JOIN room_category rc ON r.id_room_category = rc.id_room_category
INNER JOIN hotel h ON r.id_hotel = h.id_hotel
WHERE h.name = 'Космос'
  AND rib.checkin_date = '2019-05-10'
  AND rc.name = 'Бизнес';


-- 7. Найти все "пересекающиеся" варианты проживания. Правильное состояние: не
-- может быть забронирован один номер на одну дату несколько раз, т.к. нельзя
-- заселиться нескольким клиентам в один номер. Записи в таблице
-- room_in_booking с id_room_in_booking = 5 и 2154 являются примером
-- неправильного состояния, которые необходимо найти. Результирующий кортеж
-- выборки должен содержать информацию о двух конфликтующих номерах.

-- рассказать как работает
SELECT rib1.id_room_in_booking, rib1.id_room, rib1.checkin_date, rib1.checkout_date,
       rib2.id_room_in_booking, rib2.id_room, rib2.checkin_date, rib2.checkout_date
FROM room_in_booking rib1
INNER JOIN room_in_booking rib2 ON rib1.id_room = rib2.id_room -- оббьединяется сама с собой по условию
WHERE rib1.id_room_in_booking <> rib2.id_room_in_booking -- что записи имеют разные идентификаторы бронирования, чтобы не сравнивалась сама с собой
  AND rib1.checkin_date <= rib2.checkout_date -- 1 дата заезда меньше или равна 2 дате выезда
  AND rib2.checkin_date <= rib1.checkout_date; -- 2 даза заезда меньш или равна 1 дате выезда







-- 8. Создать бронирование в транзакции.
SELECT *
FROM booking
WHERE id_booking = 1;




--9. Добавить необходимые индексы для всех таблиц.
CREATE INDEX idx_hotel_name ON hotel (name);

CREATE INDEX idx_room_category_name ON room_category (name);

CREATE INDEX idx_room_hotel_id ON room (id_hotel);
CREATE INDEX idx_room_category_id ON room (id_room_category);
CREATE INDEX idx_room_number ON room (number);
CREATE INDEX idx_room_price ON room (price);

CREATE INDEX idx_client_name ON client (name);
CREATE INDEX idx_client_phone ON client (phone);

CREATE INDEX idx_booking_client_id ON booking (id_client);
CREATE INDEX idx_booking_booking_date ON booking (booking_date);

CREATE INDEX idx_room_in_booking_booking_id ON room_in_booking (id_booking);
CREATE INDEX idx_room_in_booking_room_id ON room_in_booking (id_room);
CREATE INDEX idx_room_in_booking_checkin_date ON room_in_booking (checkin_date);
CREATE INDEX idx_room_in_booking_checkout_date ON room_in_booking (checkout_date);




SELECT * FROM pg_indexes WHERE tablename = 'hotel';



DROP INDEX IF EXISTS idx_hotel_name;

DROP INDEX IF EXISTS idx_room_category_name;

DROP INDEX IF EXISTS idx_room_hotel_id;
DROP INDEX IF EXISTS idx_room_category_id;
DROP INDEX IF EXISTS idx_room_number;
DROP INDEX IF EXISTS idx_room_price;

DROP INDEX IF EXISTS idx_client_name;
DROP INDEX IF EXISTS idx_client_phone;

DROP INDEX IF EXISTS idx_booking_client_id;
DROP INDEX IF EXISTS idx_booking_booking_date;

DROP INDEX IF EXISTS idx_room_in_booking_booking_id;
DROP INDEX IF EXISTS idx_room_in_booking_room_id;
DROP INDEX IF EXISTS idx_room_in_booking_checkin_date;
DROP INDEX IF EXISTS idx_room_in_booking_checkout_date;


