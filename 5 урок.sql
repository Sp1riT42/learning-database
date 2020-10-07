use `shop`;
-- Создаем таблицу пользователей и заполняем её с типом varchar для даты создания и обновления
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(128),
  updated_at VARCHAR(128)
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Наталья', '1984-11-12', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Александр', '1985-05-20', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Сергей', '1988-02-14', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Иван', '1998-01-12', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Мария', '1992-08-29', '20.10.2017 8:10', '20.10.2017 8:10');

-- Преобразуем строки дат в дататайм формат, затем меняем тип данных у столбцов
  
UPDATE `users` SET created_at = str_to_date(created_at, '%e.%c.%Y %H:%i') WHERE id >= 1;
UPDATE `users` SET updated_at = str_to_date(updated_at, '%e.%c.%Y %H:%i') WHERE id >= 1;
  
ALTER TABLE `users` 
CHANGE COLUMN `created_at` `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
CHANGE COLUMN `updated_at` `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP;

-- Создаем тамблицу storehouses_products
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO `storehouses_products` (`storehouse_id`,`product_id`,`value`) VALUES
(1,1,0),
(2,2,2500),
(3,3,0),
(4,4,30),
(5,5,500),
(6,6,1);

-- Сортируем по value с нулями в конце
select `value` from `storehouses_products` order by value = 0, value;

-- Выборка пользователей по месяцу май и август
select id, name, date_format(birthday_at, '%M.%c.%Y %H:%i') from users where date_format(birthday_at, '%M') = 'August' or date_format(birthday_at, '%M') = 'May';

-- Создаем таблицу каталог и заполняем
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
  
  --  сортировка по порядку значений в IN
  select * from catalogs where id in (5, 1, 2) order by id = 2, id = 1, id = 5;
 
 -- Средний возраст пользователей в таблице users
  select AVG(timestampdiff(YEAR,birthday_at,NOW())) from users;
  
  -- Количество дней рождение substring(`birthday_at`, 1, 4) = 2020 as `day`
  select COUNT(*) AS `total`, dayname(date_format(birthday_at, '2020-%m-%c'))  as `day` from `users` group by `day`;
  
  -- Считаем произведение всех значение столбца value
  select exp(sum(ln(value))) from storehouses_products;
 

  