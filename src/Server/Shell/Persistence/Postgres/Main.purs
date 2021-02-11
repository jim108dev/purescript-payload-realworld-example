module Server.Shell.Persistence.Postgres.Main where

import Prelude
import Data.Maybe (Maybe(..))
import Database.PostgreSQL as PG
import Effect (Effect)
import Server.Shared.Interface.Persistence (Handle)
import Server.Shared.Type.Misc (Pool(..))
import Server.Shell.Type.Misc (Config)

mkHandle :: Config -> Effect Handle
mkHandle config = do
  pool <- createPool config
  pure { pool: PostgresPool pool }

createPool :: Config -> Effect PG.Pool
createPool c = PG.newPool pgConfig
  where
  pgConfig :: PG.PoolConfiguration
  pgConfig =
    (PG.defaultPoolConfiguration c.persistence.database)
      { host = Just c.persistence.hostname
      , user = Just c.persistence.user
      , port = Just 5432
      , password = Just c.persistence.password
      }
