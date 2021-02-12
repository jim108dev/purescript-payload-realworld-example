# RealWorld API Spec

## Running API tests locally

To locally run the provided Postman collection against your backend, execute:

```text
APIURL=http://localhost:3000/api ./run-api-tests.sh
```

For more details, see [`run-api-tests.sh`](run-api-tests.sh).

## Considerations for your backend with [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)

If the backend is about to run on a different host/port than the frontend, make sure to handle `OPTIONS` too and return correct `Access-Control-Allow-Origin` and `Access-Control-Allow-Headers` (e.g. `Content-Type`).

### Authentication Header

`Authorization: Token jwt.token.here`

## JSON Objects returned by API

Make sure the right content type like `Content-Type: application/json; charset=utf-8` is correctly returned.

### Users (for authentication)

```JSON
{
"user": {
    "email": "jake@jake.jake",
    "token": "jwt.token.here",
    "username": "jake",
    "bio": "I work at statefarm",
    "image": null
}
}
```

### Profile

```JSON
{
  "profile": {
    "username": "jake",
    "bio": "I work at statefarm",
    "image": "https://static.productionready.io/images/smiley-cyrus.jpg",
    "following": false
  }
}
```

### Single Article

```JSON
{
  "article": {
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }
}
```

### Multiple Articles

```JSON
{
  "articles":[{
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }, {
    "slug": "how-to-train-your-dragon-2",
    "title": "How to train your dragon 2",
    "description": "So toothless",
    "body": "It a dragon",
    "tagList": ["dragons", "training"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "favorited": false,
    "favoritesCount": 0,
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }],
  "articlesCount": 2
}
```

### Single Comment

```JSON
{
  "comment": {
    "id": 1,
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:22:56.637Z",
    "body": "It takes a Jacobian",
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }
}
```

### Multiple Comments

```JSON
{
  "comments": [{
    "id": 1,
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:22:56.637Z",
    "body": "It takes a Jacobian",
    "author": {
      "username": "jake",
      "bio": "I work at statefarm",
      "image": "https://i.stack.imgur.com/xHWG8.jpg",
      "following": false
    }
  }]
}
```

### List of Tags

```JSON
{
  "tags": [
    "reactjs",
    "angularjs"
  ]
}
```

### Errors and Status Codes

If a request fails any validations, expect a 422 and errors in the following format:

```JSON
{
  "errors":{
    "body": [
      "can't be empty"
    ]
  }
}
```

#### Other status codes

401 for Unauthorized requests, when a request requires authentication but it isn't provided

403 for Forbidden requests, when a request may be valid but the user doesn't have permissions to perform the action

404 for Not found requests, when a resource can't be found to fulfill the request

## Endpoints

### Authentication

