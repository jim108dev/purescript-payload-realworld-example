module Server.User.Api.Type.UpdateDto where

import Prelude

import Data.Bifunctor (lmap)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Eq (genericEq)
import Data.Generic.Rep.Show (genericShow)
import Payload.Server.DecodeBody (class DecodeBody)
import Server.Shared.Api.Main (renderJsonErrors)
import Server.User.Type.Misc (Patch)
import Simple.JSON as SJ

newtype UpdateDto
  = UpdateDto { user :: Patch }

derive instance genericUpdateDto :: Generic UpdateDto _

instance showUpdateDto :: Show UpdateDto where
  show = genericShow

instance eqUpdateDto :: Eq UpdateDto where
  eq = genericEq

{-
instance decodeUpdateDto :: Decode UpdateDto where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance encodeUpdateDto :: Encode UpdateDto where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }
-}
derive newtype instance readForeignUpdateDto :: SJ.ReadForeign UpdateDto
derive newtype instance writeForeignUpdateDto :: SJ.WriteForeign UpdateDto

instance decodeBodyUpdateDto :: SJ.ReadForeign UpdateDto => DecodeBody UpdateDto where
  decodeBody = lmap renderJsonErrors <<< SJ.readJSON

wrapUpdateDto :: Patch -> UpdateDto
wrapUpdateDto x = UpdateDto { user: x }

unwrapUpdateDto :: UpdateDto -> Patch
unwrapUpdateDto (UpdateDto { user: x }) = x
