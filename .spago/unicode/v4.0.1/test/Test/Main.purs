module Test.Main where

import Prelude

import Effect (Effect)
import Test.Data.Char.Unicode (dataCharUnicodeTests)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (run)

main :: Effect Unit
main = run [consoleReporter] $
    dataCharUnicodeTests
