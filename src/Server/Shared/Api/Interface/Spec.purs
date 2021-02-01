module Server.Shared.Api.Interface.Spec where

import Payload.Spec (type (:), Guards, Nil)

type AuthGuard
  = Guards ("userId" : Nil)

type OptionalGuard
  = Guards ("maybeUserId" : Nil)

type CorsGuard
  = Guards ("origin" : Nil)
