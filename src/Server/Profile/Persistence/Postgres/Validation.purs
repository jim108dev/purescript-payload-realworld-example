module Server.Profile.Persistence.Postgres.Validation where

import Prelude
import Control.Monad.Except (throwError)
import Data.Either (Either(..))
import Database.PostgreSQL (PGError(..))
import Effect.Aff (Aff)
import Effect.Exception (error)
import Server.Profile.Type.Misc (InputError(..))

validateSingle :: forall a. Either PGError a -> Aff (Either InputError a)
validateSingle result = do
  case result of
    Left e -> case e of
      IntegrityError detail -> case detail.constraint of
        "follower_not_followee" -> pure $ Left FOLLOWER_EQUALS_FOLLOWEE
        "following_unique" -> pure $ Left FOLLOWING_EXISTS
        otherwise -> throwError $ error $ show e
      -- | `query1_` Throws `ConversionError ∷ PGError` is case of no results.
      ConversionError _ -> pure $ Left NOT_FOUND
      otherwise -> throwError $ error $ show e
    Right a -> pure $ Right a
