module Server.Profile.Api.Type.Misc where

import Data.Either (Either)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toNullable)
import Payload.ResponseTypes (Failure)
import Server.Profile.Type.Misc (Profile)
import Shared.Type.Misc (Bio, Image, Username, Following)

type Dto
  = { profile ::
        { bio :: Nullable Bio
        , image :: Nullable Image
        , username :: Username
        , following :: Following
        }
    }

mkDto :: Profile -> Dto
mkDto i =
  { profile:
      { bio: toNullable i.bio
      , image: toNullable i.image
      , username: i.username
      , following: i.following
      }
  }
