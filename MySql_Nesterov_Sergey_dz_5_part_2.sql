/*
1) Подсчитайте средний возраст пользователей в таблице users
*/

SELECT  AVG(FLOOR((TO_DAYS(NOW()) - TO_DAYS(birthday)) / 365.25)) AS `midle` FROM users;
-- OR

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS age FROM users;





/*
2) Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/



SELECT DAYNAME('2020-02-13');

SELECT
    DAYNAME(CONCAT(YEAR(NOW()), SUBSTRING(birthday, 5, 10))) AS week_day_of_birthday_in_this_Year,
    COUNT(*) AS amount_of_birthday
FROM
    users
GROUP BY
    week_day_of_birthday_in_this_Year;
    
   
   /* З) Подсчитайте произведение чисел в столбце таблицы. */

SELECT ROUND(EXP(SUM(LN(id)))) 
FROM users WHERE id < 6;