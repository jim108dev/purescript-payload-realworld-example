module Server.Comment.Persistence.Postgres.Main where

import Prelude

import Control.Monad.Except (throwError)
import Data.Either (Either(..), either)
import Data.Maybe (Maybe(..), maybe)
import Database.PostgreSQL (Pool)
import Effect.Aff (Aff)
import Effect.Exception (error)
import Selda (Col, FullQuery, innerJoin, isNull, leftJoin, lit, not_, restrict, selectFrom, (.==))
import Selda.PG (litPG)
import Selda.PG.Class (deleteFrom, insert1, query)
import Selda.Query.Class (runSelda)
import Server.Comment.Interface.Persistence (Handle)
import Server.Comment.Persistence.Postgres.Type.Misc (DbOutputCols)
import Server.Comment.Persistence.Postgres.Validation (validateSearch, validateInsert)
import Server.Comment.Type.Misc (Comment, InputError, Raw)
import Server.Shared.Persistence.Postgres.Main (withConnection)
import Server.Shared.Persistence.Type.Misc (articleTable, commentTable, followingTable, userTable)
import Server.Shared.Util.Selda (query1_)
import Shared.Type.Misc (ArticleId, CommentId, Slug, UserId)

mkHandle :: Pool -> Handle
mkHandle p =
  { delete: delete p
  , insert: insert p
  , search: search p
  }

search :: Pool -> Maybe UserId -> Slug -> Aff (Array Comment)
search pool userId slug =
  withConnection pool
    (\conn -> runSelda conn $ query $ selectComment userId (Left slug))
    >>= validateSearch

selectComment :: forall s. Maybe UserId -> Either Slug CommentId -> FullQuery s (DbOutputCols s)
selectComment userId slugOrId =
  selectFrom commentTable \c -> do
    a <- innerJoin articleTable \a -> a.id .== c.article_id
    u <- innerJoin userTable \u -> u.id .== c.author_id
    f <-
      leftJoin followingTable \f ->
        maybe (lit false) (\id -> f.followee_id .== u.id && f.follower_id .== litPG id) userId
    restrict $ either (\s -> a.slug .== (litPG s)) (\i -> c.id .== (litPG i)) slugOrId
    pure
      { bio: u.bio
      , following: not_ $ isNull f.follower_id
      , image: u.image
      , username: u.username
      , body: c.body
      , createdAt: c.created_at
      , id: c.id
      , updatedAt: c.updated_at
      }

selectArticleId :: forall s. Slug -> FullQuery s ({ id :: Col s ArticleId })
selectArticleId slug =
  selectFrom articleTable \r -> do
    restrict $ r.slug .== (litPG slug)
    pure { id: r.id }

insert :: Pool -> UserId -> Raw -> Slug -> Aff (Either InputError Comment)
insert pool userId raw slug =
  withConnection pool
    ( \conn ->
        runSelda conn do
          { id: articleId } <- query1_ $ selectArticleId slug
          { id: commentId } <- insert1 commentTable { body: raw.body, article_id: articleId, author_id: userId }
          query1_ $ selectComment (Just userId) (Right commentId)
    )
    >>= validateInsert

delete :: Pool -> CommentId -> Slug -> Aff (Either InputError CommentId)
delete pool id slug =
  withConnection pool
    ( \conn ->
        runSelda conn do
          deleteFrom commentTable (\r -> r.id .== (litPG id))
    )
    >>= either (throwError <<< error <<< show) (pure <<< Right <<< const id)
