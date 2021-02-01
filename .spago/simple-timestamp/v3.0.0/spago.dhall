{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
, name =
    "my-project"
, dependencies =
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
, packages =
    ./packages.dhall
, license = "MIT"
, repository = "git@github.com:reactormonk/purescript-simple-timestamp.git"
}
