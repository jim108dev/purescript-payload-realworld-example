module Test.Server.Shell.Main where

import Prelude
import Control.Monad.Except (throwError)
import Data.Array (filter)
import Data.Either (Either(Right, Left))
import Data.Foldable (intercalate, traverse_)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Effect.Exception (error, throw)
import Foreign (renderForeignError)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile)
import Node.HTTP (Request)
import Node.Path (FilePath, concat)
import Payload.Headers (Headers)
import Payload.Headers (fromFoldable, empty) as P
import Payload.ResponseTypes (Response(..))
import Server.Shared.Api.Type.Misc (Origin)
import Server.Shell.Api.Interface.Spec (spec) as Api
import Server.Shell.Api.Main (mkHandle) as Api
import Server.Shell.Type.Misc (Config)
import Server.Shell.Util.Aggregate as Aggregate
import Server.Shell.Util.Config (readOrThrow) as Config
import Shared.Util.String (format1, format2)
import Simple.JSON as JSON
import Test.Server.Shell.Interface.Api (Handle)
import Test.Server.Shell.Persistence.Postgres (endPool, readSqlStatements, resetDB)
import Test.Server.Shell.Type.Misc (Raw, TestCase)
import Test.Server.Shell.Type.Misc (WithApi)
import Test.Server.Shell.Util.Payload (delete_, get_, post_, put_, respMatchesJson, withServer) as P
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTestWith)
import Test.Unit.Output.Fancy (runTest)

read :: FilePath -> Aff (Either String (Array Raw))
read = map parse <<< readTextFile UTF8
  where
  parse s = case JSON.readJSON s of
    Left e -> Left $ intercalate ".\n" $ renderForeignError <$> e
    Right a -> pure a

readOrThrow :: FilePath -> Aff (Array Raw)
readOrThrow path =
  read path
    >>= case _ of
        Left e -> liftEffect $ throw e
        Right a -> pure a

readBody :: FilePath -> String -> String -> Aff String
readBody path domain bodyFilename = readTextFile UTF8 $ concat [ path, domain, bodyFilename <> ".json" ]

mkTestCase :: FilePath -> Raw -> Aff TestCase
mkTestCase path r =
  let
    requestBodyFilename = (\id -> concat [ path, r.domain, id ]) <$> r.request.bodyFilename

    responseBodyFilename = (\id -> concat [ path, r.domain, id ]) <$> r.response.bodyFilename
  in
    do
      requestBody <- readTextFile UTF8 `traverse` requestBodyFilename
      responseBody <- readTextFile UTF8 `traverse` responseBodyFilename
      pure
        { description: r.description
        , domain: r.domain
        , request:
            { body: requestBody
            , bodyFilename: requestBodyFilename
            , method: r.request.method
            , path: r.request.path
            , token: r.request.token
            }
        , response:
            { body: responseBody
            , bodyFilename: responseBodyFilename
            , status: r.response.status
            }
        }

fakeAuthOrigin :: Request -> Aff (Either (Response String) Origin)
fakeAuthOrigin req = pure $ Right "http://example.com"

main :: Effect Unit
main =
  launchAff_ do
    config <- Config.readOrThrow "./config/Server/Dev.json"
    rs <- readOrThrow "./test/Server/Shell/TestCases.json"
    activeRs <- pure $ filter (\r -> r.x == Nothing || r.x == Just false) rs
    ts <- mkTestCase "./test/Server" `traverse` activeRs
    h1 <- liftEffect $ Aggregate.mkHandle config
    sqlStatements <- readSqlStatements "./sql/ResetTables.sql"
    resetDB h1.persistence.pool sqlStatements
    runTestWith runTest do
      let
        apiImpl = Api.mkHandle h1

        apiMock =
          { handlers: apiImpl.handlers
          , guards:
              { userId: apiImpl.guards.userId
              , maybeUserId: apiImpl.guards.maybeUserId
              , origin: fakeAuthOrigin
              }
          }

        withApi = P.withServer Api.spec apiMock

        h2 = mkHandle withApi config
      suite "Tests" do
        runTestCase h2 `traverse_` ts
    endPool h1.persistence.pool

runTestCase :: Handle -> TestCase -> TestSuite
runTestCase h t =
  test description
    $ h.withApi do
        aResponse <- method t.request.path t.request.body t.request.token
        matches t.response.status t.response.body aResponse
  where
  method = case t.request.method of
    "get" -> h.get
    "post" -> h.post
    "put" -> h.put
    "delete" -> h.delete
    s -> (\_ _ _ -> throwError $ error (format1 "method {1} not found." s))

  matches = case t.response.body of
    Nothing -> (\status _ actual -> Assert.equal status actual.status)
    Just body -> (\status _ -> P.respMatchesJson { status, body })

  -- verbose
  description = intercalate " " [ t.domain, t.request.method, t.request.path, (show t.response.status), fromMaybe "" t.description, fromMaybe "" t.response.bodyFilename ]

--non-verbose
--description = intercalate " " [ t.request.method, t.request.path, fromMaybe "" t.description ]
mkHandle :: WithApi -> Config -> Handle
mkHandle withApi config =
  { withApi
  , get: (\path _ token -> P.get_ host path (toHeader token))
  , post: (\path body token -> P.post_ host path (toHeader token) body)
  , put: (\path body token -> P.put_ host path (toHeader token) body)
  , delete: (\path body token -> P.delete_ host path (toHeader token) body)
  }
  where
  host = format2 "http://{1}:{2}" config.server.hostname (show config.server.port)

  toHeader :: Maybe String -> Headers
  toHeader token = case token of
    Nothing -> P.empty
    Just t -> P.fromFoldable [ Tuple "Authorization" t ]
