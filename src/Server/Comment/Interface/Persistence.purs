module Server.Comment.Interface.Persistence where

import Data.Either (Either)
import Data.Maybe (Maybe)
import Effect.Aff (Aff)
import Server.Comment.Type.Misc (Comment, InputError, Raw, SingleResult)
import Shared.Type.Misc (CommentId, Slug, UserId)

type Handle
  = { delete :: CommentId -> Slug -> Aff (Either InputError CommentId)
    , insert :: UserId -> Raw -> Slug -> Aff SingleResult
    , search :: Maybe UserId -> Slug -> Aff (Array Comment)
    }

