-- Практическое задание по теме “Транзакции, переменные, представления”
-- Создаем таблицу users в базе sample аналогичную таблице users в базе shop
CREATE TABLE IF NOT EXISTS sample.users LIKE shop.users;

-- Транзакция 1го юзера из одной таблицы в другую (1 задание)
START TRANSACTION;
SELECT * FROM shop.users where id = 1;
INSERT sample.users SELECT * FROM shop.users where id = 1;
COMMIT;

SELECT * FROM sample.users;

-- Представление из 2 столбцов из таблиц products и catalogs (2 задание)
CREATE VIEW prod AS (SELECT products.name as products_name, catalogs.name as catalogs_name FROM shop.products
JOIN shop.catalogs ON products.catalog_id = catalogs.id);

SELECT * FROM prod;

-- Создаем 2 тамблицы и сравниваем значения между ними (3 задание)
SELECT * FROM sample.user;

CREATE TABLE IF NOT EXISTS sample.date_values (
`id` int NOT NULL AUTO_INCREMENT,
`created_at` datetime NOT NULL,
PRIMARY KEY (`id`) 
);

INSERT sample.date_values (`created_at`) VALUES
('2018-08-01'),
('2018-08-04'),
('2018-08-16'),
('2018-08-17');

SELECT * FROM sample.date_values;

CREATE TABLE IF NOT EXISTS sample.date_mth (
`created_at` datetime NOT NULL,
`status` tinyint not null default '0'
);

INSERT sample.date_mth (`created_at`) VALUES 
('2018-08-01'), ('2018-08-02'), ('2018-08-03'), ('2018-08-04'), ('2018-08-05'),
('2018-08-06'), ('2018-08-07'), ('2018-08-08'), ('2018-08-09'), ('2018-08-10'),
('2018-08-11'), ('2018-08-12'), ('2018-08-13'), ('2018-08-14'), ('2018-08-15'),
('2018-08-16'), ('2018-08-17'), ('2018-08-18'), ('2018-08-19'), ('2018-08-20'),
('2018-08-21'), ('2018-08-22'), ('2018-08-23'), ('2018-08-24'), ('2018-08-25'),
('2018-08-26'), ('2018-08-27'), ('2018-08-28'), ('2018-08-29'), ('2018-08-30'), ('2018-08-31');

SELECT id, date_values.created_at as date_values, date_mth.created_at as date_mth,  
IF(date_values.created_at = date_mth.created_at, '1', '0') as `status` FROM sample.date_values
RIGHT JOIN sample.date_mth on date_mth.created_at = date_values.created_at;

-- Удаляем все строки кроме 5 последних с сортировкой по дате (4 задание)
set @start := 0;
delete from sample.date_mth where `created_at` > 0 and 
(select @start := @start + 1 ) > 5 ORDER BY created_at DESC;


-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- функция hellow (1 задание)
DELIMITER //
drop function hellow;
CREATE FUNCTION hellow ()
returns TEXT DETERMINISTIC
BEGIN
  case 
	when (CURTIME() > '6:00' and CURTIME() < '12:00')
		then return 'Доброе утро';
	when (CURTIME() > '12:00' and CURTIME() < '18:00')
		then return 'Доброй день';
    when (CURTIME() > '00:00' and CURTIME() < '6:00')
		then return 'Доброй ночи';
	when (CURTIME() > '18:00' and CURTIME() < '00:00')
		then return 'Добрый вечер';
	end case;
END//
select hellow();

-- Триггер для проверки на null новых значений в поля name и description ( 2 задание )
DELIMITER //
CREATE DEFINER=`root`@`localhost` TRIGGER `products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
	if (new.`name` IS NULL and new.`description` is NULL) then
    signal sqlstate'45000' SET MESSAGE_TEXT = 'DELETE canceled';
    end if;
END//


-- Функция для расчета числа фибоначи от заданного числа (3 задание)
drop function fibonaci;
DELIMITER //
create function fibonaci(fi INT)
returns text DETERMINISTIC
begin
	declare i, one, two INT;
	set @two = 1;
	if (fi > 2) then
		set @i = 3;
		set @one = 1;
			while fi >= @i do
				set @two = @one + @two;
				set @one = @two - @one;
				set @i = @i + 1;
			end while;
	end if;
	return @two;
end//

select fibonaci(6);