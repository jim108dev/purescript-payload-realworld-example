module Test.Server.Shell.Persistence.Postgres.Main where

import Prelude
import Control.Monad.Error.Class (throwError)
import Data.Maybe (maybe)
import Database.PostgreSQL (Query(..), Row0(..), execute)
import Effect.Aff (Aff, error)
import Server.Shared.Persistence.Postgres.Main (withConnection)
import Server.Shared.Type.Misc (Pool(..))

resetDB :: Pool -> String -> Aff Unit
resetDB (PostgresPool pool) sql =
  withConnection pool (\conn -> execute conn (Query sql) Row0)
    >>= maybe (pure unit) (throwError <<< error <<< show)
