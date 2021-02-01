module Timestamp where

import Prelude

import Control.Alt ((<|>))
import Control.Monad.Error.Class (throwError)
import Data.DateTime (DateTime, millisecond, time)
import Data.Either (Either(..), either)
import Data.Enum (fromEnum)
import Data.Formatter.DateTime (Formatter, FormatterCommand(..), format, unformat)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.List (List, fromFoldable)
import Data.Newtype (class Newtype)
import Data.String.Regex (Regex, regex)
import Data.String.Regex as Regex
import Data.String.Regex.Flags (noFlags)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Now (nowDateTime)
import Foreign (ForeignError(..))
import Partial.Unsafe (unsafeCrashWith)
import Simple.JSON (class ReadForeign, class WriteForeign, readImpl, writeImpl)

mkIso8601Format :: Array FormatterCommand -> List FormatterCommand
mkIso8601Format milliParser = fromFoldable $
  [ YearFull
  , Placeholder "-"
  , MonthTwoDigits
  , Placeholder "-"
  , DayOfMonthTwoDigits
  , Placeholder "T"
  , Hours24
  , Placeholder ":"
  , MinutesTwoDigits
  , Placeholder ":"
  , SecondsTwoDigits
  ] <> milliParser <>
  [ Placeholder "Z"
  ]

iso8601ShortFormat :: Formatter
iso8601ShortFormat = mkIso8601Format []

iso86011DigitMillisFormat :: Formatter
iso86011DigitMillisFormat = mkIso8601Format [ Placeholder ".", MillisecondsShort ]

iso86012DigitsMillisFormat :: Formatter
iso86012DigitsMillisFormat = mkIso8601Format [ Placeholder ".", MillisecondsTwoDigits]

iso8601LongFormat :: Formatter
iso8601LongFormat = mkIso8601Format [ Placeholder ".", Milliseconds ]

stripMillis :: String -> String
stripMillis =
  Regex.replace theRegex replacement
  where
    replacement = ".$1$2$3"
    theRegex = regex "\\.(\\d)(\\d)(\\d)\\d+" noFlags
      # either unsafeCrashWith identity

newtype Timestamp = Timestamp DateTime
derive newtype instance eqTimestamp :: Eq Timestamp
derive newtype instance ordTimestamp :: Ord Timestamp
instance readTimestamp :: ReadForeign Timestamp where
  readImpl v = do
    s <- readImpl v
    let
      as = flip unformat s
      parsed =  as iso8601ShortFormat
            <|> as iso86011DigitMillisFormat
            <|> as iso86012DigitsMillisFormat
            <|> as iso8601LongFormat
            <|> unformat iso8601LongFormat (s # stripMillis)
    case parsed of
      Right d -> pure (Timestamp d)
      Left e -> throwError $ pure $ ForeignError e

instance writeTimestamp :: WriteForeign Timestamp where
  writeImpl = writeImpl <<< printTimestamp

derive instance genericTimestamp :: Generic Timestamp _
derive instance newtypeTimestamp :: Newtype Timestamp _
instance showTimestamp :: Show Timestamp where
  show = genericShow

nowTimestamp :: ∀ m. MonadEffect m => m Timestamp
nowTimestamp = liftEffect $ Timestamp <$> nowDateTime

printTimestamp :: Timestamp -> String
printTimestamp (Timestamp dt) = dt # format milliDigits
  where
    millis = dt # time # millisecond # fromEnum
    milliDigits = case millis of
      0                      -> iso8601ShortFormat
      ms | ms `mod` 100 == 0 -> iso86011DigitMillisFormat
      ms | ms `mod` 10  == 0 -> iso86012DigitsMillisFormat
      _                      -> iso8601LongFormat
