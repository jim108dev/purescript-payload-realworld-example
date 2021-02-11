module Shared.Type.Misc where

import Data.Maybe (Maybe)
import Shared.Type.LongString (LongString)
import Shared.Type.LowercaseString (LowercaseString)
import Shared.Type.ShortString (ShortString)
import Timestamp (Timestamp)

type ArticleId
  = Int

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

type AuthorTemplate col
  = ( bio :: col (Maybe Bio)
    , following :: col Following
    , image :: col (Maybe Image)
    , username :: col Username
    )

type Author
  = { | AuthorTemplate Identity }

type Identity a
  = a
