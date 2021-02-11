module Server.Shell.Api.Main where

import Server.Article.Api.Main (mkHandle) as Article
import Server.Comment.Api.Main (mkHandle) as Comment
import Server.Profile.Api.Main (mkHandle) as Profile
import Server.Shared.Api.Main (options)
import Server.Shared.Interface.Aggregate (Handle)
import Server.Shell.Api.Guards (mkHandle) as Guard
import Server.User.Api.Main (mkHandle) as User

mkHandle :: Handle -> _
mkHandle h =
  { handlers:
      { article: Article.mkHandle h.persistence
      , comment: Comment.mkHandle h.persistence
      , profile: Profile.mkHandle h.persistence
      , shared: { options: options }
      , user: User.mkHandle h
      }
  , guards: Guard.mkHandle h.token
  }

--,  --,
