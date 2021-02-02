module Server.Comment.Persistence.Postgres (mkHandle) where

import Prelude

import Control.Monad.Except (throwError)
import Data.Array (head)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Database.Postgres (Pool, Query(..), withClient)
import Effect.Aff (Aff)
import Effect.Exception (error)
import Server.Comment.Interface.Persistence (Handle)
import Server.Comment.Type.Misc (Comment, InputError(..), Raw, SingleResult)
import Server.Shared.Persistence.Postgres.Query (PGError(..), p_, query, readJson)
import Shared.Type.Misc (Bio, Body, CommentId, CreatedAt, Following, Image, Slug, UpdatedAt, UserId, Username)

mkHandle :: Pool -> Handle
mkHandle p =
  { delete: delete p
  , insert: insert p
  , search: search p
  }

search :: Pool -> Maybe UserId -> Slug -> Aff (Array Comment)
search pool userId slug =
  withClient pool \conn ->
    query readJson
      ( Query
          """SELECT
  c.body,
  timestamp_to_char(c.created_at) as created_at,
  c.id AS id,
  timestamp_to_char(c.updated_at) as updated_at,
  u.bio,
  f.followee_id IS NOT NULL AS FOLLOWING,
  u.image,
  u.username
FROM
  comment AS c
  INNER JOIN "article" AS a ON c.article_id = a.id
  INNER JOIN "user" AS u ON c.author_id = u.id
  LEFT JOIN FOLLOWING AS f ON (c.author_id = f.followee_id)
    AND (f.follower_id = $1)
WHERE
  a.slug = $2"""
      )
      [ p_ userId, p_ slug ]
      conn
      >>= validateSearch

insert :: Pool -> UserId -> Raw -> Slug -> Aff SingleResult
insert pool userId raw slug =
  withClient pool \conn ->
    query readJson
      ( Query
          """WITH inserted AS (
INSERT INTO comment (body, article_id, author_id)
  SELECT
    $2,
    article.id,
    $1
  FROM
    article
  WHERE
    article.slug = $3
  RETURNING
    *
)
SELECT
  i.body,
  timestamp_to_char(i.created_at) as created_at,
  i.id as id,
  timestamp_to_char(i.updated_at) as updated_at,
  a.bio,
  false as following,
  a.image,
  a.username
FROM
  "user" AS a, inserted as i
WHERE
  a.id = i.author_id"""
      )
      [ p_ userId, p_ raw.body, p_ slug ]
      conn
      >>= validateInsert

delete :: Pool -> CommentId -> Slug -> Aff (Either InputError CommentId)
delete pool id slug =
  withClient pool \conn ->
    query readJson
      ( Query
          """DELETE FROM comment USING "article"
WHERE article.slug = $2
  AND comment.id = $1
RETURNING
  comment.id"""
      )
      [ p_ id, p_ slug ]
      conn
      >>= validateDelete

type DBOutputRow
  = { body :: Body
    , created_at :: CreatedAt
    , id :: CommentId
    , updated_at :: UpdatedAt
    , bio :: Maybe Bio
    , following :: Following
    , image :: Maybe Image
    , username :: Username
    }

mkComment :: DBOutputRow -> Comment
mkComment r =
  { author:
      { bio: r.bio
      , following: r.following
      , image: r.image
      , username: r.username
      }
  , body: r.body
  , createdAt: r.created_at
  , id: r.id
  , updatedAt: r.updated_at
  }

validateInsert :: Either PGError (Array DBOutputRow) -> Aff (Either InputError Comment)
validateInsert result = do
  case result of
    Left e -> case e of
      IntegrityError detail -> case detail.constraint of
        "email_unique" -> pure $ Left EMAIL_EXITS
        otherwise -> throwError $ error $ show e
      otherwise -> throwError $ error $ show e
    Right rows -> case head rows of
      Nothing -> pure $ Left NOT_FOUND
      Just row -> pure $ Right $ mkComment row

validateDelete :: Either PGError (Array { id :: CommentId }) -> Aff (Either InputError CommentId)
validateDelete result = do
  case result of
    Left e -> throwError $ error $ show e
    Right rows -> case head rows of
      Nothing -> pure $ Left NOT_FOUND
      Just row -> pure $ Right row.id

validateSearch :: Either PGError (Array DBOutputRow) -> Aff (Array Comment)
validateSearch result = do
  case result of
    Left e -> throwError $ error $ show e
    Right rows -> pure $ mkComment <$> rows
