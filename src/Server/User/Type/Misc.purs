module Server.User.Type.Misc where

import Data.Either (Either)
import Data.Maybe (Maybe, fromMaybe)
import Data.Nullable (Nullable)
import Shared.Type.Misc (Bio, Email, Image, Password, Username, UserId)
import Shared.Util.Maybe (fromMaybeNullable)

type Credentials
  = { email :: Email
    , password :: Password
    }

type Raw
  = { bio :: Maybe Bio
    , email :: Email
    , image :: Maybe Image
    , password :: Password
    , username :: Username
    }

type Patch
  = { bio :: Maybe (Nullable Bio)
    , email :: Maybe Email
    , image :: Maybe (Nullable Image)
    , password :: Maybe Password
    , username :: Maybe Username
    }

type User
  = { bio :: Maybe Bio
    , email :: Email
    , id :: UserId
    , image :: Maybe Image
    , password :: Password
    , username :: Username
    }

mkRawFromPatch :: User -> Patch -> Raw
mkRawFromPatch f p =
  { bio: fromMaybeNullable f.bio p.bio
  , email: fromMaybe f.email p.email
  , image: fromMaybeNullable f.image p.image
  , password: fromMaybe f.password p.password
  , username: fromMaybe f.username p.username
  }

data InputError
  = EMAIL_EXISTS
  | USERNAME_EXISTS
  | NOT_FOUND

type Result
  = Either InputError User
