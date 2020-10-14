-- 1 задание
SELECT orders.id, users.name
FROM shop.users
JOIN shop.orders ON users.id = orders.user_id;

-- 2 задание
SELECT products.name, catalogs.*
FROM shop.products
JOIN shop.catalogs ON products.catalog_id = catalogs.id;

-- 3 задание
SELECT flights.id, c1.name, c2.name
FROM flights
JOIN cities c1 ON flights.`from` = c1.label
JOIN cities c2 ON flights.`to` = c2.label;