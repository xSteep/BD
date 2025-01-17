INSERT INTO Groups (group_id, group_name, group_location, group_instructor)
VALUES
  (1, 'Группа А', 'Зал А', 'Иванов Иван'),
  (2, 'Группа Б', 'Зал Б', 'Петров Петр'),
  (3, 'Группа В', 'Зал В', 'Сидоров Сидор');

INSERT INTO SportTypes (sport_type_id, sport_name, sport_equipment, sport_rules)
VALUES
  (1, 'Плаванье', 'Плавательный бассейн, купальник', 'Правила плавания'),
  (2, 'Волейбол', 'Волейбольный мяч, сетка', 'Правила волейбола'),
  (3, 'Баскетбол', 'Баскетбольный мяч, корзина', 'Правила баскетбола'),
  (4, 'Шахматы', 'Шахматная доска, фигуры', 'Правила шахмат'),
  (5, 'Теннис', 'Теннисный мяч, ракетка', 'Правила тенниса');

INSERT INTO Students (student_id, student_name, student_age, group_id)
VALUES
  (1, 'Иванов Иван', 20, 1),
  (2, 'Петров Петр', 19, 2),
  (3, 'Сидоров Сидор', 21, 3),
  (4, 'Ковалева Елена', 18, 2),
  (5, 'Смирнова Анна', 20, 2),
  (6, 'Николаев Алексей', 19, 3),
  (7, 'Белова Ольга', 22, 1),
  (8, 'Павлов Игорь', 20, 2),
  (9, 'Козлова Мария', 21, 2),
  (10, 'Лебедева Екатерина', 18, 2),
  (11, 'Антонов Антон', 20, 1),
  (12, 'Григорьев Сергей', 19, 3),
  (13, 'Тимофеева Наталья', 21, 3),
  (14, 'Федоров Дмитрий', 20, 2),
  (15, 'Савельев Александр', 22, 1),
  (16, 'Кузнецова Анна', 20, 2),
  (17, 'Марков Владимир', 19, 3),
  (18, 'Васильев Артем', 21, 2),
  (19, 'Исаева Оксана', 20, 2),
  (20, 'Ершов Сергей', 22, 3);

INSERT INTO Norms (norm_id, sport_type_id, norm_name, norm_description)
VALUES
  (1, 1, 'Заплыв 50 метров', 'Проплыть дистанцию в 50 метров'),
  (2, 2, 'Бег 100 метров', 'Пробежать дистанцию в 100 метров'),
  (3, 3, 'Бег 3 километра', 'Пробежать дистанцию в 3 километра'),
  (4, 5, 'Подтягивания', 'Выполнить заданное количество подтягиваний'),
  (5, 4, 'Отжимания', 'Выполнить заданное количество отжиманий');

INSERT INTO Results (result_id, student_id, norm_id, result_score)
VALUES
  (1, 1, 3, 10),
  (2, 1, 4, 12),
  (3, 2, 1, 9),
  (4, 2, 2, 11),
  (5, 3, 3, 11),
  (6, 3, 2, 13),
  (7, 4, 5, 8),
  (8, 4, 2, 10),
  (9, 5, 2, 9),
  (10, 5, 2, 11),
  (11, 6, 1, 12),
  (12, 6, 3, 14),
  (13, 7, 1, 11),
  (14, 7, 4, 13),
  (15, 8, 1, 10),
  (16, 8, 5, 12),
  (17, 9, 1, 11),
  (18, 9, 2, 13),
  (19, 10, 5, 9),
  (20, 10, 2, 11),
  (21, 11, 3, 10),
  (22, 11, 4, 12),
  (23, 12, 1, 9),
  (24, 12, 2, 11),
  (25, 13, 3, 11),
  (26, 13, 2, 13),
  (27, 14, 5, 8),
  (28, 14, 2, 10),
  (29, 15, 2, 9),
  (30, 15, 2, 11),
  (31, 16, 1, 12),
  (32, 16, 3, 14),
  (33, 17, 1, 11),
  (34, 17, 4, 13),
  (35, 18, 1, 10),
  (36, 18, 5, 12),
  (37, 19, 1, 11),
  (38, 19, 2, 13),
  (39, 20, 5, 9),
  (40, 20, 2, 11);