-- | Reminder: All functions are supposed to do what they say otherwise it is an input error or an
-- | other kind of error. Input errors are returned, others are thrown.
module Server.Profile.Persistence.Postgres.Main where

import Prelude

import Data.Either (Either)
import Data.Maybe (Maybe(..), maybe)
import Database.PostgreSQL (Pool)
import Effect.Aff (Aff)
import Selda (Col, FullQuery, isNull, leftJoin, lit, not_, restrict, selectFrom, (.==))
import Selda.PG (litPG)
import Selda.PG.Class (deleteFrom, insert1_, query1_)
import Selda.Query.Class (runSelda)
import Server.Profile.Interface.Persistence (Handle)
import Server.Profile.Persistence.Postgres.Type.Misc (DbOutputCols)
import Server.Profile.Persistence.Postgres.Validation (validateSingle)
import Server.Profile.Type.Misc (InputError, Profile)
import Server.Shared.Persistence.Postgres.Main (withConnection)
import Server.Shared.Persistence.Type.Misc (followingTable, userTable)
import Shared.Type.Misc (FolloweeUsername, FollowerId, Username, UserId)

mkHandle :: Pool -> Handle
mkHandle p =
  { deleteFollower: deleteFollower p
  , findFollowee: findFollowee p
  , insertFollower: insertFollower p
  }

findFollowee :: Pool -> Maybe FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
findFollowee pool followerId followeeUsername =
  withConnection pool
    (\conn -> runSelda conn $ query1_ $ selectFollowee followerId followeeUsername)
    >>= validateSingle

selectFollowee :: forall s. Maybe FollowerId -> FolloweeUsername -> FullQuery s (DbOutputCols s)
selectFollowee followerId followeeUsername =
  selectFrom userTable \fee -> do
    following <-
      leftJoin followingTable \f ->
        maybe (lit false) (\id -> f.followee_id .== fee.id && f.follower_id .== litPG id) followerId
    restrict $ fee.username .== (litPG followeeUsername)
    pure
      { bio: fee.bio
      , following: not_ $ isNull following.follower_id
      , image: fee.image
      , username: fee.username
      }

selectUserId :: forall s. Username -> FullQuery s ({ id :: Col s UserId })
selectUserId username =
  selectFrom userTable \r -> do
    restrict $ r.username .== (litPG username)
    pure { id: r.id }

insertFollower :: Pool -> FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
insertFollower pool followerId followeeUsername =
  withConnection pool
    ( \conn ->
        runSelda conn do
          { id: followeeId } <- query1_ $ selectUserId followeeUsername
          insert1_ followingTable { follower_id: followerId, followee_id: followeeId }
          query1_ $ selectFollowee (Just followerId) followeeUsername
    )
    >>= validateSingle

deleteFollower :: Pool -> FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
deleteFollower pool followerId followeeUsername =
  withConnection pool
    ( \conn ->
        runSelda conn do
          { id: followeeId } <- query1_ $ selectUserId followeeUsername
          deleteFrom followingTable (\r -> r.follower_id .== litPG followerId && r.followee_id .== litPG followeeId)
          query1_ $ selectFollowee (Just followerId) followeeUsername
    )
    >>= validateSingle
