module Gzip where

import Prelude

import Effect (Effect)
import Node.Stream (Duplex, Readable, Writable, pipe)


foreign import gzip :: Effect Duplex
foreign import stdin :: Readable ()
foreign import stdout :: Writable ()

main :: Effect (Writable ())
main = do
  z <- gzip
  _ <- stdin `pipe` z
  z     `pipe` stdout
