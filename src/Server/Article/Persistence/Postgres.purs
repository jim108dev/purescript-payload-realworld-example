module Server.Article.Persistence.Postgres (mkHandle) where

import Prelude

import Control.Monad.Except (throwError)
import Data.Array (head)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Pattern(..), Replacement(..), replaceAll, toLower)
import Database.Postgres (Pool, Query(..), withClient)
import Effect.Aff (Aff)
import Effect.Exception (error)
import Partial.Unsafe (unsafePartial)
import Server.Article.Interface.Persistence (Handle)
import Server.Article.Type.Misc (Article, FullQuery, InputError(..), RangeQuery, Raw, SingleResult)
import Server.Shared.Persistence.Postgres.Query (PGError(..), p_, query, query_, readJson)
import Shared.Type.LowercaseString (fromString)
import Shared.Type.Misc (Bio, Body, CommentId, CreatedAt, Description, Favorited, FavoritesCount, Following, Image, Slug, Tag, Title, UpdatedAt, UserId, Username, FollowerId)
import Shared.Type.ShortString (toString)
import Shared.Util.String (format1)

mkHandle :: Pool -> Handle
mkHandle p =
  { findMostRecentFromFollowee: findMostRecentFromFollowee p
  , findOne: findOne p
  , findTags: findTags p
  , insert: insert p
  , delete: delete p
  , update: update p
  , insertFavorite: insertFavorite p
  , deleteFavorite: deleteFavorite p
  , search: search p
  }

search :: Pool -> Maybe FollowerId -> FullQuery -> Aff (Array Article)
search pool followerId q =
  withClient
    pool \conn ->
    query readJson
      ( Query
          ( (selectArticle "$1")
              <> """
        LEFT JOIN "user" AS fa_user ON (fa.user_id = fa_user.id)
        WHERE (($2::text IS NULL) OR (u.username = $2))
          AND (($3::text IS NULL) OR (fa_user.username = $3))
          AND (($6::text IS NULL) OR ($6=ANY(a.tag_list))) 
        ORDER BY a.updated_at DESC LIMIT $4 OFFSET $5 """
          )
      )
      [ p_ followerId, p_ q.author, p_ q.favorited, p_ (fromMaybe 1000 q.limit), p_ q.offset, p_ q.tag ]
      conn
      >>= validateArray

findMostRecentFromFollowee :: Pool -> FollowerId -> RangeQuery -> Aff (Array Article)
findMostRecentFromFollowee pool followerId q =
  withClient
    pool \conn ->
    query readJson
      (Query ((selectArticle "$1") <> """ WHERE fo.follower_id = $1 ORDER BY updated_at DESC LIMIT $2 OFFSET $3 """))
      [ p_ followerId, p_ (fromMaybe 1000 q.limit), p_ q.offset ]
      conn
      >>= validateArray

findOne :: Pool -> Maybe FollowerId -> Slug -> Aff SingleResult
findOne pool followerId slug =
  withClient
    pool \conn ->
    query readJson
      (Query ((selectArticle "$1") <> """WHERE a.slug = $2"""))
      [ p_ followerId, p_ slug ]
      conn
      >>= validateSingle

selectArticle :: String -> String
selectArticle param =
  format1
    ( """ SELECT
  u.bio,
  fo.followee_id IS NOT NULL AS following,
  u.image,
  u.username,
  a.body,
  timestamp_to_char (a.created_at) AS created_at,
  a.description,
  a.id,
  fa.article_id IS NOT NULL AS favorited,
  CAST((SELECT COUNT(*) FROM favorited WHERE favorited.article_id = a.id) AS INTEGER) AS favorites_count,
  a.slug,
  a.tag_list::TEXT[],
  a.title,
  timestamp_to_char (a.updated_at) AS updated_at
FROM
  article AS a
  INNER JOIN "user" AS u ON (a.author_id = u.id)
  LEFT JOIN following AS fo ON (u.id = fo.followee_id) AND (fo.follower_id = {1})
  LEFT JOIN favorited AS fa ON (a.id = fa.article_id) """
    )
    param

insert :: Pool -> Raw -> UserId -> Aff (Either InputError Slug)
insert pool r userId = case fromString (toString r.title) of
  Left e -> pure $ Left SLUG_CREATION_FAILED
  Right slug ->
    withClient
      pool \conn ->
      query readJson
        ( Query
            """INSERT INTO article (author_id, body, description, slug, tag_list, title)
      VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING slug
      """
        )
        [ p_ userId, p_ r.body, p_ r.description, p_ slug, p_ r.tagList, p_ r.title ]
        conn
        >>= validateSlug

