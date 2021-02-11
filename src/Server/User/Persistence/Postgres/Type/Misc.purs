module Server.User.Persistence.Postgres.Type.Misc where

import Prelude
import Data.Maybe (Maybe(..))
import Selda (Col, Table(..))
import Server.User.Type.Misc (Template, IdTemplate)
import Shared.Type.LongString (LongString)
import Shared.Type.LongString as LongString
import Shared.Type.Misc (Password, Identity)

type DbOutputCols s
  = { | Template (Col s) Maybe (IdTemplate (Col s) Identity) }

encryptedTable :: Password -> Table ( password ∷ LongString )
encryptedTable password =
  Source "encrypted"
    $ do
        case _ of
          Nothing -> "\"encrypted\""
          Just alias -> "crypt('" <> (LongString.toString password) <> "', gen_salt('bf'))" <> " " <> alias <> " (password)"
