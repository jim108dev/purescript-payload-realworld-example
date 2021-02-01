module Server.Article.Type.Misc where

import Data.Either (Either)
import Data.Maybe (Maybe(..), fromMaybe)
import Shared.Type.Misc (Author, Body, CreatedAt, Description, Favorited, FavoritesCount, Limit, Offset, Slug, Tag, Title, UpdatedAt)
import Shared.Type.ShortString (ShortString)

type Article
  = { author :: Author
    , body :: Body
    , createdAt :: CreatedAt
    , description :: Description
    , favorited :: Favorited
    , favoritesCount :: FavoritesCount
    , slug :: Slug
    , tagList :: Array Tag
    , title :: Title
    , updatedAt :: UpdatedAt
    }

type Raw
  = { body :: Body
    , description :: Description
    , tagList :: Maybe (Array Tag)
    , title :: Title
    }

type FullQuery
  = { author :: Maybe ShortString
    , favorited :: Maybe ShortString
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
  , tagList: Nothing
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

type SingleResult
  = Either InputError Article

type Id
  = Int
