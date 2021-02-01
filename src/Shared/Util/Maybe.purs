module Shared.Util.Maybe where

import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe)

fromMaybeNullable :: forall a. Maybe a -> Maybe (Nullable a) -> Maybe a
fromMaybeNullable fallback value = case value of
  Just defined -> toMaybe defined
  Nothing -> fallback
