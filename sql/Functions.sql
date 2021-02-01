DROP FUNCTION IF EXISTS timestamp_to_char;

CREATE OR REPLACE FUNCTION timestamp_to_char (t timestamp with time zone)
  RETURNS text
  AS $$
BEGIN
  RETURN to_char(t, 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"');
END;
$$
LANGUAGE 'plpgsql';

-- Function for testing
CREATE OR REPLACE FUNCTION timestamp_to_char (t timestamp with time zone)
  RETURNS text
  AS $$
BEGIN
  RETURN '2016-02-18T03:22:56.637Z';
END;
$$
LANGUAGE 'plpgsql';

