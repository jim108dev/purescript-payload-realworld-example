module Test.Server.Shell.Type.Misc where

import Prelude
import Data.Maybe (Maybe)
import Effect.Aff (Aff)

type WithApi
  = Aff Unit -> Aff Unit

type Raw
  = { description :: Maybe String
    , domain :: String
    , request ::
        { bodyFilename :: Maybe String
        , method :: String
        , path :: String
        , token :: Maybe String
        }
    , response ::
        { status :: Int
        , bodyFilename :: Maybe String
        }
    , x :: Maybe Boolean
    }

type TestCase
  = { description :: Maybe String
    , domain :: String
    , request ::
        { body :: Maybe String
        , path :: String
        , method :: String
        , token :: Maybe String
        , bodyFilename :: Maybe String
        }
    , response ::
        { status :: Int
        , body :: Maybe String
        , bodyFilename :: Maybe String
        }
    }
