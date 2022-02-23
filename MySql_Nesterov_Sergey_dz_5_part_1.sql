/*
1) Пусть в таблице users поля created_at и updated_at оказались незаполненными.
Заполните их текущими датой и временем.
*/

UPDATE users SET updated_at = NOW(), created_at = NOW()
WHERE created_at IS NULL AND updated_at IS NULL;


/*
2) Таблица users была неудачно спроектирована.
Записи created_at и updated_at были заданы типом VARCHAR и в
них долгое время помещались значения в формате "20.10.2017 8:10".
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/

INSERT INTO users (firstname, lastname, email, phone, created_at, updated_at) VALUES
('nik3', 'raz3', 'ninin3@mail.ru', 03809809, '20.10.2017 8:10', '10.10.2010 18:40');

UPDATE users
SET
    created_at = STR_TO_DATE(created_at , '%d.%m.%Y %H:%i');

UPDATE users
SET
    updated_at = STR_TO_DATE(updated_at , '%d.%m.%Y %H:%i');


ALTER TABLE users
    CHANGE
        created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE users
    CHANGE
        updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE NOW();




/*
3) В таблице складских запасов storehouses_products в поле value могут встречаться
самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения
значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/



DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
               id SERIAL,
               product_id INT UNSIGNED,
               value INT UNSIGNED
);

INSERT INTO storehouses_products (product_id ,value) VALUES
(2,0),
(5, 2),
(11, 0),
(12, 10),
(16, 15),
(19, 16);


SELECT product_id, value
FROM storehouses_products
ORDER BY CASE WHEN value = 0 THEN 2147483647 ELSE value END;





/*
4) (по желанию) Из таблицы users необходимо извлечь пользователей,
родившихся в августе и мае. Месяцы заданы в виде списка английских
названий ('may', 'august')
*/

SELECT * FROM users WHERE birthday IN ('may', 'august') ORDER BY firstname ;


/*
5) (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи
в порядке, заданном в списке IN.
*/


SELECT product_id, value
FROM storehouses_products
WHERE product_id IN (5,1,19)
ORDER BY CASE WHEN product_id = 5 THEN 0
              WHEN product_id = 1 THEN 1
              WHEN product_id = 19 THEN 2
             END;