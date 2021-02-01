module Server.Article.Api.Type.Misc where

import Prelude

import Data.Array (length)
import Data.Either (Either)
import Data.Nullable (Nullable, toNullable)
import Payload.ResponseTypes (Failure, Response) as P
import Server.Article.Type.Misc (Article)
import Server.Shared.Api.Type.Misc (ArticleParam)
import Shared.Type.Misc (Bio, Body, CreatedAt, Description, Favorited, FavoritesCount, Following, Image, Slug, Tag, Title, Username, UpdatedAt)

type MultipleDto
  = { articles :: Array NullableArticle
    , articlesCount :: Int
    }

mkMultipleDto :: Array Article -> MultipleDto
mkMultipleDto articles =
  { articles: mkNullableArticle <$> articles
  , articlesCount: length articles
  }

type SingleDto
  = { article :: NullableArticle
    }

type NullableArticle
  = { author ::
        { bio :: Nullable Bio
        , following :: Following
        , image :: Nullable Image
        , username :: Username
        }
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

mkNullableArticle :: Article -> NullableArticle
mkNullableArticle a =
  { author:
      { bio: toNullable a.author.bio
      , following: a.author.following
      , image: toNullable a.author.image
      , username: a.author.username
      }
  , body: a.body
  , createdAt: a.createdAt
  , description: a.description
  , favorited: a.favorited
  , favoritesCount: a.favoritesCount
  , slug: a.slug
  , tagList: a.tagList
  , title: a.title
  , updatedAt: a.updatedAt
  }

mkSingleDto :: Article -> SingleDto
mkSingleDto a = { article: mkNullableArticle a }

type TagsDto
  = { tags :: Array Tag
    }

mkTagsDto :: Array Tag -> TagsDto
mkTagsDto = { tags: _ }


type Param
  = ArticleParam
