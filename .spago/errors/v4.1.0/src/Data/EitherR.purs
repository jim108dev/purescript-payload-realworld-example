-- | This module provides `throwEither` and `cachEither` for Either. These
-- | functions reside here because `throwEither` and `catchEither` correspond
-- | to `return` and `bind` for flipped `Either` monad: `EitherR`.
-- |
-- | `catchEither` differs from `MonadError` (`cacheError`) - `catchEither` is
-- | more general as it allows you to change the left value's type.
-- |
-- | `throwEither` is just `throwError` but exists here for consistency.
-- |
-- | More advanced users can use `EitherR` and `ExceptRT` to program in an
-- | entirely symmetric "success monad" where exceptional results are the norm
-- | and successful results terminate the computation.  This allows you to chain
-- | error-handlers using `do` notation and pass around exceptional values of
-- | varying types until you can finally recover from the error:
-- |
-- |     runExceptRT $ do
-- |       e2   <- ioExceptionHandler e1
-- |       bool <- arithmeticExceptionhandler e2
-- |       when bool $ lift $ putStrLn "DEBUG: Arithmetic handler did something"
-- |
-- | If any of the above error handlers 'succeed', no other handlers are tried.
-- | If you choose not to typefully distinguish between the error and sucess
-- | monad, then use `flipEither` and `flipET`, which swap the type variables without
-- | changing the type.


module Data.EitherR
  ( EitherR(..)
  , runEitherR
  , succeed
  , throwEither
  , catchEither
  , handleEither
  , fmapL
  , flipEither
  , ExceptRT(..)
  , runExceptRT
  , succeedT
  , fmapLT
  , flipET
  )
where

import Control.Alt (class Alt)
import Control.Alternative (class Alternative)
import Control.Monad.Error.Class (throwError)
import Control.Monad.Except.Trans (ExceptT(ExceptT), runExceptT)
import Control.Monad.Trans.Class (lift, class MonadTrans)
import Control.MonadPlus (class MonadPlus)
import Control.MonadZero (class MonadZero)
import Control.Plus (class Plus)
import Data.Either (Either(Right, Left))
import Data.Monoid (mempty, class Monoid)
import Effect.Class (liftEffect, class MonadEffect)
import Prelude (class Bind, bind, flip, pure, class Monad, class Applicative, class Apply, class Functor, ap, liftM1, (<>), (<<<), (>>=), (<$>), ($))

-- | If `Either e r` is the error monad, then `EitherR r e` is the
-- | corresponding success monad, where:
-- |
-- |   * `return` is `throwEither`.
-- |
-- |   * `(>>=)` is `catchEither`.
-- |
-- |   * Successful results abort the computation
-- |

newtype EitherR r e = EitherR (Either e r)

runEitherR :: forall e r. EitherR r e -> Either e r
runEitherR (EitherR either) = either

instance functorEitherR :: Functor (EitherR r) where
  map = liftM1

instance applyEitherR :: Apply (EitherR r) where
  apply = ap

instance applicativeEitherR :: Applicative (EitherR r) where
  pure e = EitherR (Left e)

instance bindEitherR :: Bind (EitherR r) where
  bind (EitherR m) f =
    case m of
      Left e  -> f e
      Right r -> EitherR (Right r)

instance monadEitherR :: Monad (EitherR r)

instance altEitherR :: Monoid r => Alt (EitherR r) where
  alt e1@(EitherR (Left _))  _ = e1
  alt _  e2@(EitherR (Left _)) = e2
  alt (EitherR (Right r1)) (EitherR (Right r2)) =
    EitherR (Right (r1 <> r2))

instance plusEitherR :: Monoid r => Plus (EitherR r) where
  empty = EitherR (Right mempty)

instance alternativeEitherR :: Monoid r => Alternative (EitherR r)

instance monadZeroEitherR :: Monoid r => MonadZero (EitherR r)

instance monadPlusEitherR :: Monoid r => MonadPlus (EitherR r)

