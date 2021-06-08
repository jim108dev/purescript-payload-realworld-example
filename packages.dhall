{-
Welcome to your new Dhall package-set!

Below are instructions for how to edit this file for most use
cases, so that you don't need to know Dhall to use it.

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
  with halogen-vdom.dependencies = [ "extra-dependency" ] # halogen-vdom.dependencies
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
      https://github.com/purescript/package-sets/releases/download/psc-0.14.1-20210516/packages.dhall sha256:f5e978371d4cdc4b916add9011021509c8d869f4c3f6d0d2694c0e03a85046c8

in  upstream
      with payload =
        { dependencies =
        [ "aff"
          , "affjax"
          , "console"
          , "effect"
          , "node-fs"
          , "node-fs-aff"
          , "node-http"
          , "prelude"
          , "record"
          , "simple-json"
          , "stringutils"
          , "test-unit"
          , "typelevel-prelude"
          ]
        , repo = "https://github.com/jim108dev/purescript-payload.git"
        , version = "master"
        }
    with postgresql-client =
      { dependencies =
        [ "aff"
        , "argonaut"
        , "arrays"
        , "assert"
        , "bifunctors"
        , "bytestrings"
        , "datetime"
        , "decimals"
        , "dotenv"
        , "effect"
        , "either"
        , "enums"
        , "exceptions"
        , "foldable-traversable"
        , "foreign"
        , "foreign-generic"
        , "foreign-object"
        , "identity"
        , "integers"
        , "js-date"
        , "lists"
        , "math"
        , "maybe"
        , "newtype"
        , "node-process"
        , "nullable"
        , "ordered-collections"
        , "partial"
        , "polyform"
        , "polyform-batteries-core"
        , "polyform-batteries-env"
        , "prelude"
        , "psci-support"
        , "string-parsers"
        , "strings"
        , "test-unit"
        , "transformers"
        , "tuples"
        , "typelevel-prelude"
        , "validation"
        ]
      , repo = "https://github.com/jordanmartinez/purescript-postgresql-client.git"
      , version = "updateTov0.14.1"
      }
    with polyform =
        { dependencies =
          [ "arrays"
          , "bifunctors"
          , "control"
          , "effect"
          , "either"
          , "enums"
          , "functors"
          , "identity"
          , "invariant"
          , "lists"
          , "maybe"
          , "newtype"
          , "parallel"
          , "partial"
          , "prelude"
          , "profunctor"
          , "psci-support"
          , "quickcheck"
          , "quickcheck-laws"
          , "record"
          , "transformers"
          , "tuples"
          , "typelevel-prelude"
          , "unsafe-coerce"
          , "validation"
          , "variant"
          ]
        , repo = "https://github.com/jordanmartinez/purescript-polyform.git"
        , version = "updateTov0.14.1"
        }
      with polyform-batteries-core =
        { dependencies =
          [ "arrays"
          , "decimals"
          , "effect"
          , "enums"
          , "integers"
          , "lazy"
          , "maybe"
          , "numbers"
          , "partial"
          , "polyform"
          , "prelude"
          , "psci-support"
          , "quickcheck"
          , "strings"
          , "test-unit"
          , "typelevel-prelude"
          , "validation"
          , "variant"
          ]
        , repo = "https://github.com/jordanmartinez/purescript-polyform-validators.git"
        , version = "updateTov0.14.1"
        }
      with polyform-batteries-env =
        { dependencies =
          [ "arrays"
          , "identity"
          , "maybe"
          , "ordered-collections"
          , "polyform"
          , "polyform-batteries-core"
          , "prelude"
          , "psci-support"
          , "typelevel-prelude"
          ]
        , repo = "https://github.com/jordanmartinez/batteries-env.git"
        , version = "updateTov0.14.1"
        }
      with selda =
        { dependencies =
        [ "aff"
        , "arrays"
        , "bifunctors"
        , "console"
        , "datetime"
        , "dodo-printer"
        , "dotenv"
        , "effect"
        , "either"
        , "enums"
        , "exceptions"
        , "exists"
        , "foldable-traversable"
        , "foreign"
        , "foreign-object"
        , "heterogeneous"
        , "leibniz"
        , "lists"
        , "maybe"
        , "newtype"
        , "node-process"
        , "node-sqlite3"
        , "ordered-collections"
        , "partial"
        , "polyform"
        , "polyform-batteries-core"
        , "polyform-batteries-env"
        , "postgresql-client"
        , "prelude"
        , "record"
        , "simple-json"
        , "strings"
        , "test-unit"
        , "transformers"
        , "tuples"
        , "typelevel-prelude"
        , "unsafe-coerce"
        , "validation"
        , "variant"
        ]
        , repo = "https://github.com/Kamirus/purescript-selda.git"
        , version = "master"
        }
      with node-jwt =
        { dependencies =
          [ "aff"
          , "aff-promise"
          , "console"
          , "effect"
          , "foreign-generic"
          , "newtype"
          , "psci-support"
          , "options"
          ]
        , repo = "https://github.com/jim108dev/purescript-node-jwt"
        , version = "master"
        }
      with simple-timestamp = 
        { dependencies =
        [ "console"
        , "datetime"
        , "effect"
        , "foreign"
        , "formatters"
        , "prelude"
        , "psci-support"
        , "simple-json"
        , "spec"
        ]
        , repo = "https://github.com/jim108dev/purescript-simple-timestamp"
        , version = "master"
        }