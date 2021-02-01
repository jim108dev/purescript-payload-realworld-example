module Server.Shared.Api.Type.Misc where

import Data.Either (Either)
import Data.List (List)
import Data.Maybe (Maybe)
import Payload.ResponseTypes (Failure, Response) as P
import Shared.Type.Misc (Slug, UserId, Username)
import Shared.Type.ShortString (ShortString)

type AuthGuard
  = { userId :: UserId, origin :: String }

type OptionalGuard
  = { maybeUserId :: Maybe UserId, origin :: String }

type CorsGuard
  = { origin :: String }

type Guards
  = { userId :: UserId, maybeUserId :: Maybe UserId, origin :: Origin }

type UserParam
  = { username :: Username }

type ArticleParam
  = { slug :: Slug }

type WildcardParam
  = { wildcard :: List String }

type Origin
  = String

type TResponse a
  = Either (P.Response String) (P.Response a)
