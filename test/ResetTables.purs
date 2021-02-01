module Test.ResetTables where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Server.Shell.Util.Aggregate as Aggregate
import Server.Shell.Util.Config (readOrThrow)
import Test.Server.Shell.Persistence.Postgres (endPool, readSqlStatements, resetDB)

main :: Effect Unit
main =
  launchAff_ do
    config <- readOrThrow "./config/Server/Dev.json"
    sqlStatements <- readSqlStatements "./sql/ResetTables.sql"
    h1 <- liftEffect $ Aggregate.mkHandle config
    resetDB h1.persistence.pool sqlStatements
    endPool h1.persistence.pool
