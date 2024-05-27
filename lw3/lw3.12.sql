CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    creation_date DATE NOT NULL
);

CREATE TABLE Publishers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL
);

CREATE TABLE Authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    country VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INT REFERENCES Authors(id),
	category_id INT REFERENCES Categories(id)
);

CREATE TABLE printing (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOt NULL,
	number_of_pages VARCHAR(100) NOT NULL,
	book_id INT REFERENCES Books(id),
    total_amount DECIMAL(10, 2) NOT NULL,
	publisher_id INT REFERENCES Publishers(id)
);

CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    order_date DATE NOT NULL,
	printing_id INT REFERENCES printing(id)
);

