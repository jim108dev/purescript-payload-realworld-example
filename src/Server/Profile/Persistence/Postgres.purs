-- | Reminder: All functions are supposed to do what they say otherwise it is an input error or an
-- | other kind of error. Input errors are returned others are thrown.
module Server.Profile.Persistence.Postgres where

import Prelude

import Control.Monad.Except (throwError)
import Data.Array (head)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Database.Postgres (Pool, Query(Query), withClient)
import Effect.Aff (Aff)
import Effect.Exception (error)
import Server.Profile.Interface.Persistence (Handle)
import Server.Profile.Type.Misc (InputError(..), Profile)
import Server.Shared.Persistence.Postgres.Query (PGError(..), p_, query, readJson)
import Shared.Type.Misc (FolloweeUsername, FollowerId)

mkHandle :: Pool -> Handle
mkHandle p =
  { findFollowee: findFollowee p
  , insertFollower: insertFollower p
  , deleteFollower: deleteFollower p
  }

findFollowee :: Pool -> Maybe FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
findFollowee pool followerId followeeUsername =
  withClient pool \conn ->
    query readJson
      ( Query
          """
SELECT
  followee.*,
  follower_id IS NOT NULL AS FOLLOWING
FROM
  "user" AS followee
  LEFT JOIN FOLLOWING ON (followee.id = followee_id)
  LEFT JOIN "user" AS follower ON (follower.id = $1)
WHERE
  followee.username = $2"""
      )
      [ p_ followerId, p_ followeeUsername ]
      conn
      >>= validate

insertFollower :: Pool -> FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
insertFollower pool followerId followeeUsername = do
  withClient pool \conn ->
    query readJson
      ( Query
          """
WITH inserted AS (
INSERT INTO FOLLOWING (follower_id, followee_id)
  SELECT
    $1,
    followee.id
  FROM
    "user" AS followee
  WHERE
    followee.username = $2
  RETURNING
    *
)
SELECT
  followee.*,
  TRUE AS FOLLOWING
FROM
  "user" AS followee,
  inserted
WHERE
  id = inserted.followee_id"""
      )
      [ p_ followerId, p_ followeeUsername ]
      conn
      >>= validate

deleteFollower :: Pool -> FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
deleteFollower pool followerId followeeUsername = do
  withClient pool \conn ->
    query readJson
      ( Query
          """
DELETE FROM FOLLOWING USING "user" AS followee
WHERE follower_id = $1
  AND followee.username = $2
  AND followee_id = followee.id
RETURNING
  followee.*,
  FALSE AS FOLLOWING"""
      )
      [ p_ followerId, p_ followeeUsername ]
      conn
      >>= validate

validate :: forall a. Either PGError (Array a) -> Aff (Either InputError a)
validate result = do
  case result of
    Left e -> case e of
      IntegrityError detail -> case detail.constraint of
        "follower_not_followee" -> pure $ Left FOLLOWER_EQUALS_FOLLOWEE
        "following_unique" -> pure $ Left FOLLOWING_EXISTS
        otherwise -> throwError $ error $ show e
      otherwise -> throwError $ error $ show e
    Right rows -> case head rows of
      Nothing -> pure $ Left NOT_FOUND
      Just row -> pure $ Right row
