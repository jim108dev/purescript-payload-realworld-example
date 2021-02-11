module Server.Article.Persistence.Postgres.Type.Misc where

import Prelude
import Data.DateTime.Instant (Instant, toDateTime)
import Data.Maybe (Maybe)
import Selda (Col)
import Server.Article.Type.Misc (Id, Article)
import Shared.Type.Misc (Bio, Body, Description, Favorited, FavoritesCount, Following, Identity, Image, Slug, Tag, Title, UserId, Username)
import Timestamp (Timestamp(..))

type Template col
  = ( bio :: col (Maybe Bio)
    , body :: col Body
    , createdAt :: col Instant
    , description :: col Description
    , favorited :: col Favorited
    , favoritesCount :: col FavoritesCount
    , following :: col Following
    , id :: col Id
    , image :: col (Maybe Image)
    , title :: col Title
    , slug :: col Slug
    , tagList :: col (Array Tag)
    , updatedAt :: col Instant
    , username :: col Username
    , authorId :: col UserId
    )

type DbOutputCols s
  = { | Template (Col s) }

type DbOutput
  = { | Template Identity }

mkArticle :: DbOutput -> Article
mkArticle r =
  { author:
      { bio: r.bio
      , following: r.following
      , image: r.image
      , username: r.username
      }
  , body: r.body
  , createdAt: Timestamp $ toDateTime r.createdAt
  , description: r.description
  , favorited: r.favorited
  , favoritesCount: r.favoritesCount
  , slug: r.slug
  , tagList: r.tagList
  , title: r.title
  , updatedAt: Timestamp $ toDateTime r.updatedAt
  }
