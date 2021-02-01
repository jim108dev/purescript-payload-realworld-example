module Data.TacitString
  ( TacitString
  , hush
  ) where

import Prelude
import Data.Newtype (class Newtype)

newtype TacitString = TacitString String

derive instance newtypeTacitString :: Newtype TacitString _
derive instance eqTacitString :: Eq TacitString
derive instance ordTacitString :: Ord TacitString

instance showTacitString :: Show TacitString where
  show (TacitString str) = str

hush :: String -> TacitString
hush = TacitString
