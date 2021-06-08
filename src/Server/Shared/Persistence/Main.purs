module Server.Shared.Persistence.Postgres.Main where

import Prelude

import Control.Monad.Error.Class (throwError)
import Data.Either (Either(..))
import Database.PostgreSQL as PG
import Effect.Aff (Aff, error)
import Effect.Class (class MonadEffect)
import Effect.Class.Console (log)
import Selda (Col(..), FullQuery, Table, showQuery, showUpdate)
import Selda.Col (class GetCols, showCol)
import Selda.Expr (Expr(..))
import Selda.PG (litPG, showPG)
import Selda.Query.PrettyPrint (dodoPrint)
import Selda.Query.ShowStatement (ppQuery)
import Selda.Query.Utils (class TableToColsWithoutAlias)
import Simple.JSON as JSON

withConnection :: forall a. PG.Pool -> (PG.Connection -> Aff a) -> Aff a
withConnection pool f =
  PG.withConnection pool case _ of
    Left pgError -> throwError $ error $ ("PostgreSQL connection error: " <> show pgError)
    Right conn -> f conn

crypt :: forall s a. Col s a -> Col s a -> Col s a
crypt value passwordHashCol =
  Col
    $ Any do
        s <- showCol passwordHashCol
        v <- showCol value
        pure $ "crypt(" <> v <> ", " <> s <> ")"

cryptGenSalt :: forall s a. Col s a -> Col s a
cryptGenSalt value =
  Col
    $ Any do
        v <- showCol value
        bf <- showCol $ litPG "bf"
        pure $ "crypt(" <> v <> ", gen_salt(" <> bf <> "))"

toTextArray :: forall s a. Col s a -> Col s a
toTextArray col =
  Col
    $ Any do
        v <- showCol col
        pure $ v <> "::TEXT[]"

toArrayTextArray :: forall a i s. GetCols i => FullQuery s (Record i) → Col s a
toArrayTextArray q =
  Col
    $ Any do
        s <- dodoPrint <$> ppQuery q
        pure $ "ARRAY (" <> s <> ")::TEXT[]"

unnest :: forall s a. Col s a -> Col s a
unnest col =
  Col
    $ Any do
        v <- showCol col
        pure $ "UNNEST (" <> v <> ")"

subQuery :: forall a s. FullQuery s { value :: Col s a } → Col s a
subQuery q =
  Col
    $ Any do
        s <- dodoPrint <$> ppQuery q
        pure $ "(" <> s <> ")"

any :: forall a s. Col s (Array a) -> Col s a
any col =
  Col
    $ Any do
        s <- showCol col
        pure $ "ANY (" <> s <> ")"

logQuery :: forall s i m. GetCols i => MonadEffect m => FullQuery s { | i } -> m Unit
logQuery q = do
  let
    { strQuery, params } = showPG $ showQuery q
  log strQuery
  log $ JSON.unsafeStringify params
  log ""

logUpdate ∷
  forall t s r m.
  TableToColsWithoutAlias s t r =>
  GetCols r =>
  MonadEffect m =>
  Table t → ({ | r } → Col s Boolean) → ({ | r } → { | r }) → m Unit
logUpdate table pred up = do
  let
    { strQuery, params } = showPG $ showUpdate table pred up
  log strQuery
  log $ JSON.unsafeStringify params
  log ""
