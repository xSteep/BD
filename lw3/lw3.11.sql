CREATE TABLE artists (
  artist_id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birth_date DATE,
  nationality VARCHAR(255),
  gender VARCHAR(10)
);

CREATE TABLE studios (
  studio_id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  location VARCHAR(255),
  established_year INT
);

CREATE TABLE films (
  film_id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  release_date DATE,
  genre VARCHAR(255),
  director VARCHAR(255),
  studio_id INT REFERENCES studios(studio_id)
);

CREATE TABLE roles (
  role_id SERIAL PRIMARY KEY,
  film_id INT REFERENCES films(film_id),
  artist_id INT REFERENCES artists(artist_id),
  character_name VARCHAR(255),
  role_description TEXT
);

CREATE TABLE award_for_the_role (
  award_for_the_role_id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description TEXT,
  year INT,
  role_id INT REFERENCES roles(role_id)
);

CREATE TABLE award_for_the_film (
  award_for_the_film_id SERIAL PRIMARY KEY,
  film_id INT REFERENCES films(film_id),
  name VARCHAR(255),
  description TEXT,
  year INT
);

CREATE TABLE award (
  award_id SERIAL PRIMARY KEY,
  category VARCHAR(255),
  year INT,
  award_for_the_film_id INT REFERENCES award_for_the_film(award_for_the_film_id),
  award_for_the_role_id INT REFERENCES award_for_the_role(award_for_the_role_id)
);