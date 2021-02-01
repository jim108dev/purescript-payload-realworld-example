module Server.Article.Application.Main where

import Prelude

import Control.Monad.Except (ExceptT(..), runExceptT)
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Server.Article.Interface.Persistence (Handle)
import Server.Article.Type.Misc (Patch, Raw, SingleResult, mkRawFromPatch)
import Shared.Type.Misc (Slug, UserId)

create :: Handle -> Raw -> UserId -> Aff SingleResult
create h raw userId =
  runExceptT do
    s <- ExceptT $ h.insert raw userId
    ExceptT $ h.findOne (Just userId) s

update :: Handle -> Patch -> Slug -> UserId -> Aff SingleResult
update h patch slug userId =
  runExceptT do
    fallback <- ExceptT $ h.findOne (Just userId) slug
    updatedSlug <- ExceptT $ h.update (mkRawFromPatch fallback patch) slug
    ExceptT $ h.findOne (Just userId) updatedSlug

favorite :: Handle -> Slug -> UserId -> Aff SingleResult
favorite h slug userId =
  runExceptT do
    s <- ExceptT $ h.insertFavorite slug userId
    ExceptT $ h.findOne (Just userId) s

unfavorite :: Handle -> Slug -> UserId -> Aff SingleResult
unfavorite h slug userId =
  runExceptT do
    s <- ExceptT $ h.deleteFavorite slug userId
    ExceptT $ h.findOne (Just userId) s
