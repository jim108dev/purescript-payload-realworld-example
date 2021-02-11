module Server.User.Api.Main where

import Prelude
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Payload.ResponseTypes (Response)
import Payload.Server.Response (notFound, ok, unprocessableEntity)
import Server.Shared.Api.Main (setHeaders, renderErrorEntity, renderErrorMessage)
import Server.Shared.Api.Type.Misc (AuthGuard, CorsGuard, TResponse)
import Server.Shared.Interface.Aggregate (Handle)
import Server.Shared.Type.Misc (Pool(..))
import Server.User.Api.Type.CreateDto (CreateDto, unwrapCreateDto)
import Server.User.Api.Type.LoginDto (LoginDto, unwrapLoginDto)
import Server.User.Api.Type.Misc (Dto, mkDto)
import Server.User.Api.Type.UpdateDto (UpdateDto, unwrapUpdateDto)
import Server.User.Interface.Persistence (Handle) as Persistence
import Server.User.Persistence.Postgres.Main (mkHandle) as Postgres
import Server.User.Type.Misc (InputError(..), User)

mkHandle :: Handle -> _
mkHandle h =
  { login: login h
  , create: create h
  , getCurrent: getCurrent h
  , update: update h
  , delete: delete h
  }

next :: Handle -> Persistence.Handle
next h = case h.persistence.pool of
  PostgresPool pool -> Postgres.mkHandle pool

login :: Handle -> { body :: LoginDto, guards :: CorsGuard } -> Aff (TResponse Dto)
login h { body: body, guards: g } =
  setHeaders g.origin
    <$> ((next h).findByCredentials (unwrapLoginDto body) >>= mkTResponse h)

create :: Handle -> { body :: CreateDto, guards :: CorsGuard } -> Aff (TResponse Dto)
create h { body: body, guards: g } =
  setHeaders g.origin
    <$> ((next h).insert (unwrapCreateDto body) >>= mkTResponse h)

getCurrent :: Handle -> { guards :: AuthGuard } -> Aff (TResponse Dto)
getCurrent h { guards: g } =
  setHeaders g.origin
    <$> ((next h).findById g.userId >>= mkTResponse h)

update :: Handle -> { body :: UpdateDto, guards :: AuthGuard } -> Aff (TResponse Dto)
update h { guards: g, body } =
  setHeaders g.origin
    <$> ((next h).update (unwrapUpdateDto body) g.userId >>= mkTResponse h)

delete :: Handle -> { guards :: AuthGuard } -> Aff (TResponse Dto)
delete h { guards: g } =
  setHeaders g.origin
    <$> ((next h).delete g.userId >>= mkTResponse h)

mkTResponse :: Handle -> Either InputError User -> Aff (TResponse Dto)
mkTResponse h appResult = case appResult of
  Left e -> pure $ Left $ renderError e
  Right user -> Right <$> ok <$> mkDto user <$> h.token.encode user.id

renderError :: InputError -> Response String
renderError EMAIL_EXISTS = unprocessableEntity $ renderErrorEntity "email" "exists"
renderError USERNAME_EXISTS = unprocessableEntity $ renderErrorEntity "username" "exists"
renderError NOT_FOUND = notFound $ renderErrorMessage "user not found"
