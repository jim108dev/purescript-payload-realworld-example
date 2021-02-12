module Main where

import Prelude
import Effect (Effect)
import Server.Main (main) as Server

main :: Effect Unit
main = Server.main
