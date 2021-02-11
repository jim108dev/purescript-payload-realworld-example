module Server.Article.Persistence.Postgres.Validation where

import Prelude

import Control.Monad.Except (throwError)
import Data.Array (head)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Database.PostgreSQL (PGError(..))
import Effect.Aff (Aff)
import Effect.Exception (error)
import Server.Article.Persistence.Postgres.Type.Misc (DbOutput, mkArticle)
import Server.Article.Type.Misc (Article, InputError(..))
import Shared.Type.Misc (Tag)

validateArray :: Either PGError (Array DbOutput) -> Aff (Array Article)
validateArray result = do
  case result of
    Left e -> throwError $ error $ show e
    Right rows -> pure $ mkArticle <$> rows

validateSlug :: forall a. Either PGError a -> Aff (Either InputError a)
validateSlug result = do
  case result of
    Left e -> case e of
      -- | `query1_` Throws `ConversionError ∷ PGError` is case of no results.
      ConversionError _ -> pure $ Left NOT_FOUND
      otherwise -> throwError $ error $ show e
    Right a -> pure $ Right a

validateTags :: Either PGError (Array { array :: Array Tag }) -> Aff (Array Tag)
validateTags result = do
  case result of
    Left e -> throwError $ error $ show e
    Right rows -> case head rows of
      Nothing -> pure []
      Just row -> pure row.array

validateSingle :: Either PGError (DbOutput) -> Aff (Either InputError Article)
validateSingle result = do
  case result of
    Left e -> case e of
      IntegrityError detail -> case detail.constraint of
        "slug_unique" -> pure $ Left SLUG_EXISTS
        "favorited_unique" -> pure $ Left FAVORITED_EXISTS
        otherwise -> throwError $ error $ show e
      -- | `query1_` Throws `ConversionError ∷ PGError` is case of no results.
      ConversionError _ -> pure $ Left NOT_FOUND
      otherwise -> throwError $ error $ show e
    Right a -> pure $ Right $ mkArticle a
