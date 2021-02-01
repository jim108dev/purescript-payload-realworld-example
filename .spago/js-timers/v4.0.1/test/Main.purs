module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console as C
import Effect.Ref as R
import Effect.Timer as T
import Test.Assert (assert)

main :: Effect Unit
main = do
  counter <- R.new 0

  void $ T.setTimeout 10 do
    C.log "timeout increment counter"
    void $ R.modify (_ + 1) counter

  void $ T.setTimeout 50 do
    C.log "timeout check counter"
    n <- R.read counter
    assert $ n == 1

  void $ T.setTimeout 100 do

    t <- T.setTimeout 20 do
      void $ R.modify (_ + 1) counter

    T.clearTimeout t

    void $ T.setTimeout 50 do
      C.log "check timeout never ran"
      n <- R.read counter
      assert $ n == 1

  void $ T.setTimeout 200 do

    i <- T.setInterval 20 do
      C.log "interval increment counter"
      void $ R.modify (_ + 1) counter

    void $ T.setTimeout 90 do
      T.clearInterval i
      C.log "interval check counter"
      n <- R.read counter
      assert $ n == 5

    void $ T.setTimeout 150 do
      C.log "check interval has stopped"
      n <- R.read counter
      assert $ n == 5
