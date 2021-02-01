module Server.Shell.Api.Guards where

import Prelude
import Control.Error.Util (note)
import Control.Monad.Maybe.Trans (MaybeT(..), runMaybeT)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), Replacement(..), replace)
import Effect.Aff (Aff)
import Node.HTTP (Request)
import Payload.Headers as Headers
import Payload.ResponseTypes (Response)
import Payload.Server.Guards as Payload
import Payload.Server.Response (unauthorized)
import Server.Shared.Api.Main (renderErrorMessage)
import Server.Shared.Api.Type.Misc (Origin)
import Server.Shared.Interface.Token (Handle)
import Shared.Type.Misc (UserId)

mkHandle ::
  Handle ->
  { maybeUserId :: Request -> Aff (Either (Response String) (Maybe UserId))
  , userId :: Request -> Aff (Either (Response String) UserId)
  , origin :: Request -> Aff (Either (Response String) Origin)
  }
mkHandle h =
  { userId: authUser h
  , maybeUserId: maybeAuthUser h
  , origin: authOrigin
  }

maybeAuthUser :: Handle -> Request -> Aff (Either (Response String) (Maybe UserId))
maybeAuthUser h req =
  authUser h req
    >>= case _ of
        Left _ -> pure $ Right Nothing
        Right u -> pure $ Right $ Just u

authUser :: Handle -> Request -> Aff (Either (Response String) UserId)
authUser h req =
  runMaybeT do
    str <- MaybeT $ Headers.lookup "authorization" <$> Payload.headers req
    inter <- MaybeT $ pure $ Just $ replace (Pattern "Bearer ") (Replacement "") str
    token <- MaybeT $ pure $ Just $ replace (Pattern "Token ") (Replacement "") inter
    id <- MaybeT $ h.decode token
    pure id
    <#> note (unauthorized $ renderErrorMessage "Invalid token")

authOrigin :: Request -> Aff (Either (Response String) Origin)
authOrigin req =
  (Headers.lookup "origin" <$> Payload.headers req)
    <#> note (unauthorized $ renderErrorMessage "Origin missing")
