module Server.User.Interface.Persistence where

import Data.Either (Either)
import Effect.Aff (Aff)
import Server.User.Type.Misc (Credentials, InputError, Patch, Raw, User)
import Shared.Type.Misc (Username, UserId)

type Handle
  = { findByCredentials :: Credentials -> Aff (Either InputError User)
    , findByUsername :: Username -> Aff (Either InputError User)
    , findById :: UserId -> Aff (Either InputError User)
    , insert :: Raw -> Aff (Either InputError User)
    , update :: Patch -> UserId -> Aff (Either InputError User)
    , delete :: UserId -> Aff (Either InputError User)
    }
