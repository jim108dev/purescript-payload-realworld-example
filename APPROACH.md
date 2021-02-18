# Approach

This file contains some comments about the decisions which were made.

## Source code file and folder structure

1. The goals are:
   1. Minimal source code repetition which includes a minimal amount of boilerplate code.  
   1. Short names.
   1. Short files.
   1. Expectable behavior.
   1. Minimal costs of changes, especially of infrastructure changes.
   1. Easily testable via command line tools and automated tests.

1. The general source code file and folder structure is `<src-folder>/<app>/<domain>/<layer>/<file>`.
    1. `<src-folder>`:
       1. `config`: For config files.  
       1. `sql`: Contains sql scripts for development and database setup.
       1. `src`: PureScript and JavaScript development source files.
       1. `test`: PureScript and Json source files for testing. Test can depend on `src` but not vice versa.
    1. `<app>`:
        1. `Client`: Code which is only used in the client application. (Not implemented)
        1. `Server`: Code which is only used in the server application. `Server` can only depend on `Shared`. The entry point for the server application is called `Main.purs`
        1. `Shared`: Code which is of general usage.
    1. `<domain>`:
        1. `Shell`: For the entry point of the application and to direct to other domains. `Shell` can depend on other domains. Other domains cannot depend on `Shell`
        1. `User` etc.: Domain code. The domain should be independent. Function names should be equal across domains with different signature depending on the context.
        1. `Shared`: Code which can be used by all domains. Other domains can depend on `Shared`. `Shared` cannot depend on other domains.
    1. `<layer>`:
        1. `Api`: Entry  points of requests and validation logic. This layer can depend on `Application`.
        1. `Application`: Business application layer. Effects can only be used with interfaces. If the business logic is just one call to another layer, the call is made directly and the declaration in `Application` is omitted.
        1. `Interface`: Interfaces for persistence or application functions.
        1. `Persistence`: Persistence/storage/database layer.
        1. `Util`: Holds util functions. They can be accessed via interfaces.
        1. `Type`: Holds types which can be used by all layers of the domain. If a type is only used by one layer, it is placed directly under this layer.
    1. `<file>`:
       1. If there can be multiple implementations of the same layer, a distinct name is used.
       1. `Main.purs` refers to the general implementation/entrance point of a folder.
       1. The ideal file length is two pages. Simple types are usually shorter, that's why they are placed under `Misc.purs`.
       1. The handle pattern was used for dependency injection [(Van der Jeugt, 2018)](https://jaspervdj.be/posts/2018-03-08-handle-pattern.html).
          1. The structure for holding the dependencies is called `Handle`.
          1. The function for getting an implementations is called `mkHandle`.
          1. The namespace for aggregating two or more handles is called `Aggregate`.
       1. The source code is written for qualified import, which is also mentioned at [(Van der Jeugt, 2018)](https://jaspervdj.be/posts/2018-03-08-handle-pattern.html).
          1. Actual Qualifiers like `import ... as Payload` should be used sparingly because they can't be created automatically by the *PureScript VS Code IDE*. Also the names are arbitrary.
       1. The expression order in a code line should be from right to left.
       1. If the order of parameters, arrays, records, etc. is arbitrary, it should be ordered alphabetically in the source code.

## Comments

1. PostgreSQL:
   1. In order to create type-safe sql queries [purescript-selda](https://github.com/Kamirus/purescript-selda) was used.
   1. As of the time of writing, there was a bug in the update functionality. (See [issue](https://github.com/Kamirus/purescript-selda/issues/42)) This is causing the update tests to fail.
   1. As of the time of writing, the `offset` clause was not implemented. (See [issue](https://github.com/Kamirus/purescript-selda/issues/50))
1. PureScript Payload:
   1. The `Failure` type did not fit for CORS, because it requires a custom header with every request.
   1. Payload does not output validation errors. In order to see them, Payload was patched. (Compare <https://github.com/hoodunit/purescript-payload/compare/master...jim108dev:master>)
   1. Payload did not support post requests with an empty body. This was also patched.
1. Validation:
   1. [purescript-simple-json](https://github.com/justinwoo/purescript-simple-json) is used for JSON encoding/decoding because it doesn't require to specify the order of fields. Because the error field is dynamic the error structure is rendered with simple string concatenation (see [src/Server/Shared/Api/Main.purs](./src/Server/Shared/Api/Main.purs)). This could be improved.
   1. Strings are represented by:
      1. `LongString`: Between 1 and 1000 characters. The database type is unrestricted (`TEXT`).
      1. `LowercaseString`: Forces strings to be lowercase, e.g. for tags. The database type is unrestricted and case-insensitive (`CITEXT`).
      1. `ShortString`: Between 1 and 50 characters. The database type is unrestricted (`TEXT`).
   1. In order to safe on boilerplate code, all simple types like `UserId` are coded with `type` instead of `newtype`.
1. Security:
   1. [purescript-node-jwt](https://github.com/gaku-sei/purescript-node-jwt) is used for token encoding/decoding. Only userId is encoded used. The expiration time is set to 1 hour.
1. Tests:
   1. Setting `origin` in the tests was not possible (Error message: `Refused to set unsafe header "origin"`). I had to mock the function.
   1. The test case request and response bodies can be found under `test/Server/<domain>/<file>`. This way, they can be used via *HTTPie* and with automated testing.
1. Frontend:
   1. [purescript-halogen-realword](https://github.com/thomashoneyman/purescript-halogen-realworld) did not work for update user and post comments. See ([issue](https://github.com/thomashoneyman/purescript-halogen-realworld/issues/78)).
