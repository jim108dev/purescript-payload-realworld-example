module Server.User.Api.Type.LoginDto where

import Prelude
import Data.Bifunctor (lmap)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Show (genericShow)
import Foreign.Class (class Decode, class Encode)
import Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Payload.Server.DecodeBody (class DecodeBody)
import Server.Shared.Api.Main (renderJsonErrors)
import Server.User.Type.Misc (Credentials)
import Simple.JSON as SJ

newtype LoginDto
  = LoginDto { user :: Credentials }

derive instance genericLoginDto :: Generic LoginDto _

instance showLoginDto :: Show LoginDto where
  show = genericShow

instance eqLoginDto :: Eq LoginDto where
  eq = genericEq

instance decodeLoginDto :: Decode LoginDto where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance encodeLoginDto :: Encode LoginDto where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

derive newtype instance readForeignLoginDto :: SJ.ReadForeign LoginDto
derive newtype instance writeForeignLoginDto :: SJ.WriteForeign LoginDto

instance decodeBodyLoginDto :: SJ.ReadForeign LoginDto => DecodeBody LoginDto where
  decodeBody = lmap renderJsonErrors <<< SJ.readJSON

wrapLoginDto :: Credentials -> LoginDto
wrapLoginDto x = LoginDto { user: x }

unwrapLoginDto :: LoginDto -> Credentials
unwrapLoginDto (LoginDto { user: x }) = x
