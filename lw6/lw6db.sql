CREATE TABLE company (
  id_company SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  established INTEGER NOT NULL
);

CREATE TABLE dealer (
  id_dealer SERIAL PRIMARY KEY,
  id_company INTEGER REFERENCES company (id_company),
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL
);

CREATE TABLE medicine (
  id_medicine SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  cure_duration INTEGER NOT NULL
);

CREATE TABLE pharmacy (
  id_pharmacy SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  rating INTEGER NOT NULL
);

CREATE TABLE production (
  id_production SERIAL PRIMARY KEY,
  id_company INTEGER REFERENCES company (id_company),
  id_medicine INTEGER REFERENCES medicine (id_medicine),
  price money NOT NULL,
  rating INTEGER NOT NULL
);

CREATE TABLE "order" (
  id_order SERIAL PRIMARY KEY,
  id_production INTEGER REFERENCES production (id_production),
  id_dealer INTEGER REFERENCES dealer (id_dealer),
  id_pharmacy INTEGER REFERENCES pharmacy (id_pharmacy),
  date DATE NOT NULL,
  quantity INTEGER NOT NULL
);





COPY company FROM 'D:\Works\DATABASE\lw6\company.csv' DELIMITER ';' CSV HEADER;
COPY dealer FROM 'D:\Works\DATABASE\lw6\dealer.csv' DELIMITER ';' CSV HEADER;
COPY medicine FROM 'D:\Works\DATABASE\lw6\medicine.csv' DELIMITER ';' CSV HEADER;
COPY "order" FROM 'D:\Works\DATABASE\lw6\order.csv' DELIMITER ';' CSV HEADER;
COPY pharmacy FROM 'D:\Works\DATABASE\lw6\pharmacy.csv' DELIMITER ';' CSV HEADER;
COPY production FROM 'D:\Works\DATABASE\lw6\production.csv' DELIMITER ';' CSV HEADER;


