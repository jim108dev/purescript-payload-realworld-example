module Test.Server.Shell.Interface.Api where

import Data.Maybe (Maybe)
import Data.Unit (Unit)
import Effect.Aff (Aff)
import Test.Server.Shell.Util.Payload (ApiResponse)

type Call
  = String -> Maybe String -> Maybe String -> Aff ApiResponse

type Handle
  = { withApi :: Aff Unit -> Aff Unit
    , get :: Call
    , post :: Call
    , put :: Call
    , delete :: Call
    }
