/*
1)В базе данных shop и sample присутствуют одни и те же таблицы,
учебной базы данных. Переместите запись id = 1 из таблицы shop.users
в таблицу sample.users. Используйте транзакции.
*/

START TRANSACTION;
INSERT INTO shop
SELECT * FROM les9.example where id = 1;

COMMIT;


/*
2)Создайте представление, которое выводит название name товарной
позиции из таблицы products и соответствующее название
каталога name из таблицы catalogs.
*/

CREATE OR REPLACE VIEW products_catalogs AS
SELECT
    p.name AS product,
    c.name AS catalog
FROM
    products AS p
        JOIN
    catalogs AS c
    ON
            p.catalog_id = c.id;







/*
4)(по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос,
который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/

SELECT * FROM posts;

PREPARE del FROM "delete from posts order by created_at limit ?";
set @delrow =(select COUNT(*) - 5 from posts);
execute del using @delrow;

SELECT @delrow;

DROP PREPARE del;