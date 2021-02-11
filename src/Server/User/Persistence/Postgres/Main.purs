-- | All functions are supposed to do what they say otherwise it is an input error or an
-- | other kind of error. Input errors are returned others are thrown.
module Server.User.Persistence.Postgres.Main where

import Prelude

import Data.Either (Either)
import Data.Maybe (Maybe(..))
import Data.Nullable (toMaybe)
import Database.PostgreSQL (Pool)
import Effect.Aff (Aff)
import Selda (Col, FullQuery, restrict, selectFrom, (.==))
import Selda.PG (litPG)
import Selda.PG.Class (deleteFrom, insert, query, query1_, update) as S
import Selda.Query.Class (runSelda)
import Server.Shared.Persistence.Postgres.Main (crypt, cryptGenSalt, withConnection)
import Server.Shared.Persistence.Type.Misc (userTable)
import Server.User.Interface.Persistence (Handle)
import Server.User.Persistence.Postgres.Type.Misc (DbOutputCols, encryptedTable)
import Server.User.Persistence.Postgres.Validation (validate)
import Server.User.Type.Misc (Credentials, InputError, Patch, Raw, User)
import Shared.Type.LongString (LongString)
import Shared.Type.Misc (Email, Password, UserId, Username)

mkHandle :: Pool -> Handle
mkHandle p =
  { findByCredentials: findByCredentials p
  , findById: findById p
  , findByUsername: findByUsername p
  , insert: insert p
  , update: update p
  , delete: delete p
  }

findByCredentials :: Pool -> Credentials -> Aff (Either InputError User)
findByCredentials pool { email, password } =
  withConnection pool (\conn -> runSelda conn $ S.query $ selectByCredentials email password)
    >>= validate

selectByCredentials :: forall s. Email -> Password -> FullQuery s (DbOutputCols s)
selectByCredentials email password =
  selectFrom userTable \r -> do
    restrict $ r.email .== (litPG email) && r.password .== crypt (litPG password) r.password
    pure r

selectByUsername :: forall s. Username -> FullQuery s (DbOutputCols s)
selectByUsername username =
  selectFrom userTable \r -> do
    restrict $ r.username .== (litPG username)
    pure r

-- | If the username is not found, it is an input error.
findByUsername :: Pool -> Username -> Aff (Either InputError User)
findByUsername pool username =
  withConnection pool (\conn -> runSelda conn $ S.query $ selectByUsername username)
    >>= validate

selectById :: forall s. UserId -> FullQuery s (DbOutputCols s)
selectById id =
  selectFrom userTable \r -> do
    restrict $ r.id .== (litPG id)
    pure r

-- | If the userId is not found, it is an input error.
findById :: Pool -> UserId -> Aff (Either InputError User)
findById pool id =
  withConnection pool (\conn -> runSelda conn $ S.query $ selectById id)
    >>= validate

selectPassword :: forall s. Password -> FullQuery s { password :: Col s LongString }
selectPassword password =
  selectFrom (encryptedTable password) \r -> do
    pure r

-- | If it could not be inserted, because constraints are not met, it is an input error.
insert :: Pool -> Raw -> Aff (Either InputError User)
insert pool r =
  withConnection pool
    ( \conn ->
        runSelda conn do
          encrypted <- S.query1_ $ selectPassword r.password
          S.insert userTable [ { bio: r.bio, email: r.email, image: r.image, password: encrypted.password, username: r.username } ]
    )
    >>= validate

update :: Pool -> Patch -> UserId -> Aff (Either InputError User)
update pool p id =
  withConnection pool
    ( \conn ->
        runSelda conn do
          S.update userTable
            (\r -> r.id .== litPG id)
            ( \r ->
                r
                  { bio =
                    case p.bio of
                      Nothing -> r.bio
                      Just defined -> litPG $ toMaybe defined
                  , email =
                    case p.email of
                      Nothing -> r.email
                      Just defined -> litPG defined
                  , image =
                    case p.image of
                      Nothing -> r.image
                      Just defined -> litPG $ toMaybe defined
                  , password =
                    case p.password of
                      Nothing -> r.password
                      Just defined -> cryptGenSalt (litPG defined)
                  , username =
                    case p.username of
                      Nothing -> r.username
                      Just defined -> litPG defined
                  }
            )
          S.query $ selectById id
    )
    >>= validate

delete :: Pool -> UserId -> Aff (Either InputError User)
delete pool id =
  withConnection pool
    ( \conn ->
        runSelda conn do
          user <- S.query $ selectById id
          _ <- S.deleteFrom userTable (\r -> r.id .== litPG id)
          pure user
    )
    >>= validate
