module Server.User.Api.Interface.Spec where

import Payload.Spec (DELETE, GET, POST, PUT, OPTIONS)
import Payload.Spec (Routes) as Payload
import Server.Shared.Api.Interface.Spec (AuthGuard, CorsGuard)
import Server.Shared.Api.Type.Misc (WildcardParam)
import Server.User.Api.Type.CreateDto (CreateDto)
import Server.User.Api.Type.LoginDto (LoginDto)
import Server.User.Api.Type.Misc (Dto)
import Server.User.Api.Type.UpdateDto (UpdateDto)

type Routes
  = Payload.Routes "/api"
      { guards :: CorsGuard
      , login ::
          POST "/users/login"
            { body :: LoginDto
            , response :: Dto
            }
      , create ::
          POST "/users"
            { body :: CreateDto
            , response :: Dto
            }
      , getCurrent ::
          GET "/user"
            { guards :: AuthGuard
            , response :: Dto
            }
      , update ::
          PUT "/user"
            { guards :: AuthGuard
            , body :: UpdateDto
            , response :: Dto
            }
      , delete ::
          DELETE "/user"
            { guards :: AuthGuard
            , response :: Dto
            }
      }
