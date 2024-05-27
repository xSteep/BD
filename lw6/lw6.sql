-- 1. Добавить внешние ключи.
ALTER TABLE dealer
ADD CONSTRAINT fk_dealer_company
FOREIGN KEY (id_company) REFERENCES company (id_company);

ALTER TABLE production
ADD CONSTRAINT fk_production_company
FOREIGN KEY (id_company) REFERENCES company (id_company);

ALTER TABLE production
ADD CONSTRAINT fk_production_medicine
FOREIGN KEY (id_medicine) REFERENCES medicine (id_medicine);

ALTER TABLE "order"
ADD CONSTRAINT fk_order_production
FOREIGN KEY (id_production) REFERENCES production (id_production);

ALTER TABLE "order"
ADD CONSTRAINT fk_order_dealer
FOREIGN KEY (id_dealer) REFERENCES dealer (id_dealer);

ALTER TABLE "order"
ADD CONSTRAINT fk_order_pharmacy
FOREIGN KEY (id_pharmacy) REFERENCES pharmacy (id_pharmacy);


-- 2. Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов.
SELECT p.name AS pharmacy_name, o.date, o.quantity
FROM "order" o
JOIN production pr ON o.id_production = pr.id_production
JOIN pharmacy p ON o.id_pharmacy = p.id_pharmacy
JOIN medicine m ON pr.id_medicine = m.id_medicine
JOIN company c ON pr.id_company = c.id_company
WHERE m.name = 'Кордеон' AND c.name = 'Аргус';


-- 3. Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 25 января.
-- поправить
SELECT m.name AS medicine_name
FROM medicine m
JOIN production pr ON m.id_medicine = pr.id_medicine
JOIN company c ON pr.id_company = c.id_company
LEFT JOIN "order" o ON pr.id_production = o.id_production
WHERE c.name = 'Фарма' AND (o.date IS NULL OR o.date > '2019-01-25');


SELECT m.name AS medicine_name
FROM medicine m
JOIN production pr ON m.id_medicine = pr.id_medicine
JOIN company c ON pr.id_company = c.id_company
LEFT JOIN "order" o ON pr.id_production = o.id_production AND o.date <= '2019-01-25'
WHERE c.name = 'Фарма' AND o.id_order IS NULL;


-- 4. Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов.
SELECT count(*), c.name AS company_name, MIN(pr.rating) AS min_rating, MAX(pr.rating) AS max_rating
FROM company c
JOIN production pr ON c.id_company = pr.id_company
JOIN "order" o ON pr.id_production = o.id_production
GROUP BY c.name
HAVING COUNT(o.id_order) >= 120;


-- 5. Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”. Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT d.name AS dealer_name, COALESCE(p.name, 'NULL') AS pharmacy_name
FROM dealer d
JOIN company c ON d.id_company = c.id_company
LEFT JOIN "order" o ON d.id_dealer = o.id_dealer
LEFT JOIN pharmacy p ON o.id_pharmacy = p.id_pharmacy
WHERE c.name = 'AstraZeneca';


-- 6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.
UPDATE production
SET price = price * 0.8
WHERE price > '3000'::money
  AND id_medicine IN (
    SELECT id_medicine
    FROM medicine
    WHERE cure_duration <= 7
  );


-- 7. Добавить необходимые индексы.
CREATE INDEX idx_production_company ON production (id_company);

CREATE INDEX idx_production_medicine ON production (id_medicine);

CREATE INDEX idx_order_production ON "order" (id_production);

CREATE INDEX idx_order_dealer ON "order" (id_dealer);

CREATE INDEX idx_order_pharmacy ON "order" (id_pharmacy);

CREATE INDEX idx_medicine_name ON medicine (name);

CREATE INDEX idx_company_name ON company (name);
