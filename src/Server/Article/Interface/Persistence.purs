module Server.Article.Interface.Persistence where

import Data.Either (Either)
import Data.Maybe (Maybe)
import Effect.Aff (Aff)
import Server.Article.Type.Misc (Article, FullQuery, InputError, Patch, RangeQuery, Raw)
import Shared.Type.Misc (FollowerId, Slug, Tag, UserId)

type Handle
  = { delete :: Slug -> UserId -> Aff (Either InputError Slug)
    , deleteFavorite :: Slug -> UserId -> Aff (Either InputError Article)
    , findOne :: Maybe FollowerId -> Slug -> Aff (Either InputError Article)
    , findTags :: Aff (Array Tag)
    , insert :: Raw -> UserId -> Aff (Either InputError Article)
    , insertFavorite :: Slug -> UserId -> Aff (Either InputError Article)
    , search :: Maybe FollowerId -> FullQuery -> Aff (Array Article)
    , searchMostRecentFromFollowees :: FollowerId -> RangeQuery -> Aff (Array Article)
    , update :: Patch -> Slug -> UserId -> Aff (Either InputError Article)
    }
