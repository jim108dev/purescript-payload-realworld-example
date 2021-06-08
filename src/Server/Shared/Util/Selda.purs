module Server.Shared.Util.Selda where

import Prelude
import Control.Monad.Error.Class (throwError)
import Data.Maybe (maybe)
import Database.PostgreSQL (PGError(..))
import Selda.PG.Class (BackendPGClass, class MonadSeldaPG, query1)
import Selda.Query.Class (class GenericQuery)
import Selda.Query.Type (FullQuery)

type B
  = BackendPGClass

-- | Throws `ConversionError ∷ PGError` is case of no results.
query1_ ∷
  ∀ o i m.
  GenericQuery BackendPGClass m i o ⇒
  MonadSeldaPG m ⇒
  FullQuery B { | i } → m { | o }
query1_ = query1 >=> maybe (throwError err) pure
  where
  err = ConversionError "Cannot execute `query1_`: result array is empty"
