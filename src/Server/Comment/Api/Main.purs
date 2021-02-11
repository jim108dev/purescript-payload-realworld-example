module Server.Comment.Api.Main where

import Prelude
import Data.Bifunctor (bimap)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Payload.ResponseTypes (Empty(..), Response)
import Payload.Server.Response (notFound, ok, unprocessableEntity)
import Server.Comment.Api.Type.CreateDto (CreateDto, unwrapCreateDto)
import Server.Comment.Api.Type.Misc (MultipleDto, Params, SingleDto, mkMultipleDto, mkSingleDto)
import Server.Comment.Interface.Persistence (Handle) as Persistence
import Server.Comment.Persistence.Postgres.Main as Postgres
import Server.Comment.Type.Misc (InputError(..))
import Server.Shared.Api.Main (setHeaders, renderErrorEntity, renderErrorMessage)
import Server.Shared.Api.Type.Misc (ArticleParam, AuthGuard, OptionalGuard, TResponse)
import Server.Shared.Interface.Persistence (Handle)
import Server.Shared.Type.Misc (Pool(..))

mkHandle :: Handle -> _
mkHandle h =
  { create: create h
  , delete: delete h
  , get: get h
  }

next :: Handle -> Persistence.Handle
next h = case h.pool of
  PostgresPool pool -> Postgres.mkHandle pool

create :: Handle -> { body :: CreateDto, params :: ArticleParam, guards :: AuthGuard } -> Aff (TResponse SingleDto)
create h { body: b, params: p, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkSingleDto)
    <$> (next h).insert g.userId (unwrapCreateDto b) p.slug

get :: Handle -> { params :: ArticleParam, guards :: OptionalGuard } -> Aff (TResponse MultipleDto)
get h { params: p, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkMultipleDto)
    <$> Right
    <$> (next h).search g.maybeUserId p.slug

delete :: Handle -> { params :: Params, guards :: AuthGuard } -> Aff (TResponse Empty)
delete h { params: p, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (\_ -> ok Empty)
    <$> (next h).delete p.id p.slug

renderError :: InputError -> Response String
renderError NOT_FOUND = notFound $ renderErrorMessage "comment not found"
renderError EMAIL_EXITS = unprocessableEntity $ renderErrorEntity "email" "exists"
