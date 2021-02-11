DROP FUNCTION IF EXISTS timestamp_to_char;

CREATE OR REPLACE FUNCTION timestamp_to_char (t timestamp with time zone)
  RETURNS text
  AS $$
BEGIN
  RETURN to_char(t, 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"');
END;
$$
LANGUAGE 'plpgsql';

DROP FUNCTION timestamp_to_char;

-- Function for testing
CREATE OR REPLACE FUNCTION timestamp_to_char (t timestamp with time zone)
  RETURNS text
  AS $$
BEGIN
  RETURN '2016-02-18T03:22:56.637Z';
END;
$$
LANGUAGE 'plpgsql';

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

CREATE FUNCTION insert_password ()
  RETURNS TRIGGER
  AS $$
BEGIN
  NEW.password := crypt(NEW.password, gen_salt('bf'));
  RETURN NEW;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER insert_user_password ON "user";

CREATE TRIGGER insert_user_password
  BEFORE INSERT ON "user"
  FOR EACH ROW
  EXECUTE PROCEDURE insert_password ();

CREATE FUNCTION update_password ()
  RETURNS TRIGGER
  AS $$
BEGIN
  NEW.password := CASE WHEN PASSWORD = crypt(NEW.password, PASSWORD) THEN
    PASSWORD
  ELSE
    crypt(NEW.password, gen_salt('bf'))
  END;
  RETURN NEW;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER update_user_password ON "user";

CREATE TRIGGER update_user_password
  BEFORE UPDATE ON "user"
  FOR EACH ROW
  EXECUTE PROCEDURE update_password ();

-- don't quote the language name
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

