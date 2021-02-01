module Test.Main where

import Prelude (discard, Unit, ($))

import Control.Monad.Maybe.Trans (MaybeT)
import Data.Identity (Identity)
import Effect (Effect)
import Test.Control.Error.Util (suite) as UtilTest
import Test.Data.EitherR (suite) as EitherRTest
import Test.Unit (suite)
import Test.Unit.Main (runTest)

type MaybeId a = MaybeT Identity a


main :: Effect Unit
main = runTest $ do
  suite "Control.Error.Util" UtilTest.suite
  suite "Data.EitherR" EitherRTest.suite
