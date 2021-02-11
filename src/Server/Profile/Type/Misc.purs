module Server.Profile.Type.Misc where

import Data.Maybe (Maybe)
import Shared.Type.Misc (Bio, Image, Username, Identity)

type Template col
  = ( bio :: col (Maybe Bio)
    , following :: col Boolean
    , image :: col (Maybe Image)
    , username :: col Username
    )

type Profile
  = { | Template Identity }

data InputError
  = NOT_FOUND
  | FOLLOWER_EQUALS_FOLLOWEE
  | FOLLOWING_EXISTS
