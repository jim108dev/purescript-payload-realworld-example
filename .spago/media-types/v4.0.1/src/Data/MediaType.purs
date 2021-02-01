module Data.MediaType where

import Prelude

import Data.Newtype (class Newtype)

newtype MediaType = MediaType String

derive instance newtypeMediaType :: Newtype MediaType _
derive instance eqMediaType :: Eq MediaType
derive instance ordMediaType :: Ord MediaType

instance showMediaType :: Show MediaType where
  show (MediaType h) = "(MediaType " <> show h <> ")"
