module Shared.Type.Validation where

import Data.List.NonEmpty (NonEmptyList)

data ValidationError
  = Empty String
  | AllEmpty

type ValidationErrors
  = NonEmptyList ValidationError

