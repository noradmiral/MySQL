/* 1. Пусть задан некоторый пользователь. 
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользоваетелем.*/

SELECT users.id AS friend_requests, COUNT(inc.from_user_id) + COUNT(inc.to_user_id) AS mess 
  FROM users
       LEFT JOIN messages AS inc 
	      ON users.id = inc.from_user_id
	     AND inc.to_user_id = 1
       LEFT JOIN messages AS outc
	      ON users.id = outc.to_user_id
	     AND outc.from_user_id = 1 
 GROUP BY friend_requests
 ORDER BY mess DESC
 LIMIT 1;


/* 2. Подсчитать общее количество лайков, которые получили 11 самых молодых пользователей. */

SELECT SUM(likes)
  FROM (SELECT profiles.user_id, profiles.birthday, COUNT(likes.to_subject_id) AS likes
	  FROM profiles
	       JOIN likes
		 ON likes.to_subject_id = profiles.user_id
	 GROUP BY profiles.user_id, profiles.birthday
	 ORDER BY profiles.birthday DESC
	 LIMIT 11) AS countlikes;
	 
	
/* 3. Определить кто больше поставил лайков (всего):
 мужчины или женщины.*/
SELECT 
  (SELECT gender from profiles WHERE profiles.user_id = likes.user_id) AS gender,
  COUNT(*) AS 'Number of likes'
    FROM likes
    JOIN likes
         ON likes.from_user_id = profiles.user_id
    GROUP BY gender
    ORDER BY COUNT(*) DESC LIMIT 1;  
