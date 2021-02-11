module Server.Profile.Interface.Persistence where

import Data.Either (Either)
import Data.Maybe (Maybe)
import Effect.Aff (Aff)
import Server.Profile.Type.Misc (InputError, Profile)
import Shared.Type.Misc (FolloweeUsername, FollowerId)

type Handle
  = { findFollowee :: Maybe FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
    , insertFollower :: FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
    , deleteFollower :: FollowerId -> FolloweeUsername -> Aff (Either InputError Profile)
    }
