module Server.Article.Api.Type.UpdateDto where

import Prelude

import Data.Bifunctor (lmap)
import Data.Eq.Generic (genericEq)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Payload.Server.DecodeBody (class DecodeBody)
import Server.Article.Type.Misc (Patch)
import Server.Shared.Api.Main (renderJsonErrors)
import Simple.JSON as SJ

newtype UpdateDto
  = UpdateDto { article :: Patch }

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
wrapUpdateDto x = UpdateDto { article: x }

unwrapUpdateDto :: UpdateDto -> Patch
unwrapUpdateDto (UpdateDto { article: x }) = x
