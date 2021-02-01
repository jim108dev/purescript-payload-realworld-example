module Test.Server.Shell.Persistence.Postgres where

import Prelude
import Data.Foldable (traverse_)
import Data.String (Pattern(..), split)
import Database.Postgres (Query(..), end, execute_, withClient)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile)
import Node.Path (FilePath)
import Server.Shared.Type.Misc (Pool(..))

resetDB :: Pool -> Array String -> Aff Unit
resetDB (PostgresPool pool) sqlStatements =
  withClient pool \conn -> do
    (\sql -> execute_ (Query sql) conn) `traverse_` sqlStatements

endPool :: Pool -> Aff Unit
endPool (PostgresPool pool) = liftEffect $ end pool

readSqlStatements :: FilePath -> Aff (Array String)
readSqlStatements = map (split (Pattern ";")) <<< readTextFile UTF8
