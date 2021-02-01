module Server.Shell.Persistence.Postgres where

import Prelude

import Database.Postgres (ClientConfig, connectionInfoFromConfig, defaultPoolConfig, mkPool)
import Database.Postgres (Pool) as Postgres
import Effect (Effect)
import Server.Shared.Interface.Persistence (Handle)
import Server.Shared.Type.Misc (Pool(..))
import Server.Shell.Type.Misc (Config)

mkHandle :: Config -> Effect Handle
mkHandle config = do
  pool <- createPool config
  pure { pool: PostgresPool pool }

createPool :: Config -> Effect Postgres.Pool
createPool c = mkPool $ connectionInfoFromConfig clientConfig defaultPoolConfig
  where
  clientConfig :: ClientConfig
  clientConfig =
    { host: c.persistence.hostname
    , port: 5432
    , database: c.persistence.database
    , user: c.persistence.user
    , password: c.persistence.password
    , ssl: false
    }

