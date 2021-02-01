module Test.Control.Error.Util where

import Control.Error.Util ( (?:), (??), hoistMaybe, noteT, note, hushT, hush
                          , bool
                          )
import Control.Monad.Except (runExcept, except)
import Control.Monad.Maybe.Trans (MaybeT(MaybeT), runMaybeT)
import Data.Either (Either(..))
import Data.Identity (Identity(Identity))
import Data.Maybe (Maybe(..), fromMaybe, isNothing)
import Data.Newtype (unwrap)
import Prelude ((==), ($), discard, (<<<), (<$>))
import Test.Unit (TestSuite, test)
import Test.Unit.Assert as Assert

type MaybeId a = MaybeT Identity a

maybeId :: forall a. Maybe a -> MaybeId a
maybeId = MaybeT <<< Identity

testMaybe :: forall a. (a -> Boolean) -> Maybe a -> Boolean
testMaybe f a = fromMaybe false (f <$> a)

runIdentity :: forall a. Identity a -> a
runIdentity = unwrap

suite :: TestSuite
suite = do
  test "hush" $ do
    Assert.assert "Right is Just" $ testMaybe (_ == 5) (hush $ Right 5)
    Assert.assert "Left is Nothing" $ isNothing (hush $ Left 5)

  test "hushT" $ do
    let exR = except $ Right "right"
    let exL = except $ Left "left"

    Assert.assert "Except Right is Just" $ do
      let res = runIdentity <<< runMaybeT <<< hushT $ exR
      testMaybe (_ == "right") res

    Assert.assert "Except Left is Nothing" $ do
      let res = runIdentity <<< runMaybeT <<< hushT $ exL
      isNothing res

  test "note" $ do
    Assert.assert "Nothing is Left a" $ do
      let res = note "nothing" Nothing
      case res of
        Left a -> a == "nothing"
        _      -> false

    Assert.assert "Just is Right a" $ do
      let res = note "nothing" $ Just "something"
      case res of
        Right a -> a == "something"
        _       -> false

  test "noteT" $ do
    Assert.assert "Nothing is Left a" $ do
      let res = noteT "nothing" $ maybeId Nothing
      case (runExcept res) of
        Left a -> a == "nothing"
        _      -> false

    Assert.assert "Just is Right a" $ do
      let res = noteT "nothing" $ maybeId $ Just "something"
      case (runExcept res) of
        Right a -> a == "something"
        _       -> false

  test "hoistMaybe" $ do
    Assert.assert "lift Nothing" $ do
      let maybet = hoistMaybe Nothing
      isNothing (runIdentity <<< runMaybeT $ maybet)

    Assert.assert "lift Just" $ do
      let maybet = hoistMaybe $ Just 42
      let unwrap = (runIdentity <<< runMaybeT $ maybet)
      case unwrap of
        Just n -> n == 42
        _      -> false

  test "(??)" $ do
    Assert.assert "Nothing to ExceptT" $ do
      let res = Nothing ?? "nothing"
      let unwrap = runExcept res
      case unwrap of
        Left a -> a == "nothing"
        _      -> false

    Assert.assert "Just to ExceptT" $ do
      let res = Just "something" ?? "nothing"
      let unwrap = runExcept res
      case unwrap of
        Right a -> a == "something"
        _       -> false

  test "bool" $ do
    Assert.assert "choose first argument if false" $ (bool 5 42 false) == 5
    Assert.assert "choose second argument if true" $ (bool 5 42 true) == 42

  test "(?:)" $ do
    Assert.assert "from Nothing" $ (Nothing ?: "nothing") == "nothing"
    Assert.assert "from Just" $ (Just "something" ?: "nothing") == "something"
