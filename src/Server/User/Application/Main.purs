module Server.User.Application.Main where

import Prelude

import Control.Monad.Except (ExceptT(..), runExceptT)
import Effect.Aff (Aff)
import Server.User.Interface.Persistence (Handle)
import Server.User.Type.Misc (Patch, Result, mkRawFromPatch)
import Shared.Type.Misc (UserId)

update :: Handle -> Patch -> UserId -> Aff Result
update h patch id =
  runExceptT do
    fallback <- ExceptT $ h.findById id
    ExceptT $ h.update (mkRawFromPatch fallback patch) id
