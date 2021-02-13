module Server.Main where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Server.Shell.Main (runServer)
import Server.Shell.Util.Config (readOrThrow)

main :: Effect Unit
main =
  launchAff_ do
    config <- readOrThrow "./config/Server/Dev.json"
    --config <- readOrThrow "./config/Server/Prod.json"
    liftEffect do runServer config
