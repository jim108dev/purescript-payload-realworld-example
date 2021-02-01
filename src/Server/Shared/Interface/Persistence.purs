module Server.Shared.Interface.Persistence where

import Server.Shared.Type.Misc (Pool)

type Handle
  = { pool :: Pool }

