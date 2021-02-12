CREATE OR REPLACE FUNCTION update_updated_at ()
  RETURNS TRIGGER
  AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

DROP TRIGGER update_article_updated_at ON "user";

CREATE TRIGGER update_article_updated_at
  BEFORE UPDATE ON article
  FOR EACH ROW
  EXECUTE PROCEDURE update_updated_at ();

DROP TRIGGER update_comment_updated_at ON comment;

CREATE TRIGGER update_comment_updated_at
  BEFORE UPDATE ON comment
  FOR EACH ROW
  EXECUTE PROCEDURE update_updated_at ();

-- show triggers
SELECT
  event_object_schema AS table_schema,
  event_object_table AS table_name,
  trigger_schema,
  trigger_name,
  string_agg(event_manipulation, ',') AS event,
  action_timing AS activation,
  action_condition AS condition,
  action_statement AS definition
FROM
  information_schema.triggers
GROUP BY
  1,
  2,
  3,
  4,
  6,
  7,
  8
ORDER BY
  table_schema,
  table_name;

