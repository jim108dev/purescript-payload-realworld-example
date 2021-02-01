-- | This module defines bindings to the Node URL and Query String APIs.

module Node.URL where

import Data.Nullable

-- | A query object is a JavaScript object whose values are strings or arrays of strings.
-- |
-- | It is intended that the user coerce values of this type to/from some trusted representation via
-- | e.g. `Data.Foreign` or `Unsafe.Coerce`..
data Query

-- | A URL object.
-- |
-- | All fields are nullable, and will be missing if the URL string passed to
-- | `parse` did not contain the appropriate URL part.
type URL =
  { protocol :: Nullable String
  , slashes :: Nullable Boolean
  , host :: Nullable String
  , auth :: Nullable String
  , hostname :: Nullable String
  , port :: Nullable String
  , pathname :: Nullable String
  , search :: Nullable String
  , path :: Nullable String
  , query :: Nullable String
  , hash :: Nullable String
  }

-- | Parse a URL string into a URL object.
foreign import parse :: String -> URL

-- | Format a URL object as a URL string.
foreign import format :: URL -> String

-- | Resolve a URL relative to some base URL.
foreign import resolve :: String -> String -> String

-- | Convert a query string to an object.
foreign import parseQueryString :: String -> Query

-- | Convert a query string to an object.
foreign import toQueryString :: Query -> String