update :: Pool -> Raw -> Slug -> Aff (Either InputError Slug)
update pool r slug = case fromString (toString r.title) of
  Left e -> pure $ Left SLUG_CREATION_FAILED
  Right newSlug ->
    withClient
      pool \conn ->
      query readJson
        ( Query
            """UPDATE article SET body = $1, description = $2, slug = $3, title = $4 WHERE slug = $5 RETURNING slug"""
        )
        [ p_ r.body, p_ r.description, p_ newSlug, p_ r.title, p_ slug ]
        conn
        >>= validateSlug

insertFavorite :: Pool -> Slug -> UserId -> Aff (Either InputError Slug)
insertFavorite pool slug userId =
  withClient
    pool \conn ->
    query readJson
      ( Query
          """INSERT INTO favorited (user_id, article_id)
  SELECT
    $2,
    a.id
  FROM
    article AS a
  WHERE
    a.slug = $1
  RETURNING $1 as slug
    """
      )
      [ p_ slug, p_ userId ]
      conn
      >>= validateSlug

deleteFavorite :: Pool -> Slug -> UserId -> Aff (Either InputError Slug)
deleteFavorite pool slug userId =
  withClient
    pool \conn ->
    query readJson
      ( Query
          """DELETE FROM favorited
USING article as a
WHERE a.slug = $1
  AND favorited.user_id = $2
RETURNING $1 as slug
    """
      )
      [ p_ slug, p_ userId ]
      conn
      >>= validateSlug

delete :: Pool -> Slug -> UserId -> Aff (Either InputError Slug)
delete pool id slug =
  withClient pool \conn ->
    query readJson
      (Query """DELETE FROM article WHERE slug = $1 AND author_id = $2 RETURNING slug""")
      [ p_ id, p_ slug ]
      conn
      >>= validateSlug

findTags :: Pool -> Aff (Array Tag)
findTags pool =
  withClient
    pool \conn ->
    query_ readJson
      (Query """SELECT ARRAY(SELECT DISTINCT unnest(tag_list)FROM article ORDER BY 1)::TEXT[] AS tags""")
      conn
      >>= validateTags

validateSlug :: Either PGError (Array { slug :: Slug }) -> Aff (Either InputError Slug)
validateSlug result = do
  case result of
    Left e -> case e of
      IntegrityError detail -> case detail.constraint of
        "slug_unique" -> pure $ Left SLUG_EXISTS
        "favorited_unique" -> pure $ Left FAVORITED_EXISTS
        otherwise -> throwError $ error $ show e
      otherwise -> throwError $ error $ show e
    Right rows -> case head rows of
      Nothing -> pure $ Left NOT_FOUND
      Just row -> pure $ Right $ row.slug

validateTags :: Either PGError (Array { tags :: Array Tag }) -> Aff (Array Tag)
validateTags result = do
  case result of
    Left e -> throwError $ error $ show e
    Right rows -> case head rows of
      Nothing -> pure []
      Just row -> pure row.tags

validateArray :: Either PGError (Array DBOutputRow) -> Aff (Array Article)
validateArray result = do
  case result of
    Left e -> throwError $ error $ show e
    Right rows -> pure $ mkArticle <$> rows

type DBOutputRow
  = { bio :: Maybe Bio
    , following :: Following
    , image :: Maybe Image
    , username :: Username
    -- Rest
    , body :: Body
    , created_at :: CreatedAt
    , description :: Description
    , favorited :: Favorited
    , favorites_count :: FavoritesCount
    , id :: CommentId
    , slug :: Slug
    , tag_list :: Array Tag
    , title :: Title
    , updated_at :: UpdatedAt
    }

mkArticle :: DBOutputRow -> Article
mkArticle r =
  { author:
      { bio: r.bio
      , following: r.following
      , image: r.image
      , username: r.username
      }
  , body: r.body
  , createdAt: r.created_at
  , description: r.description
  , favorited: r.favorited
  , favoritesCount: r.favorites_count
  , slug: r.slug
  , tagList: r.tag_list
  , title: r.title
  , updatedAt: r.updated_at
  }

validateSingle :: Either PGError (Array DBOutputRow) -> Aff (Either InputError Article)
validateSingle result = do
  case result of
    Left e -> case e of
      IntegrityError detail -> case detail.constraint of
        "slug_unique" -> pure $ Left SLUG_EXISTS
        "favorited_unique" -> pure $ Left FAVORITED_EXISTS
        otherwise -> throwError $ error $ show e
      otherwise -> throwError $ error $ show e
    Right rows -> case head rows of
      Nothing -> pure $ Left NOT_FOUND
      Just row -> pure $ Right $ mkArticle row
