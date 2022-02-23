/*1. Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека,
который больше всех общался с нашим пользователем.*/

USE vk;

SELECT
    COUNT(*) as cnt,
    from_user_id,
    to_user_id as 'Кому',
    (SELECT firstname from users WHERE id = from_user_id) as 'ownName',
    (SELECT lastname from users WHERE id = from_user_id) as 'ownLastName'
FROM messages
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY COUNT(*) DESC
LIMIT 1;

/*2. Подсчитать общее количество лайков,
которые получили пользователи младше 11 лет.*/

SELECT count(*) as 'кол-во'
from likes 
WHERE user_id IN (SELECT user_id 
                  from profiles
                  WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 11)
                  
                  
/* 3. Определить кто больше поставил лайков (всего):
 мужчины или женщины.*/
USE vk;
-- ПЕРВЫЙ вариант решения!!!
SELECT 
	gender,
	count(*)
FROM (
	SELECT 
		user_id AS USER,
		(
			SELECT gender 
			FROM vk.profiles
			WHERE user_id = user
		) AS gender
	FROM likes
) AS dummy
GROUP BY gender;


-- ВТОРОЙ вариант решщения!!!
/*SELECT 
  (SELECT gender from profiles WHERE profiles.user_id = likes.user_id) AS gender,
  COUNT(*) AS 'Number of likes'
    FROM likes 
    GROUP BY gender
    ORDER BY COUNT(*) DESC LIMIT 1;  
    */


-- ТРЕТИЙ вариант решения!!!(но тут DBeaver выдет синтаксическую ошибку)
/*select
    count(*) as 'кол-во',
    case(sex)
        when 'f' THEN 'женский'
        when 'm' THEN 'мужской'
        end as пол
from (
         SELECT
             user_id as crt,
             (SELECT gender from profiles WHERE user_id = crt) as sex
         from likes
     ) as prepare_table
group by sex
ORDER by COUNT(*) desc
limit 1;
*/






