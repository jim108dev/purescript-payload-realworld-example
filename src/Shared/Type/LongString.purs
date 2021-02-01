module Shared.Type.LongString where

import Prelude
import Control.Monad.Except (except)
import Data.Either (Either(..), fromRight)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Show (genericShow)
import Data.String (length, toLower)
import Database.Postgres.SqlValue (class IsSqlValue)
import Foreign (F, Foreign, ForeignError(..), unsafeToForeign)
import Foreign.Class (class Decode, class Encode)
import Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Payload.Server.Params (class DecodeParam)
import Simple.JSON as JSON
import Unsafe.Coerce (unsafeCoerce)

newtype LongString
  = LongString String

fromString :: String -> Either String LongString
fromString s =
  let
    len = length s
  in
    case unit of
      _ | len == 0 -> Left "can't be empty"
      _ | len > 1000 -> Left "can't be longer than 1000 characters"
      _ -> Right (LongString s)

-- | A partial version of `fromString`.
unsafeFromString :: Partial => String -> LongString
unsafeFromString = fromRight <<< fromString

l_ :: Partial => String -> LongString
l_ = unsafeFromString

toString :: LongString -> String
toString (LongString s) = s

derive instance genericLongString :: Generic LongString _

instance showLongString :: Show LongString where
  show = genericShow

instance eqLongString :: Eq LongString where
  eq o1 o2 = (toLower (toString o1)) == (toLower (toString o2))

instance decodeLongString :: Decode LongString where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance encodeLongString :: Encode LongString where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

instance readForeignLongString :: JSON.ReadForeign LongString where
  readImpl = readImpl

readImpl :: Foreign -> F LongString
readImpl f = do
  str :: String <- JSON.readImpl f
  except case fromString str of
    Left e -> Left $ pure $ ForeignError e
    Right a -> Right a

instance writeForeignLongString :: JSON.WriteForeign LongString where
  writeImpl = writeImpl

writeImpl :: LongString -> Foreign
writeImpl = unsafeToForeign <<< toString

instance decodeParamLongString :: DecodeParam LongString where
  decodeParam = fromString

instance isSqlValueShortString :: IsSqlValue LongString where
  toSql = unsafeCoerce
