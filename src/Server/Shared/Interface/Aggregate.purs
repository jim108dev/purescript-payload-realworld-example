module Server.Shared.Interface.Aggregate where

import Server.Shared.Interface.Persistence as Persistence
import Server.Shared.Interface.Token as Token

type Handle
  = { persistence :: Persistence.Handle
    , token :: Token.Handle
    }

