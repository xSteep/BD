-- 3.1 INSERT
-- a Без указания списка полей
-- student_id, student_name, student_age, group_id.
INSERT INTO Students VALUES (21, 'Федосеев Максим', 20, 3)

-- b С указанием списка полей
INSERT INTO Students (student_id, student_name, student_age, group_id)
VALUES (22, 'Никита Мирный', 19, 2)

-- c С чтением значения из другой таблицы
INSERT INTO Students (student_id, student_name, student_age, group_id)
SELECT 23, 'Леха Крутой', 21, group_id FROM Groups WHERE group_name = 'Группа А';




-- 3.2 DELETE
-- a Всех записей
DELETE FROM Students;

-- b По условию
DELETE FROM Students WHERE student_id = 23;




-- 3.3 UPDATE
-- a Всех записей
UPDATE Students SET student_age = 25;

-- b По условию обновляя один атрибут
-- установить для нормативов с id = 1 название "Running" в таблице Norms
UPDATE Norms SET norm_name = 'Running' WHERE norm_id = 1;

-- c По условию обновляя несколько атрибутов
-- установить для студентов с id = 2 и norm_id = 1 результатный балл = 9.0
UPDATE Results SET result_score = 9.0 WHERE student_id = 2 AND norm_id = 1;




-- 3.4 SELECT
-- a С набором извлекаемых атрибутов
-- извлечь имена и возраст студентов из таблицы Students
SELECT student_name, student_age FROM Students;

-- b Со всеми атрибутами
-- извлечь и вывести все данные из таблицы Norms
SELECT * FROM Norms;

-- c С условием по атрибуту
-- извлечь и вывести все данные где result_score = 10 из таблицы Results
SELECT * FROM Results WHERE result_score = 10;




-- 35 SELECT ORDER BY + TOP
-- a С сортировкой по возрастанию ASC + ограничение вывода количества записей
-- извлечь имена и возраст студентов из таблицы Students отсортированных по возрастанию возраста, и лимит первым пяти записям
SELECT student_name, student_age
FROM Students
ORDER BY student_age ASC
LIMIT 5;

-- b С сортировкой по убыванию DESC
-- извлечь все данные из Norms отсортированные по убыванию norm_id
SELECT *
FROM Norms
ORDER BY norm_id DESC;

-- c С сортировкой по двум атрибутам + ограничение вывода количества записей
-- извлечь student_name, student_age из Students отсортированных по возрастанию возраста и по убыванию имени и лимит 10
SELECT student_name, student_age
FROM Students
ORDER BY student_age ASC, student_name DESC
LIMIT 10;

-- d С сортировкой по первому атрибуту, из списка извлекаемых
-- извлечь и вывести имена студентов из таблицы Students отсортированных по имени.
SELECT student_name
FROM Students
ORDER BY 1;




-- 3.6
ALTER TABLE Results ADD COLUMN result_date TIMESTAMP;

UPDATE Results
SET result_date = DATE '2022-09-01' + (FLOOR(RANDOM() * (DATE '2023-05-30' - DATE '2022-09-01' + 1))::integer)


UPDATE Results
SET result_date = TIMESTAMP '2022-09-01' + RANDOM() * (TIMESTAMP '2023-05-30' - TIMESTAMP '2022-09-01');
SET result_date = DATE '2022-09-01' + RANDOM() * (DATE '2023-05-30' - DATE '2022-09-01');

-- a WHERE по дате
SELECT *
FROM Results
WHERE result_date = '2023-03-13';

-- b WHERE дата в диапазоне
SELECT *
FROM Results
WHERE result_date BETWEEN '2023-04-01' AND '2023-05-31';




-- 3.7
-- a: Посчитать количество записей в таблице
-- подсчитать общее количество записей в таблице Students
SELECT COUNT(*) AS total_records FROM Students;

-- b: Посчитать количество уникальных записей в таблице
-- подсчитать количество уникальных значений в столбце student_name таблицы Students
SELECT COUNT(DISTINCT student_name) AS unique_records FROM Students;

