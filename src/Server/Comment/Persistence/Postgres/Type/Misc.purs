module Server.Comment.Persistence.Postgres.Type.Misc where

import Prelude
import Data.DateTime.Instant (Instant, toDateTime)
import Data.Maybe (Maybe)
import Selda (Col)
import Server.Comment.Type.Misc (Comment)
import Shared.Type.Misc (Bio, Body, CommentId, Following, Identity, Image, Username)
import Timestamp (Timestamp(..))

type Template col
  = ( bio :: col (Maybe Bio)
    , body :: col Body
    , createdAt :: col Instant
    , following :: col Following
    , id :: col CommentId
    , image :: col (Maybe Image)
    , updatedAt :: col Instant
    , username :: col Username
    )

type DbOutputCols s
  = { | Template (Col s) }

type DbOutput
  = { | Template Identity }

mkComment :: DbOutput -> Comment
mkComment r =
  { author:
      { bio: r.bio
      , following: r.following
      , image: r.image
      , username: r.username
      }
  , body: r.body
  , createdAt: Timestamp $ toDateTime r.createdAt
  , id: r.id
  , updatedAt: Timestamp $ toDateTime r.updatedAt
  }
