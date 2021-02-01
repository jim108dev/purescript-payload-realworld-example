module Test.Main where

import Prelude

import Control.Monad.Except (runExcept)
import Data.DateTime (DateTime(..), Month(..), Time(..), canonicalDate)
import Data.Either (Either(..))
import Data.Enum (toEnum)
import Data.Maybe (fromJust)
import Data.Traversable (traverse_)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Partial.Unsafe (unsafePartial)
import Simple.JSON (readImpl, write, writeImpl)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)
import Timestamp (Timestamp(..))

main :: Effect Unit
main = launchAff_ do
  runSpec [consoleReporter] do
    describe "timestamp" do
      it "should parse a timestamp" do
        let
          ts = unsafePartial $ fromJust
            do
              y <- (toEnum 2018)
              d <- (toEnum 12)
              h <- (toEnum 12)
              m <- (toEnum 58)
              s <- (toEnum 10)
              ms <- (toEnum 862)
              pure $ (Timestamp (DateTime (canonicalDate y July d) (Time h m s ms)))
        (runExcept $ readImpl (write "2018-07-12T12:58:10.862Z")) `shouldEqual` (Right ts)

      let roundtrip e =
            runExcept $ do
              w <- writeImpl <$> (readImpl (write e) :: _ Timestamp)
              readImpl w

      it "should roundtrip a few timestamps from nakadi" do
        let
          timestamps =
            [ "2019-06-27T14:36:51.956Z"
            , "2019-06-04T00:31:05.642Z"
            , "2018-03-20T09:45:39.143Z"
            , "2019-06-02T02:41:45.244Z"
            , "2018-07-12T12:58:10.862Z"
            , "2019-07-04T07:43:48.398Z"
            ]
        traverse_ (\e -> (Right e) `shouldEqual` (roundtrip e)) timestamps
      it "should parse timestamps without millis" do
        let
          timestamps =
            [ "2019-06-27T14:36:51Z"
            , "2019-06-04T00:31:05Z"
            ]
          result =
            [ "2019-06-27T14:36:51Z"
            , "2019-06-04T00:31:05Z"
            ]
          actual = map roundtrip timestamps
        actual `shouldEqual` (map Right result)
      it "should parse timestamps with 1 digit millis" do
        let
          timestamps =
            [ "2019-06-27T14:36:51.2Z"
            , "2019-06-04T00:31:05.9Z"
            ]
          result =
            [ "2019-06-27T14:36:51.2Z"
            , "2019-06-04T00:31:05.9Z"
            ]
          actual = map roundtrip timestamps
        actual `shouldEqual` (map Right result)
      it "should parse timestamps with 2 digit millis" do
        let
          timestamps =
            [ "2019-06-27T14:36:51.22Z"
            , "2019-06-04T00:31:05.99Z"
            ]
          result =
            [ "2019-06-27T14:36:51.22Z"
            , "2019-06-04T00:31:05.99Z"
            ]
          actual = map roundtrip timestamps
        actual `shouldEqual` (map Right result)
      it "should parse timestamps with 3 digit millis" do
        let
          timestamps =
            [ "2019-06-27T14:36:51.222Z"
            , "2019-06-04T00:31:05.789Z"
            ]
          result =
            [ "2019-06-27T14:36:51.222Z"
            , "2019-06-04T00:31:05.789Z"
            ]
          actual = map roundtrip timestamps
        actual `shouldEqual` (map Right result)
      it "should parse timestamps with more than 3 digit millis (losing precision)" do
        let
          timestamps =
            [ "2019-06-27T14:36:51.2222222Z"
            , "2019-06-04T00:31:05.789999Z"
            ]
          result =
            [ "2019-06-27T14:36:51.222Z"
            , "2019-06-04T00:31:05.789Z"
            ]
          actual = map roundtrip timestamps
        actual `shouldEqual` (map Right result)
