-- | This module provides a way of dealing with the JS idiom of options
-- | objects in PureScript, by giving you the tools to provide a reasonably
-- | comfortable typed layer on top of JavaScript APIs which make use of this
-- | idiom.
-- |
-- | Many JavaScript APIs include functions which take an object argument,
-- | where the object's properties come from a fixed set of optional
-- | configuration values. For example, the `createWriteStream` function from
-- | the Node.js `fs` module may contain properties such as:
-- |
-- | - `flags`, which should be a `String`, such as `"w"`, `"rw"`, or `"r+"`,
-- | - `defaultEncoding`, which should be a `String` representing an
-- |   encoding, such as `"utf8"`,
-- |
-- | and so on.
-- |
-- | PureScript's record types can be a little awkward for this, since it is
-- | usually the case that any subset of these properties can be specified;
-- | however, a value of  type `{ flags :: String, defaultEncoding :: String, [...] }`
-- | must include every property listed, even if you only want to specify
-- | one or two properties.
-- |
-- | Using this module, you could wrap `fs.createWriteStream` as follows:
-- |
-- | First, create a phantom type used for the options object:
-- |
-- | ```purescript
-- | data CreateWriteStreamOptions
-- | ```
-- |
-- | Then, create `Option` values for each of the options:
-- |
-- | ```purescript
-- | flags :: Option CreateWriteStreamOptions String
-- | flags = opt "flags"
-- |
-- | defaultEncoding :: Option CreateWriteStreamOptions String
-- | defaultEncoding = opt "defaultEncoding"
-- |
-- | -- and so on
-- | ```
-- |
-- | Import the function you're wrapping using the FFI, using the `Foreign`
-- | type for the options object:
-- |
-- | ```purescript
-- | -- don't export this!
-- | foreign import createWriteStreamImpl :: forall eff. FilePath -> Foreign -> Effect Unit
-- | ```
-- |
-- | Finally, in the function you are going to export, take an `Options` value
-- | for the options argument, and use the `options` function provided by this
-- | library to convert it into a `Foreign` value, which will then have a
-- | suitable representation for passing to the JavaScript API.
-- |
-- | ```
-- | createWriteStream :: forall eff. FilePath -> Options CreateWriteStreamOptions -> Effect Unit
-- | createWriteStream path opts = createWriteStreamImpl path (options opts)
-- | ```
-- |
-- | Then, users of your API can create `Options` values using the `:=`
-- | operator to assign values for the options they want to configure, and the
-- | `Monoid Options` instance to combine them. For example, as a user of this
-- | API, you might write:
-- |
-- | ```purescript
-- | FS.createWriteStream "file.txt" $
-- |    defaultEncoding := "utf8" <>
-- |    flags := "rw"
-- | ```
-- |
-- | You can also use more specific types for more type safety. For example,
-- | it would be safer to use the existing `FileFlags` and `Encoding` types
-- | already provided by the `node-fs` library. However, we cannot use them
-- | directly because they will have the wrong runtime representation. This is
-- | where the `Contravariant` instance for `Option` comes in; it can be used
-- | to transform an option's value to give it a suitable runtime
-- | representation based on what the JS API is expecting. For example:
-- |
-- | ```purescript
-- | flags :: Option CreateWriteStreamOptions FileFlags
-- | flags = cmap fileFlagsToNode (opt "flags")
-- | ```
-- |
-- | Note that `fileFlagsToNode` takes a `FileFlags` and returns a `String`
-- | suitable for passing to a Node.js API.
module Data.Options
  ( Options(..)
  , options
  , Option
  , assoc, (:=)
  , optional
  , opt
  , tag
  , defaultToOptions
  ) where

import Prelude

import Data.Maybe (Maybe, maybe)
import Data.Newtype (class Newtype, unwrap)
import Data.Op (Op(..))
import Data.Tuple (Tuple(..))
import Foreign (Foreign, unsafeToForeign)
import Foreign.Object as Object

-- | The `Options` type represents a set of options. The type argument is a
-- | phantom type, which is useful for ensuring that options for one particular
-- | API are not accidentally passed to some other API.
newtype Options opt = Options (Array (Tuple String Foreign))

derive instance newtypeOptions :: Newtype (Options opt) _
derive newtype instance semigroupOptions ∷ Semigroup (Options opt)
derive newtype instance monoidOptions ∷ Monoid (Options opt)

-- | Convert an `Options` value into a JavaScript object, suitable for passing
-- | to JavaScript APIs.
options :: forall opt. Options opt -> Foreign
options (Options os) = unsafeToForeign (Object.fromFoldable os)

-- | An `Option` represents an opportunity to configure a specific attribute
-- | of a call to some API. This normally corresponds to one specific property
-- | of an "options" object in JavaScript APIs, but can in general correspond
-- | to zero or more actual properties.
type Option opt = Op (Options opt)

-- | Associates a value with a specific option.
assoc :: forall opt value. Option opt value -> value -> Options opt
assoc = unwrap

-- | An infix version of `assoc`.
infixr 6 assoc as :=

-- | A version of `assoc` which takes possibly absent values. `Nothing` values
-- | are ignored; passing `Nothing` for the second argument will result in an
-- | empty `Options`.
optional :: forall opt value. Option opt value -> Option opt (Maybe value)
optional option = Op $ maybe mempty (option := _)

-- | The default way of creating `Option` values. Constructs an `Option` with
-- | the given key, which passes the given value through unchanged.
opt :: forall opt value. String -> Option opt value
opt = Op <<< defaultToOptions

-- | Create a `tag`, by fixing an `Option` to a single value.
tag :: forall opt value. Option opt value -> value -> Option opt Unit
tag o value = Op \_ -> o := value

-- | The default method for turning a string property key into an
-- | `Option`. This function simply calls `unsafeToForeign` on the value. If
-- | you need some other behaviour, you can write your own function to replace
-- | this one, and construct an `Option` yourself.
defaultToOptions :: forall opt value. String -> value -> Options opt
defaultToOptions k v = Options [Tuple k (unsafeToForeign v)]
