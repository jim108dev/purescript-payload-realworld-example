module Server.Shared.Persistence.Type.Misc where

import Prelude

import Data.DateTime.Instant (Instant)
import Data.Maybe (Maybe(..))
import Selda (Table(..))
import Selda.Table.Constraint (Auto, Default)
import Shared.Type.Misc (ArticleId, Bio, Body, CommentId, CreatedAt, Description, Email, Image, Password, Slug, Tag, Title, UserId, Username, UpdatedAt)

type UserTable
  = Table
      ( bio :: Maybe Bio
      , email :: Email
      , id :: Auto UserId
      , image :: Maybe Image
      , password :: Password
      , username :: Username
      )

userTable :: UserTable
userTable =
  Source "user"
    $ case _ of
        Nothing -> "\"user\""
        Just alias -> "\"user\"" <> " " <> alias

type FollowingTable
  = Table ( follower_id :: UserId, followee_id :: UserId )

followingTable :: FollowingTable
followingTable = Table { name: "following" }

type CommentTable
  = Table
      ( article_id :: ArticleId
      , author_id :: UserId
      , body :: Body
      , created_at :: Auto Instant
      , id :: Auto CommentId
      , updated_at :: Auto Instant
      )

commentTable :: CommentTable
commentTable = Table { name: "comment" }

type ArticleTable
  = Table
      ( author_id :: UserId
      , body :: Body
      , created_at :: Auto Instant
      , description :: Description
      , id :: Auto ArticleId
      , slug :: Slug
      , tag_list :: Array Tag
      , title :: Title
      , updated_at :: Auto Instant
      )

articleTable :: ArticleTable
articleTable = Table { name: "article" }

type FavoritedTable
  = Table
      ( user_id :: UserId
      , article_id :: ArticleId
      )

favoritedTable :: FavoritedTable
favoritedTable = Table { name: "favorited" }

type TagTable
  = Table
      ( array :: Array Tag
      )

tagTable :: TagTable
tagTable = Table { name: "tag" }
