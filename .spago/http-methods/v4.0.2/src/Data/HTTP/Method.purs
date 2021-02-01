module Data.HTTP.Method
  ( Method(..)
  , CustomMethod
  , unCustomMethod
  , fromString
  , print
  ) where

import Prelude

import Data.Either (Either(..), either)
import Data.String as Str

data Method
  -- HTTP/1.1
  = OPTIONS
  | GET
  | HEAD
  | POST
  | PUT
  | DELETE
  | TRACE
  | CONNECT

  -- RFC 2518
  | PROPFIND
  | PROPPATCH
  | MKCOL
  | COPY
  | MOVE
  | LOCK
  | UNLOCK

  -- RFC5789
  | PATCH

derive instance eqMethod :: Eq Method
derive instance ordMethod :: Ord Method

instance showMethod :: Show Method where
  show OPTIONS = "OPTIONS"
  show GET = "GET"
  show HEAD = "HEAD"
  show POST = "POST"
  show PUT = "PUT"
  show DELETE = "DELETE"
  show TRACE = "TRACE"
  show CONNECT = "CONNECT"
  show PROPFIND = "PROPFIND"
  show PROPPATCH = "PROPPATCH"
  show MKCOL = "MKCOL"
  show COPY = "COPY"
  show MOVE = "MOVE"
  show LOCK = "LOCK"
  show UNLOCK = "UNLOCK"
  show PATCH = "PATCH"

newtype CustomMethod = CustomMethod String

unCustomMethod :: CustomMethod -> String
unCustomMethod (CustomMethod m) = m

derive instance eqCustomMethod :: Eq CustomMethod
derive instance ordCustomMethod :: Ord CustomMethod

instance showCustomMethod :: Show CustomMethod where
  show (CustomMethod m) = "(CustomMethod " <> show m <> ")"

fromString :: String -> Either Method CustomMethod
fromString s =
  case Str.toUpper s of
    "OPTIONS" -> Left OPTIONS
    "GET" -> Left GET
    "HEAD" -> Left HEAD
    "POST" -> Left POST
    "PUT" -> Left PUT
    "DELETE" -> Left DELETE
    "TRACE" -> Left TRACE
    "CONNECT" -> Left CONNECT
    "PROPFIND" -> Left PROPFIND
    "PROPPATCH" -> Left PROPPATCH
    "MKCOL" -> Left MKCOL
    "COPY" -> Left COPY
    "MOVE" -> Left MOVE
    "LOCK" -> Left LOCK
    "UNLOCK" -> Left UNLOCK
    "PATCH" -> Left PATCH
    m -> Right (CustomMethod m)

print :: Either Method CustomMethod -> String
print = either show unCustomMethod
