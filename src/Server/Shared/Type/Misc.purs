module Server.Shared.Type.Misc where

import Database.PostgreSQL (Pool) as PG

data Pool
  = PostgresPool PG.Pool

