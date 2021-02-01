module Server.Shared.Api.Headers where

import Data.Tuple (Tuple(..))
import Payload.Headers as P
import Server.Shared.Api.Type.Misc (Origin)

baseHeaders :: Origin -> P.Headers
baseHeaders origin =
  P.fromFoldable
    [ Tuple "Access-Control-Allow-Origin" origin
    , Tuple "Access-Control-Allow-Methods" "GET, OPTIONS, POST, PUT, DELETE"
    , Tuple "Access-Control-Allow-Headers" "Content-Type,Authorization,X-Requested-With"
    ]
