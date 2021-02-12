module Server.Shell.Type.PersistenceImpl where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Server.Shared.Util.Json (enumReadForeign)
import Simple.JSON as JSON

data PersistenceImpl
  = Postgres

derive instance genericPersistenceImpl :: Generic PersistenceImpl _

instance persistenceImplReadForeign :: JSON.ReadForeign PersistenceImpl where
  readImpl = enumReadForeign

instance persistenceImplShow :: Show PersistenceImpl where
  show = genericShow

