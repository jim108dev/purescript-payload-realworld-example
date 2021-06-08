module Server.Shell.Persistence.Postgres.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Database.PostgreSQL as PG
import Effect (Effect)
import Server.Shared.Interface.Persistence (Handle)
import Server.Shared.Type.Misc (Pool(..))
import Server.Shell.Type.Misc (PersistenceConfig)

mkHandle :: PersistenceConfig -> Effect Handle
mkHandle config = do
  pool <- createPool config
  pure { pool: PostgresPool pool }

createPool :: PersistenceConfig -> Effect PG.Pool
createPool c = PG.new pgConfig
  where
  pgConfig =
    (PG.defaultConfiguration c.database)
      { host = Just c.hostname
      , user = Just c.user
      , port = Just 5432
      , password = Just c.password
      }
