module Server.Article.Persistence.Postgres.Main where

import Prelude
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), maybe)
import Database.PostgreSQL (Pool)
import Effect.Aff (Aff)
import Selda (Col, Table(..), aggregate, asc, count, distinct, innerJoin, isNull, leftJoin, limit, lit, not_, orderBy, restrict, selectFrom, selectFrom_, (.==))
import Selda (FullQuery) as S
import Selda.PG (generateSeries, litPG)
import Selda.PG.Class (deleteFrom, insert1_, query)
import Selda.PG.Class (update) as S
import Selda.Query.Class (runSelda)
import Selda.Query.Type (Order(..))
import Server.Article.Interface.Persistence (Handle)
import Server.Article.Persistence.Postgres.Type.Misc (DbOutputCols)
import Server.Article.Persistence.Postgres.Validation (validateArray, validateSingle, validateSlug, validateTags)
import Server.Article.Type.Misc (Article, FullQuery, Id, InputError(..), Patch, RangeQuery, Raw)
import Server.Shared.Persistence.Postgres.Main (any, toArrayTextArray, toTextArray, logQuery, subQuery, withConnection, unnest)
import Server.Shared.Persistence.Type.Misc (articleTable, favoritedTable, followingTable, unitTable, userTable)
import Server.Shared.Util.Selda (query1_)
import Shared.Type.LowercaseString (fromString)
import Shared.Type.Misc (FollowerId, Slug, Tag, UserId)
import Shared.Type.ShortString (toString)

mkHandle :: Pool -> Handle
mkHandle p =
  { delete: delete p
  , deleteFavorite: deleteFavorite p
  , findOne: findOne p
  , findTags: findTags p
  , insert: insert p
  , insertFavorite: insertFavorite p
  , search: search p
  , searchMostRecentFromFollowees: searchMostRecentFromFollowees p
  , update: update p
  }

selectByQuery :: forall s. Maybe FollowerId -> FullQuery -> S.FullQuery s (DbOutputCols s)
selectByQuery followerId q =
  selectFrom_ (select followerId) \a -> do
    maybe (pure unit) (\author -> restrict $ a.username .== litPG author) q.author
    maybe (pure unit)
      ( \favoritedByUsername -> do
          fa <- innerJoin favoritedTable \fa -> (a.id .== fa.article_id)
          u <- innerJoin userTable \u -> (fa.user_id .== u.id) && (u.username .== litPG favoritedByUsername)
          pure unit
      )
      q.favorited
    maybe (pure unit) (\tag -> restrict $ litPG tag .== (any a.tagList)) q.tag
    orderBy Desc a.updatedAt
    maybe (pure unit) (\i -> limit i) q.limit
    pure a

search :: Pool -> Maybe FollowerId -> FullQuery -> Aff (Array Article)
search pool followerId q =
  withConnection pool (\conn -> runSelda conn $ query $ selectByQuery followerId q)
    >>= validateArray

selectMostRecentFromFollowees :: forall s. FollowerId -> RangeQuery -> S.FullQuery s (DbOutputCols s)
selectMostRecentFromFollowees followerId q =
  distinct
    $ selectFrom_ (select (Just followerId)) \a -> do
        fo <- innerJoin followingTable \fo -> (litPG followerId .== fo.follower_id) && (a.authorId .== fo.followee_id)
        orderBy Desc a.updatedAt
        maybe (pure unit) (\i -> limit i) q.limit
        pure a

searchMostRecentFromFollowees :: Pool -> FollowerId -> RangeQuery -> Aff (Array Article)
searchMostRecentFromFollowees pool followerId q =
  withConnection pool (\conn -> runSelda conn $ query $ selectMostRecentFromFollowees followerId q)
    >>= validateArray

findOne :: Pool -> Maybe FollowerId -> Slug -> Aff (Either InputError Article)
findOne pool followerId slug =
  withConnection pool
    (\conn -> runSelda conn $ query1_ $ selectBySlug slug followerId)
    >>= validateSingle

selectBySlug :: forall s. Slug -> Maybe UserId -> S.FullQuery s (DbOutputCols s)
selectBySlug slug followerId =
  selectFrom_ (select followerId) \s -> do
    restrict $ s.slug .== litPG slug
    pure s

countFavorites :: forall s. Col s Id -> S.FullQuery s ({ value :: Col s Int })
countFavorites id =
  aggregate
    $ selectFrom favoritedTable \f -> do
        restrict $ f.article_id .== id
        pure { value: count f.article_id }

