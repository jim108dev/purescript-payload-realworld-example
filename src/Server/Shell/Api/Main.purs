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
      { user: User.mkHandle h
      , profile: Profile.mkHandle h.persistence
      , article: Article.mkHandle h.persistence
      , comment: Comment.mkHandle h.persistence
      , shared: { options: options }
      }
  , guards: Guard.mkHandle h.token
  }
