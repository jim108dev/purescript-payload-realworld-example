module Server.Profile.Type.Misc where

import Data.Maybe (Maybe)
import Shared.Type.Misc (Bio, Username, Image)

type Profile
  = { bio :: Maybe Bio
    , image :: Maybe Image
    , following :: Boolean
    , username :: Username
    }

data InputError
  = NOT_FOUND
  | FOLLOWER_EQUALS_FOLLOWEE
  | FOLLOWING_EXISTS
