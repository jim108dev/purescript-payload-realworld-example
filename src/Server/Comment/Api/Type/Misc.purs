module Server.Comment.Api.Type.Misc where

import Data.Either (Either)
import Data.Nullable (Nullable, toNullable)
import Payload.ResponseTypes (Failure)
import Server.Comment.Type.Misc (Comment)
import Shared.Type.Misc (Bio, Body, CommentId, CreatedAt, Following, Image, Slug, Username, UpdatedAt)

type MultipleDto
  = { comments :: Array Comment
    }

mkMultipleDto :: Array Comment -> MultipleDto
mkMultipleDto comments = { comments }

type MultipleResponse
  = Either Failure MultipleDto

type SingleDto
  = { comment ::
        { author ::
            { bio :: Nullable Bio
            , following :: Following
            , image :: Nullable Image
            , username :: Username
            }
        , body :: Body
        , createdAt :: CreatedAt
        , id :: CommentId
        , updatedAt :: UpdatedAt
        }
    }

mkSingleDto :: Comment -> SingleDto
mkSingleDto i =
  { comment:
      { author:
          { bio: toNullable i.author.bio
          , image: toNullable i.author.image
          , username: i.author.username
          , following: i.author.following
          }
      , body: i.body
      , createdAt: i.createdAt
      , id: i.id
      , updatedAt: i.updatedAt
      }
  }

type SingleResponse
  = Either Failure SingleDto

type Params
  = { id :: CommentId
    , slug :: Slug
    }

