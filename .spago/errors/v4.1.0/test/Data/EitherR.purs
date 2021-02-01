module Test.Data.EitherR where

import Control.Alt ((<|>))
import Data.Either (Either(Left, Right))
import Data.EitherR (EitherR, succeed, runEitherR)
import Prelude (class Eq, (==), ($), pure, discard, bind)
import Test.Unit (test, TestSuite)
import Test.Unit.Assert as Assert

data TestError = TestError Int
instance eqTestError :: Eq TestError where
  eq (TestError i) (TestError j) = i == j


suite :: TestSuite
suite = do
  test "EitherR monad" $ do
    let succeedResult = runEitherR $ do
                          x <- pure 1
                          _ <- succeed 2
                          pure x
    Assert.assert "`succeed` breaks execution chain with `Right` value" $
      succeedResult == Right 2
  test "EitherR alt" $ do
    let successesAggregation =
          succeed [1] <|>
          succeed [2] <|>
          (succeed [3] :: EitherR (Array Int) TestError)
    Assert.assert "`alt` aggregates results" $
      (runEitherR successesAggregation) == Right [1, 2, 3]
    let e1 = (successesAggregation <|> pure (TestError 1) <|> pure (TestError 2))
    Assert.assert "`alt` returns first error value" $
      (runEitherR e1) == Left (TestError 1)

