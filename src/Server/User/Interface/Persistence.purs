module Server.User.Interface.Persistence where

import Effect.Aff (Aff)
import Server.User.Type.Misc (Credentials, Raw, Result, User)
import Shared.Type.Misc (Username, UserId)

type Handle
  = { findByCredentials :: Credentials -> Aff Result
    , findByUsername :: Username -> Aff Result
    , findById :: UserId -> Aff Result
    , insert :: Raw -> Aff Result
    , update :: Raw -> UserId -> Aff Result
    , delete :: UserId -> Aff Result
    }
