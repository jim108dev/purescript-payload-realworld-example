module Server.Comment.Type.Misc where

import Data.Either (Either)
import Shared.Type.Misc (Author, Body, CreatedAt, UpdatedAt, CommentId)

type Raw
  = { body :: Body
    }

type Comment
  = { author :: Author
    , body :: Body
    , createdAt :: CreatedAt
    , id :: CommentId
    , updatedAt :: UpdatedAt
    }

data InputError
  = NOT_FOUND
  | EMAIL_EXITS

type SingleResult
  = Either InputError Comment
