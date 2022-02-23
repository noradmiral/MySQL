USE vk;

/* Задание №1
 * Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который
 * больше всех общался с выбранным пользователем (написал ему сообщений).
 */

-- Вариант №1
SELECT 
	u.id as 'id друга',
	u.firstname AS 'Имя',
	u.lastname AS 'Фамилия',
	count(*) messages
FROM users u
JOIN messages m ON (u.id = m.from_user_id OR u.id = m.to_user_id)
JOIN friend_requests fr ON (u.id = fr.initiator_user_id OR u.id = fr.target_user_id)
WHERE (fr.target_user_id = 1 OR fr.initiator_user_id = 1) AND fr.status ='approved' AND (m.from_user_id = 1 OR m.to_user_id = 1) AND u.id <> 1
GROUP BY u.id
ORDER BY messages DESC
LIMIT 1;


-- вариант №2
SELECT 
	u.id as 'id друга',
	u.firstname AS 'Имя',
	u.lastname AS 'Фамилия',
	count(*) messages
FROM users u
JOIN messages m ON (u.id = m.from_user_id AND  m.to_user_id = 1) OR (u.id = m.to_user_id AND m.from_user_id = 1) -- так наверное быстрее работать должно
JOIN friend_requests fr ON (u.id = fr.initiator_user_id OR u.id = fr.target_user_id) -- можно и сдесь предусмотреть условие = 1
WHERE (fr.target_user_id = 1 OR fr.initiator_user_id = 1) AND fr.status ='approved'
GROUP BY u.id
ORDER BY messages DESC
LIMIT 1;


/* Задание №2
* Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.
*/
-- сделал через правый и левый для закрепления. Можно было и без них. count не считает NULL поэтому работает :)

-- RIGHT JOIN 

SELECT
	count(l.id)
FROM 
likes l
RIGHT JOIN media m ON (l.media_id  = m.id)
RIGHT JOIN profiles p ON (m.user_id = p.user_id) 
WHERE p.birthday > now() - INTERVAL 11 YEAR
;

-- LEFT JOIN
SELECT
	count(l.id)	 
FROM profiles p 
LEFT JOIN media m ON (p.user_id = m.user_id)
LEFT JOIN likes l ON (m.id = l.media_id)
WHERE p.birthday > now() - INTERVAL 11 YEAR 
;


/*Задание №3
 * Определить кто больше поставил лайков (всего): мужчины или женщины.
*/

-- Вариант №1
SELECT 
	CASE p.gender
	WHEN 'm' THEN 'Мужчины'
	WHEN 'f' THEN 'Женщины'
	END AS 'Гендерная группа',
	count(*) AS 'Кол-во лайков'
FROM 
likes l 
JOIN users u ON (l.user_id = u.id)
JOIN profiles p ON (u.id = p.user_id)
GROUP BY p.gender
LIMIT 1
;

-- Вариант №2
SELECT 
f_or_m AS 'Гендерная группа', 
max(likes_vol) AS 'Кол-во лайков' 
FROM
(SELECT 
	CASE p.gender
	WHEN 'm' THEN 'Мужчины'
	WHEN 'f' THEN 'Женщины'
	END AS f_or_m,
	count(*) AS likes_vol 
FROM 
likes l 
JOIN users u ON (l.user_id = u.id)
JOIN profiles p ON (u.id = p.user_id)
GROUP BY p.gender) AS foo
;