1. Spec.:

    `POST /api/users/login`

    Example request body:

    ```JSON
    {
    "user":{
        "email": "jake@jake.jake",
        "password": "jakejake"
    }
    }
    ```

    No authentication required, returns a [User](#users-for-authentication)

    Required fields: `email`, `password`

1. Tests calls:

    ```sh
    http POST http://localhost:3000/api/users/login < test/Server/User/LoginSuccessRequest.json Origin:"http://example.com"
    http POST http://localhost:3000/api/users/login < test/Server/User/LoginFail... Origin:"http://example.com"
    ```

### Registration

1. Spec.:

    `POST /api/users`

    Example request body:

    ```JSON
    {
    "user":{
        "username": "Jacob",
        "email": "jake@jake.jake",
        "password": "jakejake"
    }
    }
    ```

    No authentication required, returns a [User](#users-for-authentication)

    Required fields: `email`, `username`, `password`

1. Tests calls:

    ```sh
    http POST http://localhost:3000/api/users < test/Server/User/RegisterSuccessRequest.json Origin:"http://example.com"
    ```

### Get Current User

1. Spec.:

    `GET /api/user`

    Authentication required, returns a [User](#users-for-authentication) that's the current user

1. Tests calls:

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" GET http://localhost:3000/api/user Origin:"http://example.com"

    http --auth-type=jwt --auth="INVALID TOKEN" GET http://localhost:3000/api/user Origin:"http://example.com"
    ```

### Update User

1. Spec.:

    `PUT /api/user`

    Example request body:

    ```JSON
    {
    "user":{
        "email": "jake@jake.jake",
        "bio": "I like to skateboard",
        "image": "https://i.stack.imgur.com/xHWG8.jpg"
    }
    }
    ```

    Authentication required, returns the [User](#users-for-authentication)

    Accepted fields: `email`, `username`, `password`, `image`, `bio`

1. Tests calls:

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" PUT http://localhost:3000/api/user < test/Server/User/UpdateSuccessRequest.json Origin:"http://example.com"
    ```

### Get Profile

1. Spec.:

    `GET /api/profiles/:username`

    Authentication optional, returns a [Profile](#profile)

1. Test calls:

    ```sh
    http  --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjJ9.qljK8m23kwkwi9meZhbt11CeYCvdd9F55_1RJWZ-ggs" GET http://localhost:3000/api/profiles/jim Origin:"http://example.com"
    ```

### Follow user

1. Spec.:

  `POST /api/profiles/:username/follow`

  Authentication required, returns a [Profile](#profile)

  No additional parameters required

1. Test calls:

    ```sh
    http  --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" POST http://localhost:3000/api/profiles/jim/follow Origin:"http://example.com"
    ```

### Unfollow user

1. Spec.:

  `DELETE /api/profiles/:username/follow`

  Authentication required, returns a [Profile](#profile)

  No additional parameters required

1. Test calls:

    ```sh
    http  --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" DELETE http://localhost:3000/api/profiles/jim/follow Origin:"http://example.com"
    ```

### List Articles

1. Spec.:

  `GET /api/articles`

  Returns most recent articles globally by default, provide `tag`, `author` or `favorited` query parameter to filter results

  Query Parameters:

  Filter by tag:

  `?tag=AngularJS`

  Filter by author:

  `?author=jake`

  Favorited by user:

  `?favorited=jake`

  Limit number of articles (default is 20):

  `?limit=20`

  Offset/skip number of articles (default is 0):

  `?offset=0`

  Authentication optional, will return [multiple articles](#multiple-articles), ordered by most recent first

1. Test calls:

    ```sh
    http GET "http://localhost:3000/api/articles?tag=AngularJS&author=jake&favorited=jake&limit=1&offset=1"  Origin:"http://example.com"
    http GET "http://localhost:3000/api/articles?author=Jake" Origin:"http://example.com"
    ```

### Feed Articles

1. Spec.:

  `GET /api/articles/feed`

  Can also take `limit` and `offset` query parameters like [List Articles](#list-articles)

  Authentication required, will return [multiple articles](#multiple-articles) created by followed users, ordered by most recent first.
  
1. Test calls:

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" GET "http://localhost:3000/api/articles/feed?limit=100&offset=0" Origin:"http://example.com"
    ```

1. Minor Problem: The log displays two matches:

  ```log
  GET api/articles/feed -> 2 matches:
  GET /api/articles/feed
  GET /api/articles/<slug>
  ```

### Get Article

1. Spec.:

  `GET /api/articles/:slug`

  No authentication required, will return [single article](#single-article)

1. Test calls:

    ```sh
    http GET "http://localhost:3000/api/articles/how-to-train-your-dragon" Origin:"http://example.com"
    ```

### Create Article

1. Spec.:

  `POST /api/articles`

  Example request body:

  ```JSON
  {
    "article": {
      "title": "How to train your dragon",
      "description": "Ever wonder how?",
      "body": "You have to believe",
      "tagList": ["reactjs", "angularjs", "dragons"]
    }
  }
  ```

  Authentication required, will return an [Article](#single-article)

  Required fields: `title`, `description`, `body`

  Optional fields: `tagList` as an array of Strings

1. Test calls

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" POST "http://localhost:3000/api/articles" < test/Server/Article/CreateSuccessRequest.json Origin:"http://example.com"
    ```

### Update Article

1. Spec.:

  `PUT /api/articles/:slug`

  Example request body:

  ```JSON
  {
    "article": {
      "title": "Did you train your dragon?"
    }
  }
  ```

  Authentication required, returns the updated [Article](#single-article)

  Optional fields: `title`, `description`, `body`

  The `slug` also gets updated when the `title` is changed

1. Test calls

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" PUT "http://localhost:3000/api/articles/how-to-train-your-dragon" < test/Server/Article/UpdateSuccessRequest.json Origin:"http://example.com"
    ```

### Delete Article

1. Spec.:

  `DELETE /api/articles/:slug`

  Authentication required

1. Test calls:

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" DELETE "http://localhost:3000/api/articles/how-to-train-your-dragon" Origin:"http://example.com"
    ```

### Add Comments to an Article

1. Spec.:

  `POST /api/articles/:slug/comments`

  Example request body:

  ```JSON
  {
    "comment": {
      "body": "His name was my name too."
    }
  }
  ```

  Authentication required, returns the created [Comment](#single-comment)

  Required field: `body`

1. Tests calls:

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" POST http://localhost:3000/api/articles/how-to-train-your-dragon/comments  < test/Server/Comment/CreateSuccessRequest.json  Origin:"http://example.com"
    ```

### Get Comments from an Article

1. Spec.:

  `GET /api/articles/:slug/comments`

  Authentication optional, returns [multiple comments](#multiple-comments)

1. Tests calls:

    ```sh
    http GET http://localhost:3000/api/articles/how-to-train-your-dragon/comments
    ```

### Delete Comment

1. Spec.:

  `DELETE /api/articles/:slug/comments/:id`

  Authentication required

1. Tests calls:

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" DELETE http://localhost:3000/api/articles/how-to-train-your-dragon/comments/3 Origin:"http://example.com"
    ```

### Favorite Article

1. Spec.:

  `POST /api/articles/:slug/favorite`

  Authentication required, returns the [Article](#single-article)

  No additional parameters required

1. Test calls:

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" POST "http://localhost:3000/api/articles/how-to-train-your-dragon/favorite" Origin:"http://example.com"
    ```

### Unfavorite Article

1. Spec.:

  `DELETE /api/articles/:slug/favorite`

  Authentication required, returns the [Article](#single-article)

  No additional parameters required

1. Test calls:

    ```sh
    http --auth-type=jwt --auth="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE4OTM0NTYwMDAsImV4cCI6MTg5MzQ1OTYwMCwiaWQiOjF9.JQvMz3rD-dhVLz3ooHBob5quAZHkBMAHKAShNv1-BMo" DELETE "http://localhost:3000/api/articles/how-to-train-your-dragon/favorite" Origin:"http://example.com"
    ```

### Get Tags

1. Spec.:

  `GET /api/tags`

  No authentication required, returns a [List of Tags](#list-of-tags)

1. Test calls:

  ```sh
  http GET http://localhost:3000/api/tags Origin:"http://example.com"
  ```
