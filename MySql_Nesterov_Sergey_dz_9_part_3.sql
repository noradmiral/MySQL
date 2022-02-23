/*
 1) Создайте хранимую функцию hello(), которая будет возвращать приветствие,
 в зависимости от текущего времени суток. С 6:00 до 12:00 функция
 должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция
 должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер",
 с 00:00 до 6:00 — "Доброй ночи".
 */


DROP FUNCTION IF EXISTS get_ver;
delimiter //
CREATE FUNCTION get_ver()
    RETURNS TEXT DETERMINISTIC
BEGIN
    set @time = '12:00:00';
        IF(@time >= '06:00:00' AND @time < '12:00:00') THEN
            return 'Доброе утро';
        ELSEIF(@time >= '12:00:00' AND @time < '18:00:00') THEN
            return 'Добрый день';
        ELSEIF(@time >= '18:00:01' AND @time < '23:59:59') THEN
            return 'Добрый вечер';
        ELSE
            return 'Доброй ночи';
        END IF;
end //
delimiter ;
SELECT get_ver();




/*
 2) В таблице products есть два текстовых поля: name с названием товара и description
 с его описанием. Допустимо присутствие обоих полей или одно из них.
 Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
 Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
 При попытке присвоить полям NULL-значение необходимо отменить операцию.
 */

DROP TRIGGER IF EXISTS myTrigger;
delimiter //
CREATE TRIGGER myTrigger BEFORE INSERT ON products
    FOR EACH ROW
BEGIN
    IF( NEW.name IS NULL AND NEW.description IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
    END IF;
END //
delimiter ;



/*
 3)(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
 Числами Фибоначчи называется последовательность в которой число равно сумме
 двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
 */



 -- не работает  пишет что нельзя использовать триггеры и рекурсию сразу. не нашел решение
DROP FUNCTION IF EXISTS fibonacci;
delimiter //
CREATE FUNCTION fibonacci(n INT)
RETURNS INT DETERMINISTIC
BEGIN
	IF(n <= 1) THEN
		RETURN n;
	ELSE
		RETURN
                fibonacci(n - 1) + fibonacci(n - 2);
	END IF;
END //
delimiter ;

SELECT fibonacci(10);