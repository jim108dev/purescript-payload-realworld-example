# purescript-form-urlencoded

[![Latest release](http://img.shields.io/github/release/purescript-contrib/purescript-form-urlencoded.svg)](https://github.com/purescript-contrib/purescript-form-urlencoded/releases)
[![Build status](https://travis-ci.org/purescript-contrib/purescript-form-urlencoded.svg?branch=master)](https://travis-ci.org/purescript-contrib/purescript-form-urlencoded)
[![Pursuit](http://pursuit.purescript.org/packages/purescript-form-urlencoded/badge)](http://pursuit.purescript.org/packages/purescript-form-urlencoded/)
[![Maintainer: zudov](https://img.shields.io/badge/maintainer-zudov-lightgrey.svg)](https://github.com/zudov)
[![Maintainer: thomashoneyman](https://img.shields.io/badge/maintainer-thomashoneyman-lightgrey.svg)](https://github.com/thomashoneyman)

A `FormURLEncoded` datatype represents an ordered list of key-value pairs
with possible duplicates. `encode` function allows to transform `FormURLEncoded`
into a `Maybe String` according to `application/x-www-form-urlencoded`.
`decode` function transforms a string into a `Maybe FormURLEncoded` structure.

Documentation is available on [Pursuit][Pursuit].

[Pursuit]: https://pursuit.purescript.org/packages/purescript-form-urlencoded

Example:

```haskell
> import Data.FormURLEncoded (fromArray, encode)
> import Data.Maybe (Maybe(..))
> import Data.Tuple (Tuple(..))

> encode (fromArray [ Tuple "hey" Nothing
>                   , Tuple "Oh" (Just "Let's go!")
>                   ])
Just "hey&Oh=Let's%20go!"

> decode "a=aa&b=bb"
Just (FormURLEncoded [(Tuple "a" (Just "aa")),(Tuple "b" (Just "bb"))])
```

## Contributing

Read the [contribution guidelines](https://github.com/purescript-contrib/purescript-form-urlencoded/blob/master/.github/contributing.md) to get started and see helpful related resources.
