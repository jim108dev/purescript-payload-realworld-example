module Shared.Type.ShortString where

import Prelude

import Control.Monad.Except (except, runExcept)
import Data.Bifunctor (lmap)
import Data.Either (Either(..), fromRight)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Data.String (length, toLower)
import Database.PostgreSQL (class FromSQLValue, class ToSQLValue)
import Foreign (F, Foreign, ForeignError(..), unsafeToForeign)
import Foreign.Class (class Decode, class Encode)
import Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Foreign.Object as Object
import Payload.Server.Internal.Querystring (ParsedQuery)
import Payload.Server.Params (class DecodeParam)
import Payload.Server.QueryParams (class DecodeQueryParam, DecodeError(..))
import Simple.JSON as JSON

newtype ShortString
  = ShortString String

fromString :: String -> Either String ShortString
fromString s =
  let
    len = length s
  in
    case unit of
      _
        | len == 0 -> Left "can't be empty"
      _
        | len > 50 -> Left "can't be longer than 50 characters"
      _ -> Right (ShortString s)

-- | A partial version of `fromString`.
-- unsafeFromString :: Partial => String -> ShortString
-- unsafeFromString = fromRight <<< fromString

toString :: ShortString -> String
toString (ShortString s) = s

derive instance genericShortString :: Generic ShortString _

instance showShortString :: Show ShortString where
  show = genericShow

instance eqShortString :: Eq ShortString where
  eq o1 o2 = (toLower (toString o1)) == (toLower (toString o2))

instance decodeShortString :: Decode ShortString where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance encodeShortString :: Encode ShortString where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

instance readForeignShortString :: JSON.ReadForeign ShortString where
  readImpl = fromForeign

fromForeign :: Foreign -> F ShortString
fromForeign f = do
  str :: String <- JSON.readImpl f
  except case fromString str of
    Left e -> Left $ pure $ ForeignError e
    Right a -> Right a

instance writeForeignShortString :: JSON.WriteForeign ShortString where
  writeImpl = toForeign

toForeign :: ShortString -> Foreign
toForeign = unsafeToForeign <<< toString

instance decodeParamShortString :: DecodeParam ShortString where
  decodeParam = fromString <<< toLower

instance decodeQueryParamString :: DecodeQueryParam ShortString where
  decodeQueryParam = decodeQueryParam

decodeQueryParam :: ParsedQuery -> String -> Either DecodeError ShortString
decodeQueryParam queryObj queryKey = case Object.lookup queryKey queryObj of
  Nothing -> Left (QueryParamNotFound { key: queryKey, queryObj })
  Just [] -> decodeErr [] $ "Expected single value but received empty Array"
  Just [ str ] -> case fromString (toLower str) of
    Left e -> decodeErr [] $ e
    Right a -> Right a
  Just arr -> decodeErr arr $ "Expected single value but received multiple: " <> show arr
  where
  decodeErr values msg = Left (QueryDecodeError { key: queryKey, values, message: msg, queryObj })

instance fromSqlValueShortString :: FromSQLValue ShortString where
  fromSQLValue = lmap show <<< runExcept <<< fromForeign

instance toSQLValueProductType :: ToSQLValue ShortString where
  toSQLValue = toForeign
