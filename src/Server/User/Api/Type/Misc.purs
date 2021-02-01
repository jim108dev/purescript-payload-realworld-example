module Server.User.Api.Type.Misc where

import Data.Either (Either)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Payload.ResponseTypes (Failure)
import Server.User.Type.Misc (User)
import Shared.Type.Misc (Bio, Email, Image, Username, Token)

type Dto
  = { user ::
        { bio :: Nullable Bio
        , email :: Email
        , image :: Nullable Image
        , token :: Token
        , username :: Username
        }
    }

mkDto :: User -> Token -> Dto
mkDto u token =
  { user:
      { bio: toNullable u.bio
      , email: u.email
      , image: toNullable u.image
      , token
      , username: u.username
      }
  }
