module Shared.Util.Maybe where

import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe)

-- | Converts defined, `Just a` to `Just a`, anything else to `Nothing`. 
fromMaybeNullable :: forall a. Maybe a -> Maybe (Nullable a) -> Maybe a
fromMaybeNullable fallback value = case value of
  Just defined -> toMaybe defined
  Nothing -> fallback
