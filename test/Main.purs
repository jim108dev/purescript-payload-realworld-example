module Test.Main where

import Data.Unit (Unit)
import Effect (Effect)
import Test.Server.Shell.Main as Shell

main :: Effect Unit
main = Shell.main
