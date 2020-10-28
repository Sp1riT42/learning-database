-- 1 Задание по оптимизации.
-- Создаем таблицу logs
CREATE TABLE shop.`logs` (
`create_at` DATETIME NOT NULL DEFAULT current_timestamp(),
`table_name` VARCHAR(128) NOT NULL,
`id_prime_key` INT(11) NOT NULL,
`description_name` VARCHAR(128) NOT NULL
) ENGINE=ARCHIVE;

-- Создаем 3 тригера на афтер инсерт
DROP TRIGGER IF EXISTS `shop`.`users_AFTER_INSERT`;
DELIMITER $$
USE `shop`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
INSERT shop.`logs` (`table_name`,`id_prime_key`,`description_name`) VALUES ('users',new.`id`,new.`name`);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `shop`.`catalogs_AFTER_INSERT`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`catalogs_AFTER_INSERT` AFTER INSERT ON `catalogs` FOR EACH ROW
BEGIN
INSERT shop.`logs` (`table_name`,`id_prime_key`,`description_name`) VALUES ('catalogs',new.`id`,new.`name`);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `shop`.`products_AFTER_INSERT`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`products_AFTER_INSERT` AFTER INSERT ON `products` FOR EACH ROW
BEGIN
INSERT shop.`logs` (`table_name`,`id_prime_key`,`description_name`) VALUES ('products',new.`id`,new.`name`);
END$$
DELIMITER ;


-- Второе задание по оптимизации
-- Создаем процедуру заполнения таблицы users миллионом значений после её вызова. 
DELIMITER //
CREATE PROCEDURE mill ()
BEGIN
  DECLARE i INT DEFAULT 1000000;
  WHILE i > 0 DO
	INSERT shop.users (`name`,`birthday_at`) VALUES ('Neo','1962-03-11');
	SET i = i - 1;
  END WHILE;
END//
DELIMITER ;
  
  call mill();