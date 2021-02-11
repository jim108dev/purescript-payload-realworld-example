SELECT
  sub_q0.username AS username,
  sub_q0.updatedAt AS updatedAt,
  sub_q0.title AS title,
  sub_q0.tagList AS tagList,
  sub_q0.slug AS slug,
  sub_q0.image AS image,
  sub_q0.id AS id,
  sub_q0.following AS FOLLOWING,
  sub_q0.favoritesCount AS favoritesCount,
  sub_q0.favorited AS favorited,
  sub_q0.description AS description,
  sub_q0.createdAt AS createdAt,
  sub_q0.body AS body,
  sub_q0.bio AS bio,
  sub_q0.authorId AS authorId
FROM (
  SELECT
    user_1.username AS username,
    article_0.updated_at AS updatedAt,
    article_0.title AS title,
    article_0.tag_list::text[] AS tagList,
    article_0.slug AS slug,
    user_1.image AS image,
    article_0.id AS id,
    (NOT (following_2.follower_id IS NULL)) AS FOLLOWING,
    (
      SELECT
        CAST(COUNT(favorited_0.article_id) AS integer) AS count
      FROM
        favorited favorited_0
      WHERE (favorited_0.article_id = article_0.id)) AS favoritesCount,
    (NOT (favorited_3.user_id IS NULL)) AS favorited,
    article_0.description AS description,
    article_0.created_at AS createdAt,
    article_0.body AS body,
    user_1.bio AS bio,
    user_1.id AS authorId
  FROM
    article article_0
    JOIN "user" user_1 ON ((user_1.id = article_0.author_id))
    LEFT JOIN FOLLOWING following_2 ON (((following_2.followee_id = user_1.id)
          AND FALSE))
    LEFT JOIN favorited favorited_3 ON (((favorited_3.article_id = article_0.id)
          AND FALSE))) sub_q0
JOIN favorited favorited_1 ON ((sub_q0.id = favorited_1.article_id))
JOIN "user" user_2 ON (((favorited_1.user_id = user_2.id)
      AND (user_2.username = 'jake')))
WHERE ('angularjs' = ANY (sub_q0.tagList))
AND (sub_q0.username = 'jake')
ORDER BY
  sub_q0.updatedAt DESC
LIMIT 1;

