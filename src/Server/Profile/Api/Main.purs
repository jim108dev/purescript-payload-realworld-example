module Server.Profile.Api.Main where

import Prelude
import Data.Bifunctor (bimap)
import Effect.Aff (Aff)
import Payload.ResponseTypes (Response)
import Payload.Server.Response (notFound, ok, unprocessableEntity)
import Server.Profile.Api.Type.Misc (Dto, mkDto)
import Server.Profile.Interface.Persistence (Handle) as Persistence
import Server.Profile.Persistence.Postgres (mkHandle) as Postgres
import Server.Profile.Type.Misc (InputError(..))
import Server.Shared.Api.Main (setHeaders, renderErrorMessage)
import Server.Shared.Api.Type.Misc (AuthGuard, OptionalGuard, TResponse, UserParam)
import Server.Shared.Interface.Persistence (Handle)
import Server.Shared.Type.Misc (Pool(..))

mkHandle :: Handle -> _
mkHandle h =
  { byUsername:
      { get: get h
      , follow: follow h
      , unfollow: unfollow h
      }
  }

next :: Handle -> Persistence.Handle
next h = case h.pool of
  PostgresPool pool -> Postgres.mkHandle pool

get :: Handle -> { guards :: OptionalGuard, params :: UserParam } -> Aff (TResponse Dto)
get h { guards: g, params: p } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkDto)
    <$> (next h).findFollowee g.maybeUserId p.username

follow :: Handle -> { guards :: AuthGuard, params :: UserParam } -> Aff (TResponse Dto)
follow h { guards: g, params: p } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkDto)
    <$> (next h).insertFollower g.userId p.username

unfollow :: Handle -> { guards :: AuthGuard, params :: UserParam } -> Aff (TResponse Dto)
unfollow h { guards: g, params: p } =
  setHeaders g.origin
    <$> bimap renderError (ok <<< mkDto)
    <$> (next h).deleteFollower g.userId p.username

renderError :: InputError -> Response String
renderError NOT_FOUND = notFound $ renderErrorMessage "profile not found"
renderError FOLLOWER_EQUALS_FOLLOWEE = unprocessableEntity $ renderErrorMessage "follower must be different from followee"
renderError FOLLOWING_EXISTS = unprocessableEntity $ renderErrorMessage "already following"
