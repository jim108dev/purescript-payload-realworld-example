SELECT
  ARRAY (t)::text[] AS tagList
FROM ( SELECT DISTINCT
    UNNEST(article_0.tag_list) AS tagList
  FROM
    article article_0
  ORDER BY
    1 ASC) sub_q0 (t);