-- c: Вывести уникальные значения столбца
-- вывести все уникальные значения столбца sport_type из таблицы Sports
SELECT DISTINCT sport_type_id FROM Sporttypes;

-- d: Найти максимальное значение столбца.
SELECT MAX(result_score) AS max_score FROM Results;

-- e: Найти минимальное значение столбца
SELECT MIN(student_age) AS min_age FROM Students;

-- f: Написать запрос COUNT() + GROUP BY
-- подсчитать количество студентов в каждой группе из таблицы Students
SELECT group_id, COUNT(*) AS total_students
FROM Students
GROUP BY group_id;




-- 3.8 SELECT GROUP BY + HAVING

-- 1: Подсчитать количество студентов в каждой группе, где количество студентов меньше 8
-- Запрос позволяет узнать группы в которых мало участников и в последствии приглосить туда
SELECT group_id, COUNT(*) AS total_students
FROM Students
GROUP BY group_id
HAVING COUNT(*) < 8;

-- 2: Подсчитать студентов у которых сумарный балл больше 20
-- запрос позволяет найти самых результативных студентов
SELECT student_id, SUM(result_score) AS total_score
FROM Results
GROUP BY student_id
HAVING SUM(result_score) > 20;

-- 3: Подсчитать количество студентов в каждом виде спорта, где количество студентов больше 10
-- Запрос позволяет узнать популярные виды спорта у студентов.
SELECT norm_id, AVG(result_score) AS average_score
FROM Results
GROUP BY norm_id
HAVING AVG(result_score) > 10;





-- 3.9
-- a: LEFT JOIN двух таблиц и WHERE по одному из атрибутов
-- Извлечь все записи из таблиц Students и Results где общий атрибут student_id, и значение столбца group_id равно 1.
SELECT *
FROM Students
LEFT JOIN Results ON Students.student_id = Results.student_id
WHERE Students.group_id = 1;

-- b: RIGHT JOIN. Получить такую же выборку, как и в 3.9 a
SELECT *
FROM Results
RIGHT JOIN Students ON Students.student_id = Results.student_id
WHERE Students.group_id = 1;

-- c: LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT G.group_name, ST.sport_name, S.student_name
FROM Groups AS G
JOIN Students AS S ON G.group_id = S.group_id
JOIN SportTypes AS ST ON G.group_id = ST.sport_type_id
WHERE G.group_name = 'Группа А'
  AND ST.sport_name = 'Плаванье';


-- d: INNER JOIN двух таблиц
-- извлечь все записи из таблиц Students и Groups на основе общего атрибута group_id
SELECT *
FROM Students
INNER JOIN Groups ON Students.group_id = Groups.group_id;




-- 3.10
-- a: Написать запрос с условием WHERE IN (подзапрос)
-- извлечь все записи из таблицы Students, где значение group_id присутствует в подзапросе для выбора определенных групп
SELECT *
FROM Students
WHERE group_id IN (SELECT group_id FROM Groups WHERE group_name IN ('Группа А', 'Группа Б'));

-- b: Написать запрос SELECT atr1, atr2, (подзапрос) FROM ... 
-- Извлечь значения столбцов student_id, student_name и результат подзапроса который вычисляет общее количество записей в таблице Results
SELECT student_id, student_name, (SELECT COUNT(*) FROM Results) AS total_results
FROM Students;

-- c: Написать запрос вида SELECT * FROM (подзапрос)
-- извлечь все записи из подзапроса, который выбирает студентов из таблицы tudents с результатом выше среднего.
SELECT * FROM (SELECT * FROM Results) AS subquery;

-- d: Написать запрос вида SELECT * FROM table JOIN (подзапрос) ON …
-- извлечь все записи из таблицы Students, объединенные с результатами из подзапроса на основе общего атрибута student_id.
SELECT *
FROM Students
JOIN (SELECT student_id, result_score FROM Results) AS subquery
ON Students.student_id = subquery.student_id;