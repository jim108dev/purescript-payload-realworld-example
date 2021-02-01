module Server.Article.Api.Interface.Spec where

import Payload.Spec (DELETE, GET, POST, PUT)
import Payload.Spec (Routes) as Payload
import Server.Article.Api.Type.CreateDto (CreateDto)
import Server.Article.Api.Type.Misc (MultipleDto, Param, SingleDto, TagsDto)
import Server.Article.Api.Type.UpdateDto (UpdateDto)
import Server.Article.Type.Misc (FullQuery, RangeQuery)
import Server.Shared.Api.Interface.Spec (AuthGuard, OptionalGuard, CorsGuard)

type Routes
  = Payload.Routes "/api"
      { guards :: CorsGuard
      , list ::
          GET "/articles?tag=<tag>&author=<author>&favorited=<favorited>&limit=<limit>&offset=<offset>"
            { guards :: OptionalGuard
            , query :: FullQuery
            , response :: MultipleDto
            }
      , feed ::
          GET "/articles/feed?limit=<limit>&offset=<offset>"
            { guards :: AuthGuard
            , query :: RangeQuery
            , response :: MultipleDto
            }
      , get ::
          GET "/articles/<slug>"
            { guards :: OptionalGuard
            , params :: Param
            , response :: SingleDto
            }
      , create ::
          POST "/articles"
            { body :: CreateDto
            , guards :: AuthGuard
            , response :: SingleDto
            }
      , update ::
          PUT "/articles/<slug>"
            { body :: UpdateDto
            , guards :: AuthGuard
            , params :: Param
            , response :: SingleDto
            }
      , delete ::
          DELETE "/articles/<slug>"
            { guards :: AuthGuard
            , params :: Param
            }
      , favorite ::
          POST "/articles/<slug>/favorite"
            { guards :: AuthGuard
            , params :: Param
            , response :: SingleDto
            }
      , unfavorite ::
          DELETE "/articles/<slug>/favorite"
            { guards :: AuthGuard
            , params :: Param
            , response :: SingleDto
            }
      , getTags ::
          GET "/tags"
            { response :: TagsDto
            }
      }
