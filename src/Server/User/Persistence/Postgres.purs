-- | All functions are supposed to do what they say otherwise it is an input error or an
-- | other kind of error. Input errors are returned others are thrown.
module Server.User.Persistence.Postgres (mkHandle) where

import Prelude

import Control.Monad.Except (throwError)
import Data.Array (head)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Database.Postgres (Pool, Query(Query), withClient)
import Effect.Aff (Aff)
import Effect.Exception (error)
import Server.Shared.Persistence.Postgres.Query (PGError(..), p_, query, readJson)
import Server.User.Interface.Persistence (Handle)
import Server.User.Type.Misc (Credentials, InputError(..), Raw, User, Result)
import Shared.Type.Misc (Username, UserId)

mkHandle :: Pool -> Handle
mkHandle p =
  { findByCredentials: findByCredentials p
  , findByUsername: findByUsername p
  , findById: findById p
  , insert: insert p
  , update: update p
  , delete: delete p
  }

findByCredentials :: Pool -> Credentials -> Aff Result
findByCredentials pool { email, password } =
  withClient pool \conn ->
    query readJson (Query """SELECT * FROM "user" WHERE email = $1 AND password = $2""" :: Query User)
      [ p_ email, p_ password ]
      conn
      >>= validate

findByUsername :: Pool -> Username -> Aff Result
findByUsername pool username =
  withClient pool \conn ->
    query readJson (Query """SELECT * FROM "user" WHERE username = $1""" :: Query User)
      [ p_ username ]
      conn
      >>= validate

findById :: Pool -> UserId -> Aff Result
findById pool id =
  withClient pool \conn ->
    query readJson (Query """SELECT * FROM "user" WHERE id = $1""" :: Query User)
      [ p_ id ]
      conn
      >>= validate

insert :: Pool -> Raw -> Aff Result
insert pool u =
  withClient pool \conn ->
    query readJson (Query """INSERT INTO "user" (bio, email, image, password, username) VALUES ($1, $2, $3, $4, $5) RETURNING *""" :: Query User)
      [ p_ u.bio, p_ u.email, p_ u.image, p_ u.password, p_ u.username ]
      conn
      >>= validate

update :: Pool -> Raw -> UserId -> Aff Result
update pool r id =
  withClient pool \conn ->
    query readJson (Query """UPDATE "user" SET  bio = $1, email = $2, image = $3, password = $4, username = $5 WHERE id = $6 RETURNING *""" :: Query User)
      [ p_ r.bio, p_ r.email, p_ r.image, p_ r.password, p_ r.username, p_ id ]
      conn
      >>= validate

delete :: Pool -> UserId -> Aff Result
delete pool id =
  withClient pool \conn ->
    query readJson (Query """DELETE FROM "user" WHERE id = $1 RETURNING *""" :: Query User)
      [ p_ id ]
      conn
      >>= validate

validate :: forall a. Either PGError (Array a) -> Aff (Either InputError a)
validate result = do
  case result of
    Left e -> case e of
      IntegrityError detail -> case detail.constraint of
        "email_unique" -> pure $ Left EMAIL_EXISTS
        "username_unique" -> pure $ Left USERNAME_EXISTS
        otherwise -> throwError $ error $ show e
      otherwise -> throwError $ error $ show e
    Right rows -> case head rows of
      Nothing -> pure $ Left NOT_FOUND
      Just row -> pure $ Right row
