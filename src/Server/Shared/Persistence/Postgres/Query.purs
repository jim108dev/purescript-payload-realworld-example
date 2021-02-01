-- | Adapted from purescript-postgresql-client/src/Database/PostgreSQL.purs.
-- | rightfold/purescript-postgresql-client is licensed under the BSD 3-Clause "New" or "Revised" License
-- | Copyright (c) 2017, rightfold
module Server.Shared.Persistence.Postgres.Query where

import Prelude
import Data.Bifunctor (lmap)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(Just, Nothing), maybe)
import Data.Nullable (Nullable, toMaybe, toNullable)
import Data.String (indexOf)
import Data.String.Pattern (Pattern(..))
import Data.Traversable (traverse)
import Database.Postgres (Client, Query(..))
import Database.Postgres.SqlValue (SqlValue)
import Database.Postgres.SqlValue (class IsSqlValue, SqlValue, toSql)
import Effect.Aff (Aff, Error)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Foreign (Foreign)
import Simple.JSON as JSON

p_ :: forall a. IsSqlValue a => a -> SqlValue
p_ = toSql

type PostProcessor
  = { nullableLeft :: Error -> Nullable (Either PGError (Array Foreign))
    , right :: (Array Foreign) -> Either PGError (Array Foreign)
    }

postProcessor :: PostProcessor
postProcessor =
  { nullableLeft: toNullable <<< map Left <<< convertError
  , right: Right
  }

foreign import ffiSQLState :: Error -> Nullable String
foreign import ffiErrorDetail :: Error -> PGErrorDetail

data PGError
  = ConnectionError String
  | ConversionError String
  | InternalError PGErrorDetail
  | OperationalError PGErrorDetail
  | ProgrammingError PGErrorDetail
  | IntegrityError PGErrorDetail
  | DataError PGErrorDetail
  | NotSupportedError PGErrorDetail
  | QueryCanceledError PGErrorDetail
  | TransactionRollbackError PGErrorDetail

derive instance eqPGError :: Eq PGError
derive instance genericPGError :: Generic PGError _

instance showPGError :: Show PGError where
  show = genericShow

type PGErrorDetail
  = { severity :: String
    , code :: String
    , message :: String
    , detail :: String
    , hint :: String
    , position :: String
    , internalPosition :: String
    , internalQuery :: String
    , where_ :: String
    , schema :: String
    , table :: String
    , column :: String
    , dataType :: String
    , constraint :: String
    , file :: String
    , line :: String
    , routine :: String
    }

convertError :: Error -> Maybe PGError
convertError err = case toMaybe $ ffiSQLState err of
  Nothing -> Nothing
  Just sqlState -> Just $ convert sqlState $ ffiErrorDetail err
  where
  convert :: String -> PGErrorDetail -> PGError
  convert s =
    if prefix "0A" s then
      NotSupportedError
    else if prefix "20" s || prefix "21" s then
      ProgrammingError
    else if prefix "22" s then
      DataError
    else if prefix "23" s then
      IntegrityError
    else if prefix "24" s || prefix "25" s then
      InternalError
    else if prefix "26" s || prefix "27" s || prefix "28" s then
      OperationalError
    else if prefix "2B" s || prefix "2D" s || prefix "2F" s then
      InternalError
    else if prefix "34" s then
      OperationalError
    else if prefix "38" s || prefix "39" s || prefix "3B" s then
      InternalError
    else if prefix "3D" s || prefix "3F" s then
      ProgrammingError
    else if prefix "40" s then
      TransactionRollbackError
    else if prefix "42" s || prefix "44" s then
      ProgrammingError
    else if s == "57014" then
      QueryCanceledError
    else if prefix "5" s then
      OperationalError
    else if prefix "F" s then
      InternalError
    else if prefix "H" s then
      OperationalError
    else if prefix "P" s then
      InternalError
    else if prefix "X" s then
      InternalError
    else
      const $ ConnectionError s

prefix :: String -> String -> Boolean
prefix p = maybe false (_ == 0) <<< indexOf (Pattern p)

-- | Runs a query and returns all results.
query ::
  forall a.
  (Foreign -> Either PGError a) -> Query a -> Array SqlValue -> Client -> Aff (Either PGError (Array a))
query decode (Query sql) params client = do
  rows <- fromEffectFnAff $ ffiQuery postProcessor sql params client
  pure $ rows >>= traverse decode

query_ ::
  forall a.
  (Foreign -> Either PGError a) -> Query a -> Client -> Aff (Either PGError (Array a))
query_ decode (Query sql) client = do
  rows <- fromEffectFnAff $ ffiQuery_ postProcessor sql client
  pure $ rows >>= traverse decode

foreign import ffiQuery :: PostProcessor -> String -> Array SqlValue -> Client -> EffectFnAff (Either PGError (Array Foreign))
foreign import ffiQuery_ :: PostProcessor -> String -> Client -> EffectFnAff (Either PGError (Array Foreign))

readJson :: forall a. JSON.ReadForeign a => Foreign -> Either PGError a
readJson = lmap (ConversionError <<< show) <<< JSON.read

