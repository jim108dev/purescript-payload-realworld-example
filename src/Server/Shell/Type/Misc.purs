module Server.Shell.Type.Misc where

import Server.Shell.Type.LogLevel (LogLevel)
import Server.Shell.Type.PersistenceImpl (PersistenceImpl)

type Config
  = { server ::
        { port :: Int
        , hostname :: String
        , logLevel :: LogLevel
        }
    , persistence ::
        { hostname :: String
        , database :: String
        , user :: String
        , password :: String
        , impl :: PersistenceImpl
        }
    , token ::
        { secret :: String
        }
    }

