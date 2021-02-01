module Server.Article.Api.Main (mkHandle) where

import Prelude

import Data.Bifunctor (bimap)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Payload.ResponseTypes (Empty(..), Response)
import Payload.Server.Response (notFound, ok, unprocessableEntity)
import Server.Article.Api.Type.CreateDto (CreateDto, unwrapCreateDto)
import Server.Article.Api.Type.Misc (MultipleDto, Param, SingleDto, TagsDto, mkMultipleDto, mkSingleDto, mkTagsDto)
import Server.Article.Api.Type.UpdateDto (UpdateDto, unwrapUpdateDto)
import Server.Article.Application.Main as App
import Server.Article.Interface.Persistence (Handle) as Persistence
import Server.Article.Persistence.Postgres (mkHandle) as Postgres
import Server.Article.Type.Misc (FullQuery, InputError(..), RangeQuery)
import Server.Shared.Api.Main (setHeaders, renderErrorEntity, renderErrorMessage)
import Server.Shared.Api.Type.Misc (AuthGuard, CorsGuard, OptionalGuard, TResponse)
import Server.Shared.Interface.Persistence (Handle)
import Server.Shared.Type.Misc (Pool(..))

mkHandle :: Handle -> _
mkHandle h =
  { create: create h
  , list: list h
  , delete: delete h
  , favorite: favorite h
  , feed: feed h
  , get: get h
  , getTags: getTags h
  , unfavorite: unfavorite h
  , update: update h
  }

next :: Handle -> Persistence.Handle
next h = case h.pool of
  PostgresPool pool -> Postgres.mkHandle pool

list :: Handle -> { guards :: OptionalGuard, query :: FullQuery } -> Aff (TResponse MultipleDto)
list h { guards: g, query: q } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkMultipleDto)
    <$> Right
    <$> (next h).search g.maybeUserId q

feed :: Handle -> { query :: RangeQuery, guards :: AuthGuard } -> Aff (TResponse MultipleDto)
feed h { query: q, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkMultipleDto)
    <$> Right
    <$> (next h).findMostRecentFromFollowee g.userId q

get :: Handle -> { guards :: OptionalGuard, params :: Param } -> Aff (TResponse SingleDto)
get h { guards: g, params: p } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkSingleDto)
    <$> (next h).findOne g.maybeUserId p.slug

create :: Handle -> { body :: CreateDto, guards :: AuthGuard } -> Aff (TResponse SingleDto)
create h { body: b, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkSingleDto)
    <$> App.create (next h) (unwrapCreateDto b) g.userId

update :: Handle -> { body :: UpdateDto, params :: Param, guards :: AuthGuard } -> Aff (TResponse SingleDto)
update h { body: b, params: p, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkSingleDto)
    <$> App.update (next h) (unwrapUpdateDto b) p.slug g.userId

favorite :: Handle -> { params :: Param, guards :: AuthGuard } -> Aff (TResponse SingleDto)
favorite h { params: p, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkSingleDto)
    <$> App.favorite (next h) p.slug g.userId

unfavorite :: Handle -> { params :: Param, guards :: AuthGuard } -> Aff (TResponse SingleDto)
unfavorite h { params: p, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkSingleDto)
    <$> App.unfavorite (next h) p.slug g.userId

delete :: Handle -> { params :: Param, guards :: AuthGuard } -> Aff (TResponse Empty)
delete h { params: p, guards: g } =
  setHeaders g.origin
    <$> bimap renderError (\_ -> ok Empty)
    <$> (next h).delete p.slug g.userId

getTags :: Handle -> { guards :: CorsGuard } -> Aff (TResponse TagsDto)
getTags h { guards: g } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkTagsDto)
    <$> Right
    <$> (next h).findTags

renderError :: InputError -> Response String
renderError SLUG_EXISTS = unprocessableEntity $ renderErrorEntity "slug" "exists"
renderError TITLE_EXISTS = unprocessableEntity $ renderErrorEntity "title" "exists"
renderError NOT_FOUND = notFound $ renderErrorMessage "article not found"
renderError FAVORITED_EXISTS = unprocessableEntity $ renderErrorEntity "slug" "exists"
renderError SLUG_CREATION_FAILED = unprocessableEntity $ renderErrorEntity "title" "cannot be converted to slug"
