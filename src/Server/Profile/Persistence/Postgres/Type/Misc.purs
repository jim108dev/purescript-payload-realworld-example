module Server.Profile.Persistence.Postgres.Type.Misc where

import Selda (Col)
import Server.Profile.Type.Misc (Template)

type DbOutputCols s
  = { | Template (Col s) }
