module Test.ResetTables where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile)
import Server.Shell.Util.Aggregate as Aggregate
import Server.Shell.Util.Config (readOrThrow)
import Test.Server.Shell.Persistence.Postgres.Main (resetDB)

main :: Effect Unit
main =
  launchAff_ do
    config <- readOrThrow "./config/Server/Dev.json"
    sql <- readTextFile UTF8 "./sql/ResetTables.sql"
    h1 <- liftEffect $ Aggregate.mkHandle config
    pure $ resetDB h1.persistence.pool sql
