module Shared.Type.Misc where

import Data.Maybe (Maybe)
import Shared.Type.LongString (LongString)
import Shared.Type.LowercaseString (LowercaseString(..))
import Shared.Type.ShortString (ShortString(..))
import Timestamp (Timestamp)

type Bio
  = LongString

type Body
  = LongString

type CommentId
  = Int

type CreatedAt
  = Timestamp

type Description
  = LongString

type Email
  = ShortString

type Favorited
  = Boolean

type FavoritesCount
  = Int

type FolloweeUsername
  = ShortString

type FollowerId
  = UserId

type Following
  = Boolean

type Image
  = LongString

type Limit
  = Int

type Offset
  = Int

type Password
  = LongString

type Secret
  = String

type Slug
  = LowercaseString

type Tag
  = LowercaseString

type Title
  = ShortString

type Token
  = String

type UpdatedAt
  = Timestamp

type Username
  = ShortString

type UserId
  = Int

type Author
  = { bio :: Maybe Bio
    , following :: Following
    , image :: Maybe Image
    , username :: Username
    }