select :: forall s. Maybe FollowerId -> S.FullQuery s (DbOutputCols s)
select followerId =
  selectFrom articleTable \a -> do
    u <- innerJoin userTable \u -> u.id .== a.author_id
    fo <-
      leftJoin followingTable \fo ->
        fo.followee_id .== u.id
          && maybe (lit false) (\id -> fo.follower_id .== litPG id) followerId
    fa <-
      leftJoin favoritedTable \fa ->
        fa.article_id .== a.id
          && maybe (lit false) (\id -> fa.user_id .== litPG id) followerId
    pure
      { bio: u.bio
      , body: a.body
      , createdAt: a.created_at
      , description: a.description
      , favorited: not_ $ isNull fa.user_id
      , favoritesCount: subQuery (countFavorites a.id)
      , following: not_ $ isNull fo.follower_id
      , id: a.id
      , image: u.image
      , slug: a.slug
      , tagList: toTextArray a.tag_list
      , title: a.title
      , updatedAt: a.updated_at
      , username: u.username
      , authorId: u.id
      }

insert :: Pool -> Raw -> UserId -> Aff (Either InputError Article)
insert pool r userId = case fromString (toString r.title) of
  Left e -> pure $ Left SLUG_CREATION_FAILED
  Right slug ->
    withConnection pool
      ( \conn ->
          runSelda conn do
            insert1_ articleTable
              { author_id: userId
              , body: r.body
              , description: r.description
              , slug
              , tag_list: r.tagList
              , title: r.title
              }
            query1_ $ selectBySlug slug (Just userId)
      )
      >>= validateSingle

update :: Pool -> Patch -> Slug -> UserId -> Aff (Either InputError Article)
update pool p slug userId = case p.title of
  Nothing -> update' pool p slug slug userId
  Just newTitle -> case fromString (toString newTitle) of
    Left e -> pure $ Left SLUG_CREATION_FAILED
    Right newSlug -> update' pool p slug newSlug userId

update' :: Pool -> Patch -> Slug -> Slug -> UserId -> Aff (Either InputError Article)
update' pool p slug newSlug userId =
  withConnection pool
    ( \conn ->
        runSelda conn do
          S.update articleTable
            (\r -> r.slug .== litPG slug)
            ( \r ->
                r
                  { body =
                    case p.body of
                      Nothing -> r.body
                      Just defined -> litPG defined
                  , description =
                    case p.description of
                      Nothing -> r.description
                      Just defined -> litPG defined
                  , title =
                    case p.title of
                      Nothing -> r.title
                      Just defined -> litPG defined
                  , slug = litPG newSlug
                  }
            )
          query1_ $ selectBySlug newSlug (Just userId)
    )
    >>= validateSingle

insertFavorite :: Pool -> Slug -> UserId -> Aff (Either InputError Article)
insertFavorite pool slug userId =
  withConnection pool
    ( \conn ->
        runSelda conn do
          { id: articleId } <- query1_ $ selectBySlug slug (Just userId)
          insert1_ favoritedTable { article_id: articleId, user_id: userId }
          query1_ $ selectBySlug slug (Just userId)
    )
    >>= validateSingle

deleteFavorite :: Pool -> Slug -> UserId -> Aff (Either InputError Article)
deleteFavorite pool slug userId =
  withConnection pool
    ( \conn ->
        runSelda conn do
          { id: articleId } <- query1_ $ selectBySlug slug (Just userId)
          deleteFrom favoritedTable (\r -> (litPG articleId .== r.article_id) && (litPG userId .== r.user_id))
          query1_ $ selectBySlug slug (Just userId)
    )
    >>= validateSingle

delete :: Pool -> Slug -> UserId -> Aff (Either InputError Slug)
delete pool slug userId =
  withConnection pool
    ( \conn ->
        runSelda conn do
          a <- query1_ $ selectBySlug slug (Just userId)
          deleteFrom articleTable (\r -> litPG a.id .== r.id)
          pure a.slug
    )
    >>= validateSlug

selectDistinctTagLists :: forall s. S.FullQuery s { tagList :: Col s (Array Tag) }
selectDistinctTagLists =
  distinct
    $ selectFrom articleTable \a -> do
        let
          tagList = unnest a.tag_list
        orderBy asc tagList
        pure { tagList }

selectTags :: forall s. S.FullQuery s { tags :: Col s (Array Tag) }
selectTags =
  selectFrom unitTable \_ ->
    pure
      { tags: toArrayTextArray selectDistinctTagLists
      }

findTags :: Pool -> Aff (Array Tag)
findTags pool =
  withConnection pool (\conn -> runSelda conn $ query selectTags)
    >>= validateTags
