DROP DATABASE IF EXISTS conduit_database;

CREATE DATABASE conduit_database;

GRANT ALL ON conduit_database.* TO 'a' @ 'localhost' IDENTIFIED BY
  'password' WITH GRANT OPTION;

FLUSH PRIVILEGES;

SHOW DATABASES;

USE conduit_database;

CREATE EXTENSION IF NOT EXISTS citext;

