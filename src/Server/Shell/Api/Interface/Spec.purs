module Server.Shell.Api.Interface.Spec where

import Payload.Spec (OPTIONS)
import Payload.Spec as Payload
import Server.Article.Api.Interface.Spec (Routes) as Article
import Server.Comment.Api.Interface.Spec (Routes) as Comment
import Server.Profile.Api.Interface.Spec (Routes) as Profile
import Server.Shared.Api.Interface.Spec (CorsGuard)
import Server.Shared.Api.Type.Misc (Guards, WildcardParam)
import Server.User.Api.Interface.Spec (Routes) as User

type Spec
  = { guards :: Guards
    , routes ::
        { article :: Article.Routes
        , comment :: Comment.Routes
        , profile :: Profile.Routes
        , shared :: CorsRoutes
        , user :: User.Routes
        }
    }

-- 
type CorsRoutes
  = Payload.Routes "/api"
      { guards :: CorsGuard
      , options :: OPTIONS "/<..wildcard>" { params :: WildcardParam }
      }

spec :: Payload.Spec Spec
spec = Payload.Spec
