module Test.Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Node.Simple.Jwt (Algorithm(..), Jwt, JwtError(..), decode, encode, fromString)
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)

type Payload =
  { sub :: String
  }

main :: Effect Unit
main = runTest do
  suite "encode" do
    test "HS256" do
      jwt <- liftEffect $ encode secret HS256 payload
      Assert.equal jwtByHS256 jwt
    test "HS512" do
      jwt <- liftEffect $ encode secret HS512 payload
      Assert.equal jwtByHS512 jwt
  suite "decode" do
    suite "HS256" do
      test "success" do
        payloadOrErr <- liftEffect $ decode secret jwtByHS256
        Assert.equal (Right payload) payloadOrErr
      test "invalid token" do
        (payloadOrErr :: Either JwtError Payload) <- liftEffect $ decode secret (fromString "fjaie.afeoafe.cadiwo.ofwo")
        Assert.equal (Left InvalidTokenError) payloadOrErr
      test "verify error" do
        (payloadOrErr :: Either JwtError Payload) <- liftEffect $ decode secret (fromString "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0c3ViIn0.Xy3Gvp5nlc")
        Assert.equal (Left VerifyError) payloadOrErr
      test "decode error" do
        (payloadOrErr :: Either JwtError Payload) <- liftEffect $ decode secret (fromString "dfiaofao.ffifeadl.afwoefiqw")
        Assert.equal (Left DecodeError) payloadOrErr
    suite "HS512" do
      test "success" do
        payloadOrErr <- liftEffect $ decode secret jwtByHS512
        Assert.equal (Right payload) payloadOrErr
      test "invalid token" do
        (payloadOrErr :: Either JwtError Payload) <- liftEffect $ decode secret (fromString "fjaie.afeoafe.cadiwo.ofwo")
        Assert.equal (Left InvalidTokenError) payloadOrErr
      test "verify error" do
        (payloadOrErr :: Either JwtError Payload) <- liftEffect $ decode secret (fromString "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0c3ViIn0.Xy3Gvp5nlc")
        Assert.equal (Left VerifyError) payloadOrErr
      test "decode error" do
        (payloadOrErr :: Either JwtError Payload) <- liftEffect $ decode secret (fromString "848q4jfifewww.8382qu3lds.389rnekjffa")
        Assert.equal (Left DecodeError) payloadOrErr
    suite "Unknown algorithm" do
      test "not supported algorithm error" do
        (payloadOrErr :: Either JwtError Payload) <- liftEffect $ decode secret (fromString "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJzd.Xy3Gvp")
        Assert.equal (Left NotSupportedAlgorithmError) payloadOrErr

payload :: Payload
payload = { sub: "testsub" }

secret :: String
secret = "testsecret"

jwtByHS256 :: Jwt
jwtByHS256 = fromString "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0c3ViIn0.Xy3Gvp5nlca62KqH66kDKeadYM99jRP-e2S--qVYdbs"

jwtByHS512 :: Jwt
jwtByHS512 = fromString "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0c3ViIn0.Z5bsx4og_2UL-1WyxulgXXA7VtC01OhFVivvT_C8wS_uY3QUaqDhLzVsTBACNyv8z-VoYkhboTzlBiZ4Gk5mLQ"
