module Server.Shell.Util.Config where

import Prelude
import Data.Either (Either(Right, Left))
import Data.Foldable (intercalate)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Exception (throw)
import Foreign (renderForeignError)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile)
import Node.Path (FilePath)
import Server.Shell.Type.Misc (Config)
import Simple.JSON as JSON

read :: FilePath -> Aff (Either String Config)
read = map parse <<< readTextFile UTF8
  where
  parse s = case JSON.readJSON s of
    Left e -> Left $ intercalate ".\n" $ renderForeignError <$> e
    Right a -> pure a

readOrThrow :: FilePath -> Aff Config
readOrThrow path =
  read path
    >>= case _ of
        Left e -> liftEffect $ throw e
        Right a -> pure a