-- | Complete error handling, returning a result
succeed :: forall e r. r -> EitherR r e
succeed r = EitherR (pure r)

-- | `throwEither` in the error monad corresponds to `return` in the success monad
throwEither :: forall e r. e -> Either e r
throwEither e = runEitherR (pure e)

-- | `catchEither` in the error monad corresponds to `(>>=)` in the success monad
catchEither :: forall e e' r. Either e r -> (e -> Either e' r) -> Either e' r
catchEither e f = runEitherR (EitherR e >>= (EitherR <<< f))

-- | `catchEither` with the arguments flipped
handleEither :: forall e e' r. (e -> Either e' r) -> Either e r -> Either e' r
handleEither = flip catchEither

-- | Map a function over the `Left` value of an `Either`
fmapL :: forall e e' r. (e -> e') -> Either e r -> Either e' r
fmapL f e = runEitherR (f <$> EitherR e)

-- | Flip the type variables of `Either`
flipEither :: forall a b. Either a b -> Either b a
flipEither e = case e of
    Left  a -> Right a
    Right b -> Left b

-- | `EitherR` converted into a monad transformer
newtype ExceptRT r m e = ExceptRT (ExceptT e m r)

runExceptRT :: forall e m r. ExceptRT r m e -> ExceptT e m r
runExceptRT (ExceptRT e) = e

instance functorExceptRT :: Monad m => Functor (ExceptRT r m) where
  map = liftM1

instance applyExceptRT :: Monad m => Apply (ExceptRT r m) where
  apply = ap

instance applicativeExceptRT :: Monad m => Applicative (ExceptRT r m) where
  pure e = ExceptRT (throwError e)

instance bindExceptRT :: Monad m => Bind (ExceptRT r m) where
  bind m f = ExceptRT <<< ExceptT $ do
    e <- runExceptT <<< runExceptRT $ m
    case e of
      Left l -> runExceptT <<< runExceptRT <<< f $ l
      Right r -> pure (Right r)

instance monadExceptRT :: Monad m => Monad (ExceptRT r m)

instance altExceptRT :: (Monoid r, Monad m) => Alt (ExceptRT r m) where
  alt e1 e2 = ExceptRT <<< ExceptT $ do
    e1' <- runExceptT <<< runExceptRT $ e1
    case e1' of
      Left l -> pure e1'
      Right r1 -> do
        e2' <- runExceptT <<< runExceptRT $ e2
        case e2' of
          Left l' -> pure e2'
          Right r2 -> pure (Right (r1 <> r2))

instance plusExceptRT :: (Monoid r, Monad m) => Plus (ExceptRT r m) where
  empty = ExceptRT $ pure mempty

instance alternativeExceptRT :: (Monoid r, Monad m) => Alternative (ExceptRT r m)

instance monadZeroExceptRT :: (Monoid r, Monad m) => MonadZero (ExceptRT r m)

instance monadPlusExceptRT :: (Monoid r, Monad m) => MonadPlus (ExceptRT r m)

instance monadTrans :: MonadTrans (ExceptRT r) where
  lift = ExceptRT <<< ExceptT <<< (Left <$> _)

instance monadEffExceptRT :: MonadEffect m => MonadEffect (ExceptRT r m) where
  liftEffect = lift <<< liftEffect

-- | Complete error handling, returning a result
succeedT :: forall e m r. Monad m => r -> ExceptRT r m e
succeedT r = ExceptRT (pure r)

-- | Modify `ExceptT` error value
-- | The same as `Control.Monad.Except.Trans.withExceptT`, but left
-- | here for module API consistency.
fmapLT :: forall e e' m r. Monad m => (e -> e') -> ExceptT e m r -> ExceptT e' m r
fmapLT f = runExceptRT <<< liftM1 f <<< ExceptRT

flipET :: forall a m r. Monad m => ExceptT a m r -> ExceptT r m a
flipET = ExceptT <<< liftM1 flipEither <<< runExceptT
