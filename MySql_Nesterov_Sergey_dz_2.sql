/* 1) Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, 
задав в нем логин и пароль, который указывался при установке.*/
[mysql] 
user=root 
password=root


/* 2) Создайте базу данных example, разместите в ней таблицу users, 
состоящую из двух столбцов, числового id и строкового name*/

--создаем ДБ

CREATE DATABASE example;
USE example;
--создаем таблици

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

/*пришлось пораскинуть мозгами , посмотрел первый урок еще раз и понял что была ошибка в синтаксисе,
тоесть я не исправил ошибку о которой вы говорили , но потом пересмотрев урок я исправил ошибку и все пошло как надо.*/

/* 3) Создайте дамп базы данных example из предыдущего задания,
разверните содержимое дампа в новую базу данных sample.*/

-- Создаём дамп БД example
mysqldump example > example.sql

-- Создаём БД sample
mysql
CREATE DATABASE sample

-- Загружаем дамп в БД sample
mysql sample < example.sql

/* 4) (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump.
Создайте дамп единственной таблицы help_keyword базы данных mysql.
Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.*/


mysqldump --where="true limit 100" mysql help_keyword > help_keyword_dump.sql