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
  , "node-jwt"
  , "payload"
  , "point-free"
  , "psci-support"
  , "selda"
  , "simple-json"
  , "simple-timestamp"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
