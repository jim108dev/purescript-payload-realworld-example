module Test.Node.Buffer.Class (testMutableBuffer) where

import Prelude

import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Maybe (Maybe(..))
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Console (log)
import Node.Buffer (class MutableBuffer, BufferValueType(..), concat', copy, create, fill, freeze, fromArray, fromArrayBuffer, fromString, getAtOffset, read, readString, setAtOffset, slice, thaw, toArray, toArrayBuffer, toString, write)
import Node.Buffer.Immutable as Immutable
import Node.Encoding (Encoding(..))
import Test.Assert (assertEqual)
import Type.Proxy (Proxy)

testMutableBuffer :: forall buf m. MutableBuffer buf m =>
  Proxy buf -> (forall a. m a -> Effect a) -> Effect Unit
testMutableBuffer _ run = do

  log " - create"
  testCreate

  log " - freeze"
  testFreeze

  log " - thaw"
  testThaw

  log " - Reading and writing"
  testReadWrite

  log " - fromArray"
  testFromArray

  log " - toArray"
  testToArray

  log " - fromString"
  testFromString

  log " - (to/from)ArrayBuffer"
  testToFromArrayBuffer

  log " - toString"
  testToString

  log " - readString"
  testReadString

  log " - slice"
  testSlice

  log " - copy"
  testCopy

  log " - fill"
  testFill

  log " - concat'"
  testConcat'

  log " - getAtOffset"
  testGetAtOffset

  where
    testCreate :: Effect Unit
    testCreate = do
      buf <- run ((create 3 :: m buf) >>= toArray)
      assertEqual {expected: [0, 0, 0], actual: buf}

    testFreeze :: Effect Unit
    testFreeze = do
      buf <- Immutable.toArray <$> run ((fromArray [1, 2, 3] :: m buf) >>= freeze)
      assertEqual {expected: [1, 2, 3], actual: buf}

    testThaw :: Effect Unit
    testThaw = do
      buf <- run ((thaw (Immutable.fromArray [1, 2, 3]) :: m buf) >>= toArray)
      assertEqual {expected: [1, 2, 3], actual: buf}

    testReadWrite :: Effect Unit
    testReadWrite = do
      let val = 42.0
      readVal <- run do
        buf <- create 1 :: m buf
        write UInt8 val 0 buf
        read UInt8 0 buf

      assertEqual {expected: val, actual: readVal}

    testFromArray :: Effect Unit
    testFromArray = do
      readVal <- run do
        buf <- fromArray [1,2,3,4,5] :: m buf
        read UInt8 2 buf

      assertEqual {expected: 3.0, actual: readVal}

    testToArray :: Effect Unit
    testToArray = do
      let val = [1,2,67,3,3,7,8,3,4,237]
      valOut <- run do
        buf <- fromArray val :: m buf
        toArray buf

      assertEqual {expected: val, actual: valOut}

    testFromString :: Effect Unit
    testFromString = do
      let str = "hello, world"
      val <- run do
        buf <- fromString str ASCII :: m buf
        read UInt8 6 buf

      assertEqual {expected: 32.0, actual: val} -- ASCII space

    testToFromArrayBuffer :: Effect Unit
    testToFromArrayBuffer = do
      buf <- run $
        fromArray [1, 2, 3]
        >>= (toArrayBuffer :: buf -> m ArrayBuffer)
        >>= (fromArrayBuffer :: ArrayBuffer -> m buf)
        >>= toArray
      assertEqual {expected: [1, 2, 3], actual: buf}

    testToString :: Effect Unit
    testToString = do
      let str = "hello, world"
      strOut <- run do
        buf <- fromString str ASCII :: m buf
        toString ASCII buf

      assertEqual {expected: str, actual: strOut}

    testReadString :: Effect Unit
    testReadString = do
      let str = "hello, world"
      strOut <- run do
        buf <- fromString str ASCII :: m buf
        readString ASCII 7 12 buf

      assertEqual {expected: "world", actual: strOut}

    testSlice :: Effect Unit
    testSlice = do
      {bufArr, bufSliceArr} <- run do
        buf <- fromArray [1, 2, 3, 4] :: m buf
        let bufSlice = slice 1 3 buf
        setAtOffset 42 1 bufSlice
        bufArr <- toArray buf
        bufSliceArr <- toArray bufSlice
        pure {bufArr, bufSliceArr}

      assertEqual {expected: [1, 2, 42, 4], actual: bufArr}
      assertEqual {expected: [2, 42], actual: bufSliceArr}

    testCopy :: Effect Unit
    testCopy = do
      {copied, out} <- run do
        buf1 <- fromArray [1,2,3,4,5] :: m buf
        buf2 <- fromArray [10,9,8,7,6]
        copied <- copy 0 3 buf1 2 buf2
        out <- toArray buf2
        pure {copied, out}

      assertEqual {expected: 3, actual: copied}
      assertEqual {expected: [10,9,1,2,3], actual: out}

    testFill :: Effect Unit
    testFill = do
      out <- run do
        buf <- fromArray [1,1,1,1,1] :: m buf
        fill 42 2 4 buf
        toArray buf

      assertEqual {expected: [1,1,42,42,1], actual: out}

    testConcat' :: Effect Unit
    testConcat' = do
      out <- run do
        bufs <- traverse (fromArray :: Array Int -> m buf) $ map (\x -> [x, x+1, x+2]) [0,3,6,9,12]
        buf  <- concat' bufs 15
        toArray buf

      assertEqual {expected: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], actual: out}

    testGetAtOffset :: Effect Unit
    testGetAtOffset = do
      {o1, o4, om1} <- run do
        buf <- fromArray [1, 2, 3, 4] :: m buf
        o1 <- getAtOffset 1 buf
        o4 <- getAtOffset 4 buf
        om1 <- getAtOffset (-1) buf
        pure {o1, o4, om1}

      assertEqual {expected: Just 2, actual: o1}
      assertEqual {expected: Nothing, actual: o4}
      assertEqual {expected: Nothing, actual: om1}
