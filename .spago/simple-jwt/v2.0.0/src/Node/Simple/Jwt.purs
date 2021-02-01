module Node.Simple.Jwt
  ( Secret
  , Jwt
  , Algorithm(..)
  , JwtError(..)
  , fromString
  , toString
  , decode
  , encode
  ) where

import Prelude

import Data.Array (replicate)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), joinWith, length, split)
import Data.String.Regex (replace)
import Data.String.Regex.Flags (global)
import Data.String.Regex.Unsafe (unsafeRegex)
import Effect (Effect)
import Node.Buffer (Buffer)
import Node.Buffer as Buffer
import Node.Crypto.Hash as Hash
import Node.Crypto.Hmac as Hmac
import Node.Encoding (Encoding(..))
import Simple.JSON (class ReadForeign, class WriteForeign, readJSON, writeJSON)

type Secret = String

-- | The type of JSON Web Token.
newtype Jwt = Jwt String

derive newtype instance showJwt :: Show Jwt
derive newtype instance eqJwt :: Eq Jwt
derive newtype instance readForeignJwt :: ReadForeign Jwt
derive newtype instance writeForeignJwt :: WriteForeign Jwt

-- | Supported algorithms.
data Algorithm
  = HS256
  | HS512

instance showAlgorithm :: Show Algorithm where
  show HS256 = "HS256"
  show HS512 = "HS512"

derive instance eqAlgorithm :: Eq Algorithm

-- | Errors for decoding.
data JwtError
  = InvalidTokenError
  | NotSupportedAlgorithmError
  | DecodeError
  | VerifyError

instance showJwtError :: Show JwtError where
  show InvalidTokenError = "InvalidTokenError"
  show NotSupportedAlgorithmError = "NotSupportedAlgorithmError"
  show DecodeError = "DecodeError"
  show VerifyError = "VerifyError"

derive instance eqJwtError :: Eq JwtError

-- | Convert a `String` to a `Jwt`.
fromString :: String -> Jwt
fromString = Jwt

-- | Convert a `Jwt` to a `String`.
toString :: Jwt -> String
toString (Jwt x) = x

-- | Decode JWT with signature verification.
decode :: forall payload. ReadForeign payload => Secret -> Jwt -> Effect (Either JwtError payload)
decode secret (Jwt jwt) =
  case split (Pattern ".") jwt of
    [headerSegment, payloadSegment, signatureSegment] -> do
       algOrErr <- readAlgorithm headerSegment
       case algOrErr of
         Left err -> pure $ Left err
         Right alg -> do
           isValid <- verify secret alg (headerSegment <> "." <> payloadSegment) signatureSegment
           if isValid
             then readPayload payloadSegment
             else pure $ Left VerifyError
    _ -> pure $ Left InvalidTokenError

verify :: Secret -> Algorithm -> String -> String -> Effect Boolean
verify secret alg input signatureSegment = do
  signatureSegment' <- sign secret alg input
  pure $ signatureSegment == signatureSegment'

readPayload :: forall payload. ReadForeign payload => String -> Effect (Either JwtError payload)
readPayload payloadSegment = do
  payload <- readJSON <$> base64URLDecode payloadSegment
  case payload of
    Left _ -> pure $ Left DecodeError
    Right payload' -> pure $ Right payload'

readAlgorithm :: String -> Effect (Either JwtError Algorithm)
readAlgorithm headerSegment = do
  header <- readJSON <$> base64URLDecode headerSegment
  case header of
    Left _ -> pure $ Left DecodeError
    Right ({ alg } :: { alg :: String }) ->
      case algorithmFromString alg of
        Nothing -> pure $ Left NotSupportedAlgorithmError
        Just alg' -> pure $ Right alg'

algorithmFromString :: String -> Maybe Algorithm
algorithmFromString alg
  | alg == show HS256 = Just HS256
  | alg == show HS512 = Just HS512
  | otherwise = Nothing

base64URLDecode :: String -> Effect String
base64URLDecode x =
  (Buffer.fromString (unescape x) Base64 :: Effect Buffer) >>= Buffer.toString UTF8

unescape :: String -> String
unescape x =
  rep $ x <> (joinWith "=" $ replicate n "")
  where
    n = 5 - (length x) `mod` 4
    rep =
      replace (unsafeRegex "\\-" global) "+"
        >>> replace (unsafeRegex "_" global) "/"

-- | Encode to JWT.
encode :: forall payload. WriteForeign payload => Secret -> Algorithm -> payload -> Effect Jwt
encode secret alg payload = do
  headerSegment <- base64URLEncode $ writeJSON { typ: "JWT", alg: show alg }
  payloadSegment <- base64URLEncode $ writeJSON payload
  signatureSegment <- sign secret alg $ headerSegment <> "." <> payloadSegment
  pure $ Jwt $ headerSegment <> "." <> payloadSegment <> "." <> signatureSegment

sign :: Secret -> Algorithm -> String -> Effect String
sign secret alg input =
  escape <$> Hmac.base64 (convertAlgorithm alg) secret input

base64URLEncode :: String -> Effect String
base64URLEncode x =
  escape <$> ((Buffer.fromString x UTF8 :: Effect Buffer) >>= Buffer.toString Base64)

escape :: String -> String
escape =
  replace (unsafeRegex "\\+" global) "-"
    >>> replace (unsafeRegex "\\/" global) "_"
    >>> replace (unsafeRegex "=" global) ""

convertAlgorithm :: Algorithm -> Hash.Algorithm
convertAlgorithm HS256 = Hash.SHA256
convertAlgorithm HS512 = Hash.SHA512
