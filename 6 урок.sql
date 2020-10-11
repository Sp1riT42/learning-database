-- Находим количество сообщений отправленных друг другу друзьями один из которых  id = 26
SELECT 
from_user_id,
to_user_id,
(select count(id) from vk_new.messages 
where (messages.from_user_id = friend_requests.from_user_id and messages.to_user_id = friend_requests.to_user_id) or
(messages.from_user_id = friend_requests.to_user_id and messages.to_user_id = friend_requests.from_user_id)) as mes
FROM vk_new.friend_requests where `status` = 1 and (from_user_id = 26 or to_user_id = 26) order by mes DESC;


-- Сумма всех лайков которые получили 10 самых молодых пользователей
SELECT
  users_id,
  TIMESTAMPDIFF(YEAR, birthday, NOW()) as `year`,
  (SELECT
(select count(from_user_id) from vk_new.likes where likes.message_id = messages.id) +
(SELECT
(select count(from_user_id) from vk_new.likes where likes.media_id = media.id) 
FROM vk_new.media WHERE user_id = vp.users_id) +
 (SELECT
(select count(from_user_id) from vk_new.likes where likes.community_id = communities.id) 
FROM vk_new.communities WHERE admin_id = vp.users_id)
FROM vk_new.messages
WHERE from_user_id = vp.users_id limit 1)
FROM vk_new.profiles as vp
WHERE 
  TIMESTAMPDIFF(YEAR, birthday, NOW()) < 14 ORDER BY `year` LIMIT 10;

-- Находим количество гендеров из всех лайков и сортируем от большего
select
(select gender from vk_new.profiles where profiles.users_id = likes.from_user_id) as genders,
count(*)
from vk_new.likes group by genders order by genders desc;


-- Находим 10 самых молодых пользователей с наименьшей активностью
SELECT
*
FROM
(
SELECT
	users_id,
	(((SELECT
		(select count(from_user_id) from vk_new.likes where likes.message_id = messages.id) 
	FROM vk_new.messages WHERE from_user_id = profiles.users_id limit 1) 
    + 
    (SELECT
		(select count(from_user_id) from vk_new.likes where likes.media_id = media.id) 
	FROM vk_new.media WHERE user_id = profiles.users_id limit 1) 
    + 
    (SELECT
		(select count(from_user_id) from vk_new.likes where likes.community_id = communities.id) 
	FROM vk_new.communities WHERE admin_id = profiles.users_id limit 1)) -- as sum_likes,
    +
    (SELECT count(id) FROM vk_new.messages WHERE messages.from_user_id = profiles.users_id) -- as sum_messages,
    +
    (SELECT count(id) FROM vk_new.media WHERE media.user_id = profiles.users_id) -- as sum_media,
    +
    (SELECT count(from_user_id) FROM vk_new.friend_requests WHERE friend_requests.from_user_id = profiles.users_id) -- as sum_friend_request,
    +
    (SELECT count(id) FROM vk_new.communities WHERE communities.admin_id = profiles.users_id))  as sum_activity_all
FROM vk_new.profiles
) as sum_activity
where sum_activity_all is not null order by sum_activity_all limit 10;











