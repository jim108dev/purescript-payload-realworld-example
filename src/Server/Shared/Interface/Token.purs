module Server.Shared.Interface.Token where

import Data.Maybe (Maybe)
import Effect.Aff (Aff)
import Shared.Type.Misc (UserId, Token)

type Handle
  = { encode :: UserId -> Aff Token
    , decode :: Token -> Aff (Maybe UserId)
    }

