## Module Control.Error.Util

Use these functions to convert between `Maybe`, `Either`, `MaybeT`, and
`ExceptT`.

#### `hush`

``` purescript
hush :: forall a b. Either a b -> Maybe b
```

Suppress the `Left` value of an `Either`

#### `hushT`

``` purescript
hushT :: forall a b m. Monad m => ExceptT a m b -> MaybeT m b
```

Suppress the `Left` value of an `ExceptT`

#### `note`

``` purescript
note :: forall a b. a -> Maybe b -> Either a b
```

Tag the `Nothing` value of a `Maybe`

#### `noteT`

``` purescript
noteT :: forall a b m. Monad m => a -> MaybeT m b -> ExceptT a m b
```

Tag the `Nothing` value of a `MaybeT`

#### `hoistMaybe`

``` purescript
hoistMaybe :: forall b m. Monad m => Maybe b -> MaybeT m b
```

Lift a `Maybe` to the `MaybeT` monad

#### `exceptNoteM`

``` purescript
exceptNoteM :: forall a e m. Applicative m => Maybe a -> e -> ExceptT e m a
```

Convert a `Maybe` value into the `ExceptT` monad

#### `(??)`

``` purescript
infixl 9 exceptNoteM as ??
```

#### `exceptNoteA`

``` purescript
exceptNoteA :: forall a e m. Apply m => m (Maybe a) -> e -> ExceptT e m a
```

Convert an applicative `Maybe` value into the `ExceptT` monad

#### `(!?)`

``` purescript
infixl 9 exceptNoteA as !?
```

#### `bool`

``` purescript
bool :: forall a. a -> a -> Boolean -> a
```

Case analysis for the `Boolean` type

#### `fromMaybe'`

``` purescript
fromMaybe' :: forall a. Maybe a -> a -> a
```

An infix form of `fromMaybe` with arguments flipped.

#### `(?:)`

``` purescript
infixl 9 fromMaybe' as ?:
```


