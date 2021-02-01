module Server.Profile.Api.Interface.Spec where

import Payload.Spec (DELETE, GET, POST, OPTIONS)
import Payload.Spec (Routes) as Payload
import Server.Profile.Api.Type.Misc (Dto)
import Server.Shared.Api.Interface.Spec (AuthGuard, OptionalGuard, CorsGuard)
import Server.Shared.Api.Type.Misc (UserParam, WildcardParam)

type Routes
  = Payload.Routes "/api/profiles"
      { guards :: CorsGuard
      , byUsername ::
          Payload.Routes "/<username>"
            { params :: UserParam
            , get ::
                GET "/"
                  { guards :: OptionalGuard
                  , response :: Dto
                  }
            , follow ::
                POST "/follow"
                  { guards :: AuthGuard
                  , response :: Dto
                  }
            , unfollow ::
                DELETE "/follow"
                  { guards :: AuthGuard
                  , response :: Dto
                  }
            }
      }
