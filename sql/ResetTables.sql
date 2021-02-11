DROP TABLE IF EXISTS "user" CASCADE;

CREATE TABLE "user" (
  id int GENERATED ALWAYS AS IDENTITY,
  bio text,
  email CITEXT NOT NULL CONSTRAINT email_unique UNIQUE,
  image text,
  password TEXT NOT NULL,
  username CITEXT NOT NULL CONSTRAINT username_unique UNIQUE,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS article CASCADE;

CREATE TABLE article (
  author_id int NOT NULL,
  body text NOT NULL,
  created_at timestamp with time zone DEFAULT '2016-02-18 03:22:56', -- CURRENT_TIMESTAMP,
  description text NOT NULL,
  id int GENERATED ALWAYS AS IDENTITY,
  slug CITEXT NOT NULL CONSTRAINT slug_unique UNIQUE,
  tag_list CITEXT[] NOT NULL,
  title CITEXT NOT NULL,
  updated_at timestamp with time zone DEFAULT '2016-02-18 03:22:56', --CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT author_exists FOREIGN KEY (author_id) REFERENCES "user" (id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS comment CASCADE;

CREATE TABLE comment (
  id int GENERATED ALWAYS AS IDENTITY,
  created_at timestamp with time zone DEFAULT '2016-02-18 03:22:56', --CURRENT_TIMESTAMP,
  updated_at timestamp with time zone DEFAULT '2016-02-18 03:22:56', --CURRENT_TIMESTAMP,
  body text NOT NULL,
  article_id int NOT NULL,
  author_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (author_id) REFERENCES "user" (id) ON DELETE CASCADE,
  FOREIGN KEY (article_id) REFERENCES "article" (id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS FOLLOWING CASCADE;

CREATE TABLE FOLLOWING (
  follower_id int NOT NULL,
  followee_id int NOT NULL CONSTRAINT follower_not_followee CHECK (followee_id <> follower_id),
  CONSTRAINT following_unique PRIMARY KEY (follower_id, followee_id),
  CONSTRAINT follower_exists FOREIGN KEY (follower_id) REFERENCES "user" (id) ON DELETE CASCADE,
  CONSTRAINT followee_exists FOREIGN KEY (followee_id) REFERENCES "user" (id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS favorited CASCADE;

CREATE TABLE favorited (
  user_id int NOT NULL,
  article_id int NOT NULL,
  CONSTRAINT favorited_unique PRIMARY KEY (user_id, article_id),
  CONSTRAINT user_exists FOREIGN KEY (user_id) REFERENCES "user" (id) ON DELETE CASCADE,
  CONSTRAINT article_exists FOREIGN KEY (article_id) REFERENCES "article" (id) ON DELETE CASCADE
);

DROP VIEW IF EXISTS TAG;

CREATE VIEW TAG AS
SELECT
  ARRAY ( SELECT DISTINCT
      unnest(tag_list)
    FROM
      article
    ORDER BY
      1)::text[];

