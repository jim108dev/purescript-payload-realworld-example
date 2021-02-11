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

type Raw
  = { | Template Identity Maybe () }

type Patch
  = { | Template Maybe Nullable () }

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
