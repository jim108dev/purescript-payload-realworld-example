module Server.Comment.Persistence.Postgres.Validation where

import Prelude
import Control.Monad.Except (throwError)
import Data.Either (Either(..))
import Database.PostgreSQL (PGError(..))
import Effect.Aff (Aff)
import Effect.Exception (error)
import Server.Comment.Persistence.Postgres.Type.Misc (DbOutput, mkComment)
import Server.Comment.Type.Misc (Comment, InputError(..))

validateSearch :: Either PGError (Array DbOutput) -> Aff (Array Comment)
validateSearch result = do
  case result of
    Left e -> throwError $ error $ show e
    Right rows -> pure $ mkComment <$> rows

validateInsert :: Either PGError DbOutput -> Aff (Either InputError Comment)
validateInsert result = do
  case result of
    Left e -> case e of
      IntegrityError detail -> case detail.constraint of
        "email_unique" -> pure $ Left EMAIL_EXITS
        otherwise -> throwError $ error $ show e
      -- | `query1_` Throws `ConversionError ∷ PGError` is case of no results.
      ConversionError _ -> pure $ Left NOT_FOUND
      otherwise -> throwError $ error $ show e
    Right a -> pure $ Right $ mkComment a
