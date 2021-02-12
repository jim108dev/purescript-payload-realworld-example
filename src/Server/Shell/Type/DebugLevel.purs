module Server.Shell.Type.LogLevel where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Server.Shared.Util.Json (enumReadForeign)
import Simple.JSON as JSON

data LogLevel
  = Debug
  | Silent
  | Error
  | Normal

derive instance genericLogLevel :: Generic LogLevel _

instance logLevelReadForeign :: JSON.ReadForeign LogLevel where
  readImpl = enumReadForeign

instance logLevelShow :: Show LogLevel where
  show = genericShow

