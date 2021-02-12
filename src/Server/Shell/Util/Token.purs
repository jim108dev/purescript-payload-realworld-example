module Server.Shell.Util.Token where

import Prelude

import Control.Error.Util (hush)
import Data.DateTime (DateTime, adjust, modifyTime, setMillisecond)
import Data.DateTime.Instant (toDateTime)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Newtype (unwrap, wrap)
import Data.Time.Duration as Duration
import Effect.Aff (Aff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Now (now)
import Node.Jwt as JWT
import Server.Shared.Interface.Token (Handle)
import Server.Shell.Type.Misc (TokenConfig)
import Shared.Type.Misc (Token, UserId, Secret)
import Timestamp (Timestamp)

mkHandle :: TokenConfig -> Handle
mkHandle { secret, timestamp } =
  { encode: encode secret timestamp
  , decode: pure <<< decode secret
  }

type UnregisteredClaimsRow
  = ( id :: UserId
    )

type UnregisteredClaims
  = Record UnregisteredClaimsRow

mkUnregisteredClaims :: UserId -> UnregisteredClaims
mkUnregisteredClaims id = { id }

decode :: Secret -> Token -> Maybe UserId
decode secret token =
  let
    decodedToken = getVerifiedToken secret token

    unregisteredClaims = decodedToken <#> _.claims >>> _.unregisteredClaims
  in
    case unregisteredClaims of
      Nothing -> Nothing
      Just v1 -> case v1 of
        Nothing -> Nothing
        Just { id } -> Just id

getVerifiedToken :: Secret -> String -> Maybe (JWT.Token UnregisteredClaimsRow JWT.Verified)
getVerifiedToken secret token = hush $ JWT.verify (JWT.Secret secret) token

unsafeAdjust :: DateTime -> DateTime
unsafeAdjust = fromMaybe bottom <<< adjust (Duration.Hours 1.0)

getTimestamp :: forall m. MonadEffect m => m DateTime
getTimestamp = liftEffect $ modifyTime (setMillisecond bottom) <<< toDateTime <$> now

encode :: Secret -> Maybe Timestamp -> UserId -> Aff Token
encode secret mTimestamp userId = do
  timestamp <- case mTimestamp of
    Nothing -> getTimestamp
    Just value -> pure $ unwrap value
  expirationTime <- pure $ unsafeAdjust timestamp
  let
    claims =
      JWT.defaultClaims
        { exp = Just $ wrap expirationTime
        , iat = Just $ wrap timestamp
        , unregisteredClaims = Just $ mkUnregisteredClaims userId
        }
  token <- JWT.sign (JWT.Secret secret) JWT.defaultHeaders claims
  pure token
