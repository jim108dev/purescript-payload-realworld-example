module Server.Shell.Main where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import Payload.Server as Payload
import Server.Shell.Api.Interface.Spec (spec) as Api
import Server.Shell.Api.Main (mkHandle) as Api
import Server.Shell.Type.LogLevel as Log
import Server.Shell.Type.Misc (Config)
import Server.Shell.Util.Aggregate (mkHandle) as Aggregate

mkServerOpts :: Config -> Payload.Options
mkServerOpts config =
  { backlog: Nothing
  , hostname: config.server.hostname
  , port: config.server.port
  , logLevel: ll config.server.logLevel
  }
  where
  ll :: Log.LogLevel -> Payload.LogLevel
  ll Log.Debug = Payload.LogDebug
  ll Log.Silent = Payload.LogSilent
  ll Log.Error = Payload.LogError
  ll Log.Normal = Payload.LogNormal

runServer :: Config -> Effect Unit
runServer c = do
  let
    serverOpts = mkServerOpts c
  h <- Aggregate.mkHandle c
  launchAff_ do
    result <- Payload.startGuarded serverOpts Api.spec $ Api.mkHandle h
    case result of
      Left e -> log e
      Right _ -> pure unit
