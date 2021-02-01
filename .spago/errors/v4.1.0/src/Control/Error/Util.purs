-- | Use these functions to convert between `Maybe`, `Either`, `MaybeT`, and
-- | `ExceptT`.
module Control.Error.Util
  ( hush
  , hushT
  , note
  , noteT
  , hoistMaybe
  , (??)
  , (!?)
  , (?:)
  , fromMaybe'
  , exceptNoteA
  , exceptNoteM
  , bool
  )
where

import Prelude ( class Apply, class Applicative, class Monad
               , (<$>), pure, ($), (<<<), liftM1, const
               , flip
               )
import Data.Either (Either(Left, Right), either)
import Control.Monad.Except.Trans (ExceptT(..), runExceptT)
import Control.Monad.Maybe.Trans (MaybeT(..), runMaybeT)
import Data.Maybe (Maybe(Just, Nothing), maybe, fromMaybe)

-- | Suppress the `Left` value of an `Either`
hush :: forall a b. Either a b -> Maybe b
hush = either (const Nothing) Just

-- | Suppress the `Left` value of an `ExceptT`
hushT :: forall a b m. Monad m => ExceptT a m b -> MaybeT m b
hushT = MaybeT <<< liftM1 hush <<< runExceptT

-- | Tag the `Nothing` value of a `Maybe`
note :: forall a b. a -> Maybe b -> Either a b
note a = maybe (Left a) Right

-- | Tag the `Nothing` value of a `MaybeT`
noteT :: forall a b m. Monad m => a -> MaybeT m b -> ExceptT a m b
noteT a = ExceptT <<< liftM1 (note a) <<< runMaybeT

-- | Lift a `Maybe` to the `MaybeT` monad
hoistMaybe :: forall b m. Monad m => Maybe b -> MaybeT m b
hoistMaybe = MaybeT <<< pure

-- | Convert a `Maybe` value into the `ExceptT` monad
exceptNoteM :: forall a e m. Applicative m => Maybe a -> e -> ExceptT e m a
exceptNoteM a e = ExceptT (pure $ note e a)

infixl 9 exceptNoteM as ??

-- | Convert an applicative `Maybe` value into the `ExceptT` monad
exceptNoteA :: forall a e m. Apply m => m (Maybe a) -> e -> ExceptT e m a
exceptNoteA a e = ExceptT (note e <$> a)

infixl 9 exceptNoteA as !?

-- | Case analysis for the `Boolean` type
bool :: forall a. a -> a -> Boolean -> a
bool a b c = if c then b else a

-- | An infix form of `fromMaybe` with arguments flipped.
fromMaybe' :: forall a. Maybe a -> a -> a
fromMaybe' = flip fromMaybe

infixl 9 fromMaybe' as ?:
