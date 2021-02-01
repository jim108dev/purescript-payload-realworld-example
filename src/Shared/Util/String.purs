module Shared.Util.String where

import Data.String (Pattern(..), Replacement(..), replaceAll)

format1 :: String -> String -> String
format1 str x1 = replaceAll (Pattern "{1}") (Replacement x1) str

format2 :: String -> String -> String -> String
format2 str x1 x2 =
  let
    str1 = format1 str x1
  in
    replaceAll (Pattern "{2}") (Replacement x2) str1

format3 :: String -> String -> String -> String -> String
format3 str x1 x2 x3 =
  let
    str2 = format2 str x1 x2
  in
    replaceAll (Pattern "{3}") (Replacement x3) str2

format4 :: String -> String -> String -> String -> String -> String
format4 str x1 x2 x3 x4 =
  let
    str3 = format3 str x1 x2 x3
  in
    replaceAll (Pattern "{4}") (Replacement x4) str3
