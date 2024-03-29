module Server.User.Type.Misc where

import Data.Either (Either)
import Data.Maybe (Maybe, fromMaybe)
import Data.Nullable (Nullable)
import Shared.Type.Misc (Bio, Email, Image, Password, UserId, Username, Identity)
import Shared.Util.Maybe (fromMaybeNullable)

type Credentials
  = { email :: Email
    , password :: Password
    }

type Template col maybe r
  = ( bio :: col (maybe Bio)
    , email :: col Email
    , image :: col (maybe Image)
    , password :: col Password
    , username :: col Username
    | r
    )

type IdTemplate col key
  = ( id :: col (key UserId) )

--type Raw
--  = { | Template Identity Maybe () }
-- not possible because of https://github.com/purescript/purescript/issues/4105
type Raw
  = { bio :: Maybe Bio
    , email :: Email
    , image :: Maybe Image
    , password :: Password
    , username :: Username
    }

--type Patch
--  = { | Template Maybe Nullable () }
-- not possible because of https://github.com/purescript/purescript/issues/4105
type Patch
  = { bio :: Maybe (Nullable Bio)
    , email :: Maybe Email
    , image :: Maybe (Nullable Image)
    , password :: Maybe Password
    , username :: Maybe Username
    }

type User
  = { | Template Identity Maybe (IdTemplate Identity Identity) }

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
