module Test.Node.Buffer (test) where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Node.Buffer (Buffer)
import Test.Node.Buffer.Class (testMutableBuffer)
import Test.Node.Buffer.Immutable as Immutable
import Test.Node.Buffer.ST (test) as ST
import Type.Proxy (Proxy(..))

test :: Effect Unit
test = do

  log "Testing Node.Buffer ..."
  testMutableBuffer (Proxy :: Proxy Buffer) identity

  ST.test
  Immutable.test
