module Test.Node.Buffer.Immutable (test) where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Node.Buffer.Immutable as Immutable
import Node.Buffer.Immutable (ImmutableBuffer)
import Node.Buffer.Types (BufferValueType(..))
import Node.Encoding (Encoding(..))
import Test.Assert (assertEqual, assertTrue)

test :: Effect Unit
test = do
  log "Testing Node.Buffer.Immutable ..."

  log " - show"
  testShow

  log " - eq"
  testEq

  log " - compare"
  testCompare

  log " - create"
  testCreate

  log " - fromString"
  testFromString

  log " - toString"
  testToString

  log " - toArray"
  testToArray

  log " - readString"
  testReadString

  log " - getAtOffset"
  testGetAtOffset

  log " - (to/from)ArrayBuffer"
  testToFromArrayBuffer

  log " - concat'"
  testConcat'

  log " - slice"
  testSlice

  log " - size"
  testSize

buffer123 :: ImmutableBuffer
buffer123 = Immutable.fromArray [1, 2, 3]

testShow :: Effect Unit
testShow = do
  assertEqual {expected: "<Buffer 01 02 03>", actual: show buffer123}

testEq :: Effect Unit
testEq = do
  assertTrue $ buffer123 == buffer123
  assertTrue $ buffer123 == Immutable.fromArray [1, 2, 3]
  assertTrue $ buffer123 /= Immutable.fromArray [1, 2, 4]
  assertTrue $ buffer123 /= Immutable.fromArray [1, 2]

testCompare :: Effect Unit
testCompare = do
  assertEqual {expected: EQ, actual: compare buffer123 buffer123}
  assertEqual {expected: LT, actual: compare buffer123 $ Immutable.fromArray [3, 2, 1]}
  assertEqual {expected: GT, actual: compare buffer123 $ Immutable.fromArray [0, 1, 2]}

testCreate :: Effect Unit
testCreate = do
  assertEqual {expected: Immutable.fromArray [], actual: Immutable.create 0}
  assertEqual {expected: Immutable.fromArray [0, 0, 0], actual: Immutable.create 3}

testFromString :: Effect Unit
testFromString = do
  let buf = Immutable.fromString "hello, world" ASCII
  assertEqual {expected: 32.0, actual: Immutable.read UInt8 6 buf}

testToString :: Effect Unit
testToString = do
  let str = "hello, world"
      str' = Immutable.toString ASCII $ Immutable.fromString str ASCII
  assertEqual {expected: str, actual: str'}

testToArray :: Effect Unit
testToArray = do
  assertEqual {expected: [1, 2, 3], actual: Immutable.toArray buffer123}

testReadString :: Effect Unit
testReadString = do
  let str = "hello, world"
      str' = Immutable.readString ASCII 7 12 $ Immutable.fromString str ASCII
  assertEqual {expected: "world", actual: str'}

testGetAtOffset :: Effect Unit
testGetAtOffset = do
  assertEqual {expected: Just 2, actual: Immutable.getAtOffset 1 buffer123}
  assertEqual {expected: Nothing, actual: Immutable.getAtOffset 99 buffer123}
  assertEqual {expected: Nothing, actual: Immutable.getAtOffset (-1) buffer123}

testToFromArrayBuffer :: Effect Unit
testToFromArrayBuffer = do
  assertEqual {expected: buffer123, actual: Immutable.fromArrayBuffer $ Immutable.toArrayBuffer buffer123}

testConcat' :: Effect Unit
testConcat' = do
  let bufs = map (\x -> Immutable.fromArray [x, x+1, x+2]) [0,3,6,9,12]
      buf = Immutable.concat' bufs 15
      out = Immutable.toArray buf

  assertEqual {expected: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], actual: out}

testSlice :: Effect Unit
testSlice = do
  assertEqual {expected: buffer123, actual: Immutable.slice 0 3 buffer123}
  assertEqual {expected: buffer123, actual: Immutable.slice 0 4 buffer123}
  assertEqual {expected: Immutable.fromArray [2], actual: Immutable.slice 1 2 buffer123}

testSize :: Effect Unit
testSize = do
  assertEqual {expected: 0, actual: Immutable.size $ Immutable.fromArray []}
  assertEqual {expected: 3, actual: Immutable.size buffer123}
