module Server.Shared.Api.Main where

import Prelude

import Data.Either (Either(..))
import Data.Foldable as Fold
import Data.List.NonEmpty (NonEmptyList)
import Effect.Aff (Aff)
import Foreign (ForeignError(..))
import Payload.ContentType (json, plain)
import Payload.Headers (set)
import Payload.ResponseTypes (Empty(..), Response) as P
import Payload.Server.Response (noContent, setHeaders) as P
import PointFree ((<..))
import Server.Shared.Api.Headers (baseHeaders)
import Server.Shared.Api.Type.Misc (CorsGuard, Origin, TResponse, WildcardParam)
import Shared.Util.String (format1, format2)

renderBody :: String -> String
renderBody = format1 "{\n\t\"errors\":{\n{1}\n\t}\n}"

renderEntry :: String -> String -> String
renderEntry = format2 "\t\t\"{1}\": [\"{2}\"]"

renderMessage :: String -> String
renderMessage = renderEntry "message"

defaultForeignError :: String
defaultForeignError = "json format invalid"

renderDefaultMessage :: String
renderDefaultMessage = renderMessage defaultForeignError

intercalate :: forall a. Fold.Foldable a => a String -> String
intercalate = Fold.intercalate ", \n"

renderJsonErrors :: NonEmptyList ForeignError -> String
renderJsonErrors e = renderBody $ intercalate $ renderForeignError <$> e

renderForeignError :: ForeignError -> String
renderForeignError (ForeignError msg) = renderMessage msg
renderForeignError (ErrorAtIndex i e) = renderDefaultMessage
renderForeignError (TypeMismatch exp act) = renderDefaultMessage
renderForeignError (ErrorAtProperty prop e) = renderForeignError' e

renderForeignError' :: ForeignError -> String
renderForeignError' (ForeignError msg) = renderMessage msg
renderForeignError' (ErrorAtIndex i e) = renderDefaultMessage
renderForeignError' (TypeMismatch exp act) = renderDefaultMessage
renderForeignError' (ErrorAtProperty prop e) = renderEntry prop $ renderForeignError'' e

renderForeignError'' :: ForeignError -> String
renderForeignError'' (ForeignError msg) = msg
renderForeignError'' (ErrorAtIndex i e) = defaultForeignError
renderForeignError'' (TypeMismatch _ "Undefined") = "missing"
renderForeignError'' (TypeMismatch exp act) = "Type mismatch: expected " <> exp <> ", found " <> act
renderForeignError'' (ErrorAtProperty prop e) = defaultForeignError

setHeaders :: forall a. Origin -> Either (P.Response String) (P.Response a) -> TResponse a
setHeaders origin appResult = case appResult of
  Left e -> Left $ P.setHeaders headers $ e
  Right a -> Right $ P.setHeaders headers $ a
  where
  headers =
    set "Content-Type" json
      $ baseHeaders origin

options :: { guards :: CorsGuard, params :: WildcardParam } -> Aff (TResponse P.Empty)
options { guards: g, params: _ } = pure $ Right $ P.setHeaders headers $ P.noContent P.Empty
  where
  headers =
    set "Content-Type" plain
      $ set "Content-Length" "0"
      $ baseHeaders g.origin

renderErrorEntity :: String -> String -> String
renderErrorEntity = renderBody <.. renderEntry

renderErrorMessage :: String -> String
renderErrorMessage = renderErrorEntity "message"
