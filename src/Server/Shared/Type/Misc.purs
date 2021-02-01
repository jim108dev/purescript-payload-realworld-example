module Server.Shared.Type.Misc where

import Database.Postgres (Pool) as Postgres

data Pool
  = PostgresPool Postgres.Pool

