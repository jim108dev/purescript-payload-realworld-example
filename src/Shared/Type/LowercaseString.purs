module Shared.Type.LowercaseString (fromString, LowercaseString) where

import Prelude
import Control.Monad.Except (except, runExcept)
import Data.Bifunctor (lmap)
import Data.Either (Either(..), either, fromRight)
import Data.Eq.Generic (genericEq)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Data.String (Pattern(..), Replacement(..), length, replaceAll, toLower, trim)
import Data.String.Regex (regex, replace)
import Data.String.Regex.Flags (global)
import Database.PostgreSQL (class FromSQLValue, class ToSQLValue)
import Foreign (F, Foreign, ForeignError(..), unsafeToForeign)
import Foreign.Class (class Decode, class Encode)
import Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Foreign.Object as Object
import Partial.Unsafe (unsafeCrashWith)
import Payload.Server.Internal.Querystring (ParsedQuery)
import Payload.Server.Params (class DecodeParam)
import Payload.Server.QueryParams (class DecodeQueryParam, DecodeError(..))
import Simple.JSON as JSON

newtype LowercaseString
  = LowercaseString String

fromString :: String -> Either String LowercaseString
fromString s =
  let
    i = mkIdentifier s

    len = length i
  in
    case unit of
      _
        | len == 0 -> Left "can't be empty"
      _
        | len > 50 -> Left "can't be longer than 50 characters"
      _ -> Right $ LowercaseString i

mkIdentifier :: String -> String
mkIdentifier =
  replaceAll (Pattern " ") (Replacement "-")
    <<< replace theRegex ""
    <<< toLower
    <<< trim
  where
  theRegex = regex "[^ a-z0-9_.:-]" global # either unsafeCrashWith identity

-- | A partial version of `fromString`.
-- unsafeFromString :: Partial => String -> LowercaseString
-- unsafeFromString = fromRight <<< fromString
toString :: LowercaseString -> String
toString (LowercaseString s) = s

derive instance genericLowercaseString :: Generic LowercaseString _

instance showLowercaseString :: Show LowercaseString where
  show = genericShow

instance eqLowercaseString :: Eq LowercaseString where
  eq = genericEq

instance decodeLowercaseString :: Decode LowercaseString where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance encodeLowercaseString :: Encode LowercaseString where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

instance readForeignLowercaseString :: JSON.ReadForeign LowercaseString where
  readImpl = fromForeign

fromForeign :: Foreign -> F LowercaseString
fromForeign f = do
  str :: String <- JSON.readImpl f
  except case fromString str of
    Left e -> Left $ pure $ ForeignError e
    Right a -> Right a

instance writeForeignLowercaseString :: JSON.WriteForeign LowercaseString where
  writeImpl = toForeign

toForeign :: LowercaseString -> Foreign
toForeign = unsafeToForeign <<< toString

instance decodeParamLowercaseString :: DecodeParam LowercaseString where
  decodeParam = fromString <<< toLower

instance decodeQueryParamString :: DecodeQueryParam LowercaseString where
  decodeQueryParam = decodeQueryParam

decodeQueryParam :: ParsedQuery -> String -> Either DecodeError LowercaseString
decodeQueryParam queryObj queryKey = case Object.lookup queryKey queryObj of
  Nothing -> Left (QueryParamNotFound { key: queryKey, queryObj })
  Just [] -> decodeErr [] $ "Expected single value but received empty Array"
  Just [ str ] -> case fromString (toLower str) of
    Left e -> decodeErr [] $ e
    Right a -> Right a
  Just arr -> decodeErr arr $ "Expected single value but received multiple: " <> show arr
  where
  decodeErr values msg = Left (QueryDecodeError { key: queryKey, values, message: msg, queryObj })

instance fromSqlValueLowercaseString :: FromSQLValue LowercaseString where
  fromSQLValue = lmap show <<< runExcept <<< fromForeign

instance toSQLValueLowercaseString :: ToSQLValue LowercaseString where
  toSQLValue = toForeign
