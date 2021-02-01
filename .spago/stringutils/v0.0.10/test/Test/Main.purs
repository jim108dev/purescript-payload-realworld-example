module Test.Main where

import Prelude
import Effect                 ( Effect )
import Test.Data.Char.Utils   ( testCharUtils )
import Test.Data.String.Utils ( testStringUtils )

main :: Effect Unit
main = do
  testCharUtils
  testStringUtils
