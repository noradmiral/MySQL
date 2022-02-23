/*1. Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека,
который больше всех общался с нашим пользователем.*/

USE vk;

SELECT
SELECT count(*) mess, friend FROM 
	(SELECT body, to_user_id AS friend FROM messages WHERE from_user_id = 1
	 UNION
	 SELECT body,from_user_id AS friend FROM messages WHERE to_user_id = 1) as history
JOIN
GROUP BY friend
ORDER BY mess DESC
LIMIT 1
;



/*2. Подсчитать общее количество лайков,
которые получили пользователи младше 11 лет.*/

                  
select id, count(*)  from likes 
    where media_id in 
        (select id from media 
            where user_id in
                (select id from users 
                    where id in (select user_id from profiles 
                        where (year (current_date) - year (birthday) ) < 11))
                )
           JOIN
        group by id with rollup;
      

                  
                  
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
JOIN user_id on vk.profiles
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

SELECT CASE (gender)
        WHEN 'm' THEN 'мужчин'
        WHEN 'f' THEN 'женщин'
    	END AS 'Кого больше', COUNT(*) as 'лайков'
FROM profiles p 
JOIN
    likes l 
WHERE l.user_id = p.user_id
GROUP BY gender 
LIMIT 1
;



