## Module Data.EitherR

This module provides `throwEither` and `cachEither` for Either. These
functions reside here because `throwEither` and `catchEither` correspond
to `return` and `bind` for flipped `Either` monad: `EitherR`.

`catchEither` differs from `MonadError` (`cacheError`) - `catchEither` is
more general as it allows you to change the left value's type.

`throwEither` is just `throwError` but exists here for consistency.

More advanced users can use `EitherR` and `ExceptRT` to program in an
entirely symmetric "success monad" where exceptional results are the norm
and successful results terminate the computation.  This allows you to chain
error-handlers using `do` notation and pass around exceptional values of
varying types until you can finally recover from the error:

    runExceptRT $ do
      e2   <- ioExceptionHandler e1
      bool <- arithmeticExceptionhandler e2
      when bool $ lift $ putStrLn "DEBUG: Arithmetic handler did something"

If any of the above error handlers 'succeed', no other handlers are tried.
If you choose not to typefully distinguish between the error and sucess
monad, then use `flipEither` and `flipET`, which swap the type variables without
changing the type.

#### `EitherR`

``` purescript
newtype EitherR r e
  = EitherR (Either e r)
```

If `Either e r` is the error monad, then `EitherR r e` is the
corresponding success monad, where:

  * `return` is `throwEither`.

  * `(>>=)` is `catchEither`.

  * Successful results abort the computation


##### Instances
``` purescript
Functor (EitherR r)
Apply (EitherR r)
Applicative (EitherR r)
Bind (EitherR r)
Monad (EitherR r)
(Monoid r) => Alt (EitherR r)
(Monoid r) => Plus (EitherR r)
(Monoid r) => Alternative (EitherR r)
(Monoid r) => MonadZero (EitherR r)
(Monoid r) => MonadPlus (EitherR r)
```

#### `runEitherR`

``` purescript
runEitherR :: forall e r. EitherR r e -> Either e r
```

#### `succeed`

``` purescript
succeed :: forall e r. r -> EitherR r e
```

Complete error handling, returning a result

#### `throwEither`

``` purescript
throwEither :: forall e r. e -> Either e r
```

`throwEither` in the error monad corresponds to `return` in the success monad

#### `catchEither`

``` purescript
catchEither :: forall e e' r. Either e r -> (e -> Either e' r) -> Either e' r
```

`catchEither` in the error monad corresponds to `(>>=)` in the success monad

#### `handleEither`

``` purescript
handleEither :: forall e e' r. (e -> Either e' r) -> Either e r -> Either e' r
```

`catchEither` with the arguments flipped

#### `fmapL`

``` purescript
fmapL :: forall e e' r. (e -> e') -> Either e r -> Either e' r
```

Map a function over the `Left` value of an `Either`

#### `flipEither`

``` purescript
flipEither :: forall a b. Either a b -> Either b a
```

Flip the type variables of `Either`

#### `ExceptRT`

``` purescript
newtype ExceptRT r m e
  = ExceptRT (ExceptT e m r)
```

`EitherR` converted into a monad transformer

##### Instances
``` purescript
(Monad m) => Functor (ExceptRT r m)
(Monad m) => Apply (ExceptRT r m)
(Monad m) => Applicative (ExceptRT r m)
(Monad m) => Bind (ExceptRT r m)
(Monad m) => Monad (ExceptRT r m)
(Monoid r, Monad m) => Alt (ExceptRT r m)
(Monoid r, Monad m) => Plus (ExceptRT r m)
(Monoid r, Monad m) => Alternative (ExceptRT r m)
(Monoid r, Monad m) => MonadZero (ExceptRT r m)
(Monoid r, Monad m) => MonadPlus (ExceptRT r m)
MonadTrans (ExceptRT r)
(MonadEff eff m) => MonadEff eff (ExceptRT r m)
```

#### `runExceptRT`

``` purescript
runExceptRT :: forall e m r. ExceptRT r m e -> ExceptT e m r
```

#### `succeedT`

``` purescript
succeedT :: forall e m r. Monad m => r -> ExceptRT r m e
```

Complete error handling, returning a result

#### `fmapLT`

``` purescript
fmapLT :: forall e e' m r. Monad m => (e -> e') -> ExceptT e m r -> ExceptT e' m r
```

Modify `ExceptT` error value
The same as `Control.Monad.Except.Trans.withExceptT`, but left
here for module API consistency.

#### `flipET`

``` purescript
flipET :: forall a m r. Monad m => ExceptT a m r -> ExceptT r m a
```


