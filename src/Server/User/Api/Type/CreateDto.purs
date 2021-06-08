module Server.User.Api.Type.CreateDto where

import Prelude

import Data.Bifunctor (lmap)
import Data.Eq.Generic (genericEq)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Foreign.Class (class Decode, class Encode)
import Foreign.Generic (defaultOptions, genericDecode, genericEncode)
import Payload.Server.DecodeBody (class DecodeBody)
import Server.Shared.Api.Main (renderJsonErrors)
import Server.User.Type.Misc (Raw)
import Simple.JSON as SJ

newtype CreateDto
  = CreateDto { user :: Raw }

derive instance genericCreateDto :: Generic CreateDto _

instance showCreateDto :: Show CreateDto where
  show = genericShow

instance eqCreateDto :: Eq CreateDto where
  eq = genericEq

instance decodeCreateDto :: Decode CreateDto where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance encodeCreateDto :: Encode CreateDto where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }

derive newtype instance readForeignCreateDto :: SJ.ReadForeign CreateDto

derive newtype instance writeForeignCreateDto :: SJ.WriteForeign CreateDto

instance decodeBodyCreateDto :: SJ.ReadForeign CreateDto => DecodeBody CreateDto where
  decodeBody = lmap renderJsonErrors <<< SJ.readJSON

wrapCreateDto :: Raw -> CreateDto
wrapCreateDto x = CreateDto { user: x }

unwrapCreateDto :: CreateDto -> Raw
unwrapCreateDto (CreateDto { user: x }) = x
