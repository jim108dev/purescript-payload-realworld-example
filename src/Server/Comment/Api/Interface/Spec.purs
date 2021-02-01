module Server.Comment.Api.Interface.Spec where

import Payload.Spec (DELETE, GET, POST)
import Payload.Spec (Routes) as Payload
import Server.Comment.Api.Type.CreateDto (CreateDto)
import Server.Comment.Api.Type.Misc (MultipleDto, SingleDto, Params)
import Server.Shared.Api.Interface.Spec (AuthGuard, OptionalGuard, CorsGuard)
import Server.Shared.Api.Type.Misc (ArticleParam)

type Routes
  = Payload.Routes "/api/articles"
      { guards :: CorsGuard
      , create ::
          POST "/<slug>/comments"
            { body :: CreateDto
            , params :: ArticleParam
            , guards :: AuthGuard
            , response :: SingleDto
            }
      , delete ::
          DELETE "/<slug>/comments/<id>"
            { guards :: AuthGuard
            , params :: Params
            }
      , get ::
          GET "/<slug>/comments"
            { guards :: OptionalGuard
            , params :: ArticleParam
            , response :: MultipleDto
            }
      }
