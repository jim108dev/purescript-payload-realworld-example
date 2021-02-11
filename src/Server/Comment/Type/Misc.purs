module Server.Comment.Type.Misc where

import Shared.Type.Misc (Author, Body, CommentId, CreatedAt, UpdatedAt)

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
