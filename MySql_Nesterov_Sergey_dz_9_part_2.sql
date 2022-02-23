/*
 1)Создайте двух пользователей которые имеют доступ к базе данных shop.
 Первому пользователю shop_read должны быть доступны только запросы на
 чтение данных, второму пользователю shop — любые операции
 в пределах базы данных shop.
 */

CREATE USER first_read IDENTIFIED WITH sha256_password BY 'pass'​;
CREATE USER scn_all IDENTIFIED WITH sha256_password BY 'pass'​;


GRANT SELECT ON shop.* TO 'first_read'​@​'localhost' IDENTIFIED ​​WITH​ sha256_password ​BY​​ 'pass';

GRANT ALL ON shop.* TO scn_all;
--  можно добавить права это пользователю назначение прав себе и другим пользователям
GRANT GRANT OPTION ALL shop.* TO scn_all;


/*
2) (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
содержащие первичный ключ, имя пользователя и его пароль. Создайте представление
username таблицы accounts, предоставляющий доступ к столбца id и name.
Создайте пользователя user_read, который бы не имел доступа к таблице accounts,
однако, мог бы извлекать записи из представления username.
*/
use les9;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(45),
                       password VARCHAR(45)
);

INSERT INTO accounts (name, password) VALUES
                            ('nik', 'pass'),
                            ('wowa', 'pass'),
                            ('alexander', 'pass');

CREATE OR REPLACE VIEW username(user_id, user_name) AS
SELECT id, name FROM accounts;


CREATE USER user_read IDENTIFIED WITH sha256_password BY 'pass'​;
GRANT SELECT ON les9.username TO user_read;