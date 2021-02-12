module Server.Shell.Util.Aggregate where

import Prelude

import Effect (Effect)
import Server.Shared.Interface.Aggregate (Handle)
import Server.Shell.Persistence.Postgres.Main as Postgres
import Server.Shell.Type.Misc (Config)
import Server.Shell.Type.PersistenceImpl (PersistenceImpl(..)) as PI
import Server.Shell.Util.Token as Token

mkHandle :: Config -> Effect Handle
mkHandle config = do
  persistence <- case config.persistence.impl of
    PI.Postgres -> Postgres.mkHandle config.persistence
  pure
    { persistence
    , token: Token.mkHandle config.token
    }
