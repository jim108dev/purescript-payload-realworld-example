{-
Welcome to your new Dhall package-set!

Below are instructions for how to edit this file for most use
cases, so that you don't need to know Dhall to use it.

## Warning: Don't Move This Top-Level Comment!

Due to how `dhall format` currently works, this comment's
instructions cannot appear near corresponding sections below
because `dhall format` will delete the comment. However,
it will not delete a top-level comment like this one.

## Use Cases

Most will want to do one or both of these options:
1. Override/Patch a package's dependency
2. Add a package not already in the default package set

This file will continue to work whether you use one or both options.
Instructions for each option are explained below.

### Overriding/Patching a package

Purpose:
- Change a package's dependency to a newer/older release than the
    default package set's release
- Use your own modified version of some dependency that may
    include new API, changed API, removed API by
    using your custom git repo of the library rather than
    the package set's repo

Syntax:
where `entityName` is one of the following:
- dependencies
- repo
- version
-------------------------------
let upstream = --
in  upstream
  with packageName.entityName = "new value"
-------------------------------

Example:
-------------------------------
let upstream = --
in  upstream
  with halogen.version = "master"
  with halogen.repo = "https://example.com/path/to/git/repo.git"

  with halogen-vdom.version = "v4.0.0"
-------------------------------

### Additions

Purpose:
- Add packages that aren't already included in the default package set

Syntax:
where `<version>` is:
- a tag (i.e. "v4.0.0")
- a branch (i.e. "master")
- commit hash (i.e. "701f3e44aafb1a6459281714858fadf2c4c2a977")
-------------------------------
let upstream = --
in  upstream
  with new-package-name =
    { dependencies =
       [ "dependency1"
       , "dependency2"
       ]
    , repo =
       "https://example.com/path/to/git/repo.git"
    , version =
        "<version>"
    }
-------------------------------

Example:
-------------------------------
let upstream = --
in  upstream
  with benchotron =
      { dependencies =
          [ "arrays"
          , "exists"
          , "profunctor"
          , "strings"
          , "quickcheck"
          , "lcg"
          , "transformers"
          , "foldable-traversable"
          , "exceptions"
          , "node-fs"
          , "node-buffer"
          , "node-readline"
          , "datetime"
          , "now"
          ]
      , repo =
          "https://github.com/hdgarrood/purescript-benchotron.git"
      , version =
          "v7.0.0"
      }
-------------------------------
-}

let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20210118/packages.dhall sha256:a59c5c93a68d5d066f3815a89f398bcf00e130a51cb185b2da29b20e2d8ae115

let additions =
      { payload =
        { dependencies =
          [ "aff"
          , "affjax"
          , "console"
          , "debug"
          , "effect"
          , "foreign-generic"
          , "node-fs"
          , "node-fs-aff"
          , "node-http"
          , "prelude"
          , "psci-support"
          , "record"
          , "simple-json"
          , "stringutils"
          , "test-unit"
          , "typelevel-prelude"
          ]
        , repo = "https://github.com/jim108dev/purescript-payload.git"
        , version = "master"
        },
        postgresql-client =
        { dependencies =
          [ "aff"
          , "argonaut"
          , "arrays"
          , "assert"
          , "bifunctors"
          , "bytestrings"
          , "console"
          , "datetime"
          , "decimals"
          , "effect"
          , "either"
          , "exceptions"
          , "foldable-traversable"
          , "foreign"
          , "foreign-generic"
          , "foreign-object"
          , "js-date"
          , "lists"
          , "maybe"
          , "newtype"
          , "nullable"
          , "prelude"
          , "psci-support"
          , "string-parsers"
          , "test-unit"
          , "transformers"
          , "tuples"
          ]
        , repo = "https://github.com/rightfold/purescript-postgresql-client.git"
        , version = "v3.0.3"
        },
        prettyprinter = 
        { dependencies = 
            [ "prelude"
            , "unfoldable"
            , "random"
            , "ansi"
            , "console"
            ]
        , repo =
            "https://github.com/Kamirus/purescript-prettyprinter.git"
        , version = 
            "master"
        },
        selda =
        { dependencies =
          [ "console"
          , "exists"
          , "heterogeneous"
          , "lists"
          , "node-sqlite3"
          , "postgresql-client"
          , "prelude"
          , "simple-json"
          , "strings"
          , "test-unit"
          , "transformers"
          , "variant"
          , "prettyprinter"
          ]
        , repo = "https://github.com/Kamirus/purescript-selda.git"
        , version = "master"
        },
        node-jwt =
        { dependencies =
          [ "aff"
          , "aff-promise"
          , "console"
          , "effect"
          , "foreign-generic"
          , "generics-rep"
          , "newtype"
          , "psci-support"
          , "options"
          ]
          , repo = "https://github.com/gaku-sei/purescript-node-jwt"
          , version = "master"
        }
      }
in      upstream
    //  additions
