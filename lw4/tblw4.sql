CREATE TABLE Groups (
  group_id INT PRIMARY KEY,
  group_name VARCHAR(255),
  group_location VARCHAR(255),
  group_instructor VARCHAR(255)
);

CREATE TABLE SportTypes (
  sport_type_id INT PRIMARY KEY,
  sport_name VARCHAR(255),
  sport_equipment VARCHAR(255),
  sport_rules TEXT
);

CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(255),
  student_age INT,
  group_id INT,
  FOREIGN KEY (group_id) REFERENCES Groups(group_id)
);

CREATE TABLE Norms (
  norm_id INT PRIMARY KEY,
  sport_type_id INT,
  norm_name VARCHAR(255),
  norm_description TEXT,
  FOREIGN KEY (sport_type_id) REFERENCES SportTypes(sport_type_id)
);

CREATE TABLE Results (
  result_id INT PRIMARY KEY,
  student_id INT,
  norm_id INT,
  result_score FLOAT,
  FOREIGN KEY (student_id) REFERENCES Students(student_id),
  FOREIGN KEY (norm_id) REFERENCES Norms(norm_id)
);

