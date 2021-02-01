module Server.Article.Interface.Persistence where

import Data.Either (Either)
import Data.Maybe (Maybe)
import Effect.Aff (Aff)
import Server.Article.Type.Misc (Article, FullQuery, InputError, Raw, SingleResult, RangeQuery)
import Shared.Type.Misc (FollowerId, Slug, Tag, UserId)

type Handle
  = { findMostRecentFromFollowee :: FollowerId -> RangeQuery -> Aff (Array Article)
    , findOne :: Maybe FollowerId -> Slug -> Aff SingleResult
    , findTags :: Aff (Array Tag)
    , insert :: Raw -> UserId -> Aff (Either InputError Slug)
    , update :: Raw -> Slug -> Aff (Either InputError Slug)
    , insertFavorite :: Slug -> UserId -> Aff (Either InputError Slug)
    , deleteFavorite :: Slug -> UserId -> Aff (Either InputError Slug)
    , delete :: Slug -> UserId -> Aff (Either InputError Slug) 
    , search :: Maybe FollowerId -> FullQuery -> Aff (Array Article)
    }
