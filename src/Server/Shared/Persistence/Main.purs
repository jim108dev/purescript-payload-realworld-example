module Server.Shared.Persistence.Postgres.Main where

import Prelude
import Control.Monad.Error.Class (throwError)
import Data.Either (Either(..))
import Database.PostgreSQL as PG
import Effect.Aff (Aff, error)
import Effect.Class (class MonadEffect)
import Effect.Class.Console (log)
import Global.Unsafe (unsafeStringify)
import Selda (Col(..), FullQuery, Table, showQuery, showUpdate)
import Selda.Col (class GetCols, showCol)
import Selda.Expr (Expr(..))
import Selda.PG (litPG, showPG)
import Selda.Query.ShowStatement (ppQuery)
import Selda.Query.Utils (class TableToColsWithoutAlias)
import Text.Pretty (render)

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

castToTextArray :: forall s a. Col s a -> Col s a
castToTextArray col =
  Col
    $ Any do
        v <- showCol col
        pure $ v <> "::TEXT[]"

castToArrayTextArray :: forall s a. Col s a -> Col s a
castToArrayTextArray col =
  Col
    $ Any do
        v <- showCol col
        pure $ "ARRAY (" <> v <> ")::TEXT[]"

unnest :: forall s a. Col s a -> Col s a
unnest col =
  Col
    $ Any do
        v <- showCol col
        pure $ "UNNEST (" <> v <> ")"

subQuery :: forall a i s. GetCols i => FullQuery s (Record i) → Col s a
subQuery q =
  Col
    $ Any do
        s <- render 0 <$> ppQuery q
        pure $ "(" <> s <> ")"

arraySubQuery :: forall a i s. GetCols i => FullQuery s (Record i) → Col s a
arraySubQuery q =
  Col
    $ Any do
        s <- render 0 <$> ppQuery q
        pure $ "SELECT ARRAY(" <> s <> ")::text[]"

any :: forall a s. Col s (Array a) -> Col s a
any col =
  Col
    $ Any do
        s <- showCol col
        pure $ "ANY(" <> s <> ")"

logQuery :: forall s i m. GetCols i => MonadEffect m => FullQuery s { | i } -> m Unit
logQuery q = do
  let
    { strQuery, params } = showPG $ showQuery q
  log strQuery
  log $ unsafeStringify params
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
  log $ unsafeStringify params
  log ""