# purescript-errors

[![Greenkeeper badge](https://badges.greenkeeper.io/passy/purescript-errors.svg)](https://greenkeeper.io/)

[![Latest release](http://img.shields.io/bower/v/purescript-errors.svg)](https://github.com/passy/purescript-errors/releases)
[ ![Codeship Status for passy/purescript-errors](https://codeship.com/projects/faffa470-1a22-0134-7c85-56774cd00e66/status?branch=master)](https://codeship.com/projects/159258)
[![Build Status](https://travis-ci.org/passy/purescript-errors.svg?branch=master)](https://travis-ci.org/passy/purescript-errors)

> A partial port of Gabriel Gonzalez' [errors
> library](https://github.com/Gabriel439/Haskell-Errors-Library) for Haskell.

- Module documentation:
    - [Control.Error.Util](docs/Control/Error/Util.md)
    - [Data.EitherR](docs/Data/EitherR.md)
- [Pursuit](http://pursuit.purescript.org/packages/purescript-errors)

## About that "partial"

`Control.Error.Safe` has not been ported since `purescript-lists` and
`purescript-arrays` provide safe alternatives by default. `Control.Error.Script`
relies on platform-specific features not available in PureScript.

## License

[Apache-2](LICENSE)
