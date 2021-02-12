module Server.Shell.Type.Misc where

import Data.Maybe (Maybe)
import Server.Shell.Type.LogLevel (LogLevel)
import Server.Shell.Type.PersistenceImpl (PersistenceImpl)
import Timestamp (Timestamp)

type ServerConfig
  = { port :: Int
    , hostname :: String
    , logLevel :: LogLevel
    }

type PersistenceConfig
  = { hostname :: String
    , database :: String
    , user :: String
    , password :: String
    , impl :: PersistenceImpl
    }

type TokenConfig
  = { timestamp :: Maybe Timestamp
    , secret :: String
    }

type Config
  = { server :: ServerConfig
    , persistence :: PersistenceConfig
    , token :: TokenConfig
    }
