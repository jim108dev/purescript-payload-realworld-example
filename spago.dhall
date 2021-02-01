{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
  [ "argonaut"
  , "console"
  , "effect"
  , "errors"
  , "node-postgres"
  , "payload"
  , "point-free"
  , "psci-support"
  , "simple-json"
  , "simple-jwt"
  , "simple-timestamp"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
