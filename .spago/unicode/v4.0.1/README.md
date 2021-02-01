# purescript-unicode

[![Latest release](http://img.shields.io/github/release/purescript-contrib/purescript-unicode.svg)](https://github.com/purescript-contrib/purescript-unicode/releases)
[![Build status](https://travis-ci.org/purescript-contrib/purescript-unicode.svg?branch=master)](https://travis-ci.org/purescript-contrib/purescript-unicode)
[![Pursuit](http://pursuit.purescript.org/packages/purescript-unicode/badge)](http://pursuit.purescript.org/packages/purescript-unicode/)
[![Maintainer: cdepillabout](https://img.shields.io/badge/maintainer-cdepillabout-lightgrey.svg)](http://github.com/cdepillabout)

Unicode character functions.

## Installation

```sh
$ bower install purescript-unicode
```

## Module documentation

- [Data.Char.Unicode](docs/Data/Char/Unicode.md)

## Generate Internal module

The [Data.Char.Unicode.Internal](src/Data/Char/Unicode/Internal.purs) module
can be generated with the following command:

```sh
$ wget 'http://www.unicode.org/Public/6.0.0/ucd/UnicodeData.txt'
$ ./ubconfc < UnicodeData.txt > src/Data/Char/Unicode/Internal.purs
```

## Contributing

Read the [contribution guidelines](https://github.com/purescript-contrib/purescript-unicode/blob/master/.github/contributing.md) to get started and see helpful related resources.
