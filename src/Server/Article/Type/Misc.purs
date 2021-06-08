module Server.Article.Type.Misc where

import Data.Maybe (Maybe, fromMaybe)
import Shared.Type.Misc (ArticleId, AuthorTemplate, Body, CreatedAt, Description, Favorited, FavoritesCount, Identity, Limit, Offset, Slug, Tag, Title, UpdatedAt, Username)

type RawTemplate col
  = ( body :: col Body
    , description :: col Description
    , tagList :: col (Array Tag)
    , title :: col Title
    )

--type Raw
--  = { | RawTemplate Identity }
-- not possible because of https://github.com/purescript/purescript/issues/4105
type Raw
  = { body :: Body
    , description :: Description
    , tagList :: Array Tag
    , title :: Title
    }

type Template col
  = ( author :: { | AuthorTemplate col }
    , body :: col Body
    , description :: col Description
    , tagList :: col (Array Tag)
    , title :: col Title
    , createdAt :: col CreatedAt
    , favorited :: col Favorited
    , favoritesCount :: col FavoritesCount
    , slug :: col Slug
    , updatedAt :: col UpdatedAt
    )

type Article
  = { | Template Identity }

type FullQuery
  = { author :: Maybe Username
    , favorited :: Maybe Username
    , limit :: Maybe Limit
    , offset :: Maybe Offset
    , tag :: Maybe Tag
    }

type Patch
  = { body :: Maybe Body
    , description :: Maybe Description
    , title :: Maybe Title
    }

mkRawFromPatch :: Article -> Patch -> Raw
mkRawFromPatch f p =
  { body: fromMaybe f.body p.body
  , description: fromMaybe f.description p.description
  , title: fromMaybe f.title p.title
  , tagList: f.tagList
  }

type RangeQuery
  = { limit :: Maybe Limit
    , offset :: Maybe Offset
    }

data InputError
  = SLUG_EXISTS
  | TITLE_EXISTS
  | NOT_FOUND
  | FAVORITED_EXISTS
  | SLUG_CREATION_FAILED

type Id
  = ArticleId
