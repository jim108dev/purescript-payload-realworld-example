module Server.User.Persistence.Postgres.Validation where

import Prelude
import Control.Monad.Except (throwError)
import Data.Array (head)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Database.PostgreSQL (PGError(..))
import Effect.Aff (Aff)
import Effect.Exception (error)
import Server.User.Type.Misc (InputError(..))

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
