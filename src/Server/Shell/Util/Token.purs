module Server.Shell.Util.Token where

import Prelude
import Control.Error.Util (hush)
import Data.Maybe (Maybe)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Node.Simple.Jwt as Jwt
import Server.Shared.Interface.Token (Handle)
import Shared.Type.Misc (Token, UserId, Secret)

mkHandle :: Secret -> Handle
mkHandle secret =
  { encode: encode secret
  , decode: decode secret
  }

encode :: Secret -> UserId -> Aff Token
encode secret userId = liftEffect $ Jwt.toString <$> Jwt.encode secret Jwt.HS256 userId

decode :: Secret -> Token -> Aff (Maybe UserId)
decode secret token = liftEffect $ hush <$> (Jwt.decode secret $ Jwt.fromString token)

