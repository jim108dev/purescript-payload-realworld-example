module Test.Node.Buffer.ST (test) where

import Prelude

import Control.Monad.ST (run) as ST
import Effect (Effect)
import Effect.Console (log)
import Node.Buffer.Class (create)
import Node.Buffer.Immutable as Immutable
import Node.Buffer.ST (STBuffer, run)
import Test.Assert (assertEqual)
import Test.Node.Buffer.Class (testMutableBuffer)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)

test :: Effect Unit
test = do
  log "Testing Node.Buffer.ST ..."
  testMutableBuffer (Proxy :: Proxy (STBuffer _)) unsafeCoerce
  log " - run"
  testRun

testRun :: Effect Unit
testRun = do
  let buf = Immutable.toArray $ run (create 3)
  assertEqual {expected: [0, 0, 0], actual: buf}
