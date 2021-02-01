module Data.String.Utils
  ( NormalizationForm (..)
  , charAt
  , codePointAt
  , codePointAt'
  , endsWith
  , endsWith'
  , escapeRegex
  , filter
  , fromCharArray
  , includes
  , includes'
  , length
  , lines
  , mapChars
  , normalize
  , normalize'
  , padEnd
  , padEnd'
  , padStart
  , padStart'
  , repeat
  , replaceAll
  , startsWith
  , startsWith'
  , stripChars
  , stripDiacritics
  , stripMargin
  , stripMarginWith
  , toCharArray
  , trimEnd
  , trimStart
  , unsafeCodePointAt
  , unsafeCodePointAt'
  , unsafeRepeat
  , words
  )
where

import Data.Array              as Array
import Data.Either             ( fromRight )
import Data.Function.Uncurried ( Fn1, Fn2, Fn3, Fn4
                               , runFn1, runFn2, runFn3, runFn4
                               )
import Data.Maybe              ( Maybe (Just, Nothing) )
import Data.String.CodeUnits   as CodeUnits
import Data.String             ( drop, joinWith, trim )
import Data.String.CodePoints  ( length ) as String
import Data.String.Regex       ( Regex, replace, regex )
import Data.String.Regex.Flags ( global )
import Partial.Unsafe          ( unsafePartial )
import Prelude
import Prim.TypeError          ( class Warn, Text )
import Unsafe.Coerce           ( unsafeCoerce )


-- | Return the character at the given index, if the index is within bounds.
-- | Note that this function handles Unicode as you would expect.
-- | If you want a simple wrapper around JavaScript's `String.prototype.charAt`
-- | method, you should use the `Data.String.CodeUnits.charAt` function from
-- | `purescript-strings.`
-- | This function returns a `String` instead of a `Char` because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
-- |
-- | Example:
-- | ```purescript
-- | -- Data.String.Utils.charAt
-- | charAt 2 "ℙ∪𝕣ⅇႽ𝚌𝕣ⅈ𝚙†" == Just "𝕣"
-- | -- Data.String.CodeUnits.charAt
-- | charAt 2 "ℙ∪𝕣ⅇႽ𝚌𝕣ⅈ𝚙†" == Just '�'
-- | ```
charAt :: Int -> String -> Maybe String
charAt n str = Array.index (toCharArray str) n

-- | DEPRECATED: This function is now available in `purescript-strings`.
-- |
-- | Return the Unicode code point value of the character at the given index,
-- | if the index is within bounds.
-- | Note that this function handles Unicode as you would expect.
-- | If you want a simple wrapper around JavaScript's
-- | `String.prototype.codePointAt` method, you should use `codePointAt'`.
-- |
-- | Example:
-- | ```purescript
-- | codePointAt   0 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120792
-- | codePointAt   1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120793
-- | codePointAt   2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120794
-- | codePointAt  19 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Nothing
-- |
-- | codePointAt'  0 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120793
-- | codePointAt'  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 57304   -- Surrogate code point
-- | codePointAt'  2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120794
-- | codePointAt' 19 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 57313   -- Surrogate code point
-- | ```
codePointAt
  :: Warn (Text "DEPRECATED: `Data.String.Utils.codePointAt`")
  => Int -> String -> Maybe Int
codePointAt n s = runFn4 codePointAtImpl Just Nothing n s

foreign import codePointAtImpl
  :: Fn4 (∀ a. a -> Maybe a) (∀ a. Maybe a) Int String (Maybe Int)

-- | Return the Unicode code point value of the character at the given index,
-- | if the index is within bounds.
-- | This function is a simple wrapper around JavaScript's
-- | `String.prototype.codePointAt` method. This means that if the index does
-- | not point to the beginning of a valid surrogate pair, the code unit at
-- | the index (i.e. the Unicode code point of the surrogate pair half) is
-- | returned instead.
-- | If you want to treat a string as an array of Unicode Code Points, use
-- | `codePointAt` from `purescript-strings` instead.
-- |
-- | Example:
-- | ```purescript
-- | codePointAt'  0 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120793
-- | codePointAt'  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 57304   -- Surrogate code point
-- | codePointAt'  2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120794
-- | codePointAt' 19 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 57313   -- Surrogate code point
-- |
-- | codePointAt   0 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120792
-- | codePointAt   1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120793
-- | codePointAt   2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Just 120794
-- | codePointAt  19 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == Nothing
-- | ```
codePointAt' :: Int -> String -> Maybe Int
codePointAt' n s = runFn4 codePointAtPrimeImpl Just Nothing n s

foreign import codePointAtPrimeImpl
  :: Fn4 (∀ a. a -> Maybe a) (∀ a. Maybe a) Int String (Maybe Int)

-- | Determine whether the second string ends with the first one.
endsWith :: String -> String -> Boolean
endsWith searchString s = runFn2 endsWithImpl searchString s

foreign import endsWithImpl :: Fn2 String String Boolean

-- | Determine whether the second string ends with the first one
-- | but search as if the string were only as long as the given argument.
endsWith' :: String -> Int -> String -> Boolean
endsWith' searchString position s
  = runFn3 endsWithPrimeImpl searchString position s

foreign import endsWithPrimeImpl :: Fn3 String Int String Boolean

-- | Escape a string so that it can be used as a literal string within a regular
-- | expression.
escapeRegex :: String -> String
escapeRegex s = runFn1 escapeRegexImpl s

foreign import escapeRegexImpl :: Fn1 String String

-- | Keep only those characters that satisfy the predicate.
-- | This function uses `String` instead of `Char` because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
filter :: (String -> Boolean) -> String -> String
filter p = fromCharArray <<< Array.filter p <<< toCharArray

-- | Convert an array of characters into a `String`.
-- | This function uses `String` instead of `Char` because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
-- |
-- | Example:
-- | ```purescript
-- | fromCharArray ["ℙ", "∪", "𝕣", "ⅇ", "Ⴝ", "𝚌", "𝕣", "ⅈ", "𝚙", "†"]
-- |   == "ℙ∪𝕣ⅇႽ𝚌𝕣ⅈ𝚙†"
-- | ```
fromCharArray :: Array String -> String
fromCharArray arr = runFn1 fromCharArrayImpl arr

foreign import fromCharArrayImpl :: Fn1 (Array String) String

-- | Determine whether the second arguments contains the first one.
-- |
-- | Example:
-- | ```purescript
-- | includes "Merchant" "The Merchant of Venice" === true
-- | includes "Duncan"   "The Merchant of Venice" === false
-- | ```
includes :: String -> String -> Boolean
includes searchString s = runFn2 includesImpl searchString s

foreign import includesImpl :: Fn2 String String Boolean

-- | Determine whether the second string argument contains the first one,
-- | beginning the search at the given position.
-- | Note that this function handles Unicode as you would expect.
-- | Negative `position` values result in a search from the beginning of the
-- | string.
-- |
-- | Example:
-- | ```purescript
-- | includes' "𝟙"  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == true
-- | includes' "𝟙"  2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == false
-- | includes' "𝟡" 10 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == false
-- | -- This behaviour is different from `String.prototype.includes`:
-- | -- "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡".includes("𝟡", 10) == true
-- | ```
includes' :: String -> Int -> String -> Boolean
includes' needle position haystack
  = runFn3 includesPrimeImpl needle position haystack

foreign import includesPrimeImpl :: Fn3 String Int String Boolean

-- | DEPRECATED: This function is now available in `purescript-strings`.
-- |
-- | Return the number of Unicode code points in a string.
-- | Note that this function correctly accounts for Unicode symbols that
-- | are made up of surrogate pairs. If you want a simple wrapper around
-- | JavaScript's `string.length` property, you should use the
-- | `Data.String.CodeUnits.length` function from `purescript-strings`.
-- |
-- | ```purescript
-- | length "PureScript" == 10
-- | length "ℙ∪𝕣ⅇႽ𝚌𝕣ⅈ𝚙†" == 10    -- 14 with `Data.String.length`
-- | ```
length
  :: Warn (Text "DEPRECATED: `Data.String.Utils.length`")
  => String -> Int
length s = runFn1 lengthImpl s

foreign import lengthImpl :: Fn1 String Int

-- | Split a string into an array of strings which were delimited by newline
-- | characters.
-- |
-- | Example:
-- | ```purescript
-- | lines "Action\nis\neloquence." == ["Action", "is", "eloquence."]
-- | ```
lines :: String -> Array String
lines s = runFn1 linesImpl s

foreign import linesImpl :: Fn1 String (Array String)

-- | Return the string obtained by applying the mapping function to each
-- | character (i.e. Unicode code point) of the input string.
-- | Note that this is probably not what you want as Unicode code points are
-- | not necessarily the same as user-perceived characters (grapheme clusters).
-- | Only use this function if you know what you are doing.
-- | This function uses `String`s instead of `Char`s because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
-- |
-- | Example:
-- | ```purescript
-- | -- Mapping over what appears to be six characters...
-- | mapChars (const "x") "Åström" == "xxxxxxxx" -- See? Don't use this!
-- | ```
mapChars :: (String -> String) -> String -> String
mapChars f = fromCharArray <<< map f <<< toCharArray

-- | Return the `Normalization Form C` of a given string.
-- | This is the form that is recommended by the W3C.
normalize :: String -> String
normalize s = runFn1 normalizeImpl s

foreign import normalizeImpl :: Fn1 String String

-- | Possible Unicode Normalization Forms
data NormalizationForm = NFC | NFD | NFKC | NFKD

instance showNormalizationForm :: Show NormalizationForm where
  show NFC  = "NFC"
  show NFD  = "NFD"
  show NFKC = "NFKC"
  show NFKD = "NFKD"

-- | Return a given Unicode Normalization Form of a string.
normalize' :: NormalizationForm -> String -> String
normalize' nf s = runFn2 normalizePrimeImpl (show nf) s

foreign import normalizePrimeImpl :: Fn2 String String String

-- | Pad the given string with space from the end until the resulting string
-- | reaches the given length.
-- | Note that this function handles Unicode as you would expect.
-- | If you want a simple wrapper around JavaScript's
-- | `String.prototype.padEnd` method, you should use `padEnd'`.
-- |
-- | Example:
-- | ```purescript
-- | -- Treats strings as a sequence of Unicode code points
-- | padEnd   1 "0123456789" == "0123456789"
-- | padEnd   1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padEnd  11 "0123456789" == "0123456789 "
-- | padEnd  11 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡 "
-- | padEnd  21 "0123456789" == "0123456789           "
-- | padEnd  21 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡           "
-- |
-- | -- Treats strings as a sequence of Unicode code units
-- | padEnd'  1 "0123456789" == "0123456789"
-- | padEnd'  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padEnd' 11 "0123456789" == "0123456789 "
-- | padEnd' 11 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padEnd' 21 "0123456789" == "0123456789           "
-- | padEnd' 21 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡 "
-- | ```
padEnd :: Int -> String -> String
padEnd n s =
  let
    numberOfCodePoints = String.length s
    numberOfCodeUnits  = CodeUnits.length s
  in
    padEnd' (n + numberOfCodeUnits - numberOfCodePoints) s

-- | Wrapper around JavaScript's `String.prototype.padEnd` method.
-- | Note that this function treats strings as a sequence of Unicode
-- | code units.
-- | You will probably want to use `padEnd` instead.
-- |
-- | Example:
-- | ```purescript
-- | -- Treats strings as a sequence of Unicode code points
-- | padEnd   1 "0123456789" == "0123456789"
-- | padEnd   1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padEnd  11 "0123456789" == "0123456789 "
-- | padEnd  11 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡 "
-- | padEnd  21 "0123456789" == "0123456789           "
-- | padEnd  21 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡           "
-- |
-- | -- Treats strings as a sequence of Unicode code units
-- | padEnd'  1 "0123456789" == "0123456789"
-- | padEnd'  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padEnd' 11 "0123456789" == "0123456789 "
-- | padEnd' 11 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padEnd' 21 "0123456789" == "0123456789           "
-- | padEnd' 21 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡 "
-- | ```
padEnd' :: Int -> String -> String
padEnd' n s = runFn2 padEndPrimeImpl n s

foreign import padEndPrimeImpl :: Fn2 Int String String

-- | Pad the given string with space from the start until the resulting string
-- | reaches the given length.
-- | Note that this function handles Unicode as you would expect.
-- | If you want a simple wrapper around JavaScript's
-- | `String.prototype.padStart` method, you should use `padStart'`.
-- |
-- | Example:
-- | ```purescript
-- | -- Treats strings as a sequence of Unicode code points
-- | padStart   1 "0123456789" == "0123456789"
-- | padStart   1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padStart  11 "0123456789" == " 0123456789"
-- | padStart  11 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == " 𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padStart  21 "0123456789" == "           0123456789"
-- | padStart  21 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "           𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- |
-- | -- Treats strings as a sequence of Unicode code units
-- | padStart'  1 "0123456789" == "0123456789"
-- | padStart'  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padStart' 11 "0123456789" == " 0123456789"
-- | padStart' 11 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padStart' 21 "0123456789" == "           0123456789"
-- | padStart' 21 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == " 𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | ```
padStart :: Int -> String -> String
padStart n s =
  let
    numberOfCodePoints = String.length s
    numberOfCodeUnits  = CodeUnits.length s
  in
    padStart' (n + numberOfCodeUnits - numberOfCodePoints) s

-- | Wrapper around JavaScript's `String.prototype.padStart` method.
-- | Note that this function treats strings as a sequence of Unicode
-- | code units.
-- | You will probably want to use `padStart` instead.
-- |
-- | Example:
-- | ```purescript
-- | -- Treats strings as a sequence of Unicode code points
-- | padStart   1 "0123456789" == "0123456789"
-- | padStart   1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padStart  11 "0123456789" == " 0123456789"
-- | padStart  11 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == " 𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padStart  21 "0123456789" == "           0123456789"
-- | padStart  21 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "           𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- |
-- | -- Treats strings as a sequence of Unicode code units
-- | padStart'  1 "0123456789" == "0123456789"
-- | padStart'  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padStart' 11 "0123456789" == " 0123456789"
-- | padStart' 11 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | padStart' 21 "0123456789" == "           0123456789"
-- | padStart' 21 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == " 𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
-- | ```
padStart' :: Int -> String -> String
padStart' n s = runFn2 padStartPrimeImpl n s

foreign import padStartPrimeImpl :: Fn2 Int String String

-- | Return a string that contains the specified number of copies of the input
-- | string concatenated together. Return `Nothing` if the repeat count is
-- | negative or if the resulting string would overflow the maximum string size.
-- |
-- | Example:
-- | ```purescript
-- | repeat 3 "𝟞" == Just "𝟞𝟞𝟞"
-- | repeat (-1) "PureScript" == Nothing
-- | repeat 2147483647 "PureScript" == Nothing
-- | ```
repeat :: Int -> String -> Maybe String
repeat n s = runFn4 repeatImpl Just Nothing n s

foreign import repeatImpl
  :: Fn4 (∀ a. a -> Maybe a) (∀ a. Maybe a) Int String (Maybe String)

-- | DEPRECATED: This function is now available in `purescript-strings`.
-- |
-- | Replace all occurences of the first argument with the second argument.
replaceAll
  :: Warn (Text "DEPRECATED: `Data.String.Utils.replaceAll`")
  => String -> String -> String -> String
replaceAll = replace <<< mkRegex
  where
    -- Helper function to construct a `Regex` from an input string
    mkRegex :: String -> Regex
    mkRegex str = unsafePartial (fromRight (regex (escapeRegex str) global))

-- | Determine whether the second argument starts with the first one.
startsWith :: String -> String -> Boolean
startsWith searchString s = runFn2 startsWithImpl searchString s

foreign import startsWithImpl :: Fn2 String String Boolean

-- | Determine whether a string starts with a certain substring at a given
-- | position.
startsWith' :: String -> Int -> String -> Boolean
startsWith' searchString position s
  = runFn3 startsWithPrimeImpl searchString position s

foreign import startsWithPrimeImpl :: Fn3 String Int String Boolean

-- | Strip a set of characters from a string.
-- | This function is case-sensitive.
-- |
-- | Example:
-- | ```purescript
-- | stripChars "aeiou" "PureScript" == "PrScrpt"
-- | stripChars "AEIOU" "PureScript" == "PureScript"
-- | ```
stripChars :: String -> String -> String
stripChars chars s = runFn2 stripCharsImpl chars s

foreign import stripCharsImpl :: Fn2 String String String

-- | Strip diacritics from a string.
-- |
-- | Example:
-- | ```purescript
-- | stripDiacritics "Ångström"        == "Angstrom"
-- | stripDiacritics "Crème Brulée"    == "Creme Brulee"
-- | stripDiacritics "Götterdämmerung" == "Gotterdammerung"
-- | stripDiacritics "ℙ∪𝕣ⅇႽ𝚌𝕣ⅈ𝚙†"      == "ℙ∪𝕣ⅇႽ𝚌𝕣ⅈ𝚙†"
-- | stripDiacritics "Raison d'être"   == "Raison d'etre"
-- | stripDiacritics "Týr"             == "Tyr"
-- | stripDiacritics "Zürich"          == "Zurich"
-- | ```
stripDiacritics :: String -> String
stripDiacritics s = runFn1 stripDiacriticsImpl s

foreign import stripDiacriticsImpl :: Fn1 String String

-- | Removes leading whitespace and pipe character from each line. Useful for
-- | dedenting strings enclosed in triple double quotation marks.
-- | Inspired by Scala's `stripMargin` method.
-- | Does not preserve original line endings.
-- |
-- | Example:
-- | ```purescript
-- | stripMargin
-- |   """
-- |   |Line 1
-- |   |Line 2
-- |   |Line 3
-- |   """
-- | == "Line 1\nLine 2\nLine 3"
-- | ```
stripMargin :: String -> String
stripMargin = stripMarginWith "|"

-- | Same as `stripMargin` except with the option to use any given string
-- | to delimit the margin.
-- | Does not preserve original line endings.
-- |
-- | Example:
-- | ```purescript
-- | stripMarginWith ">> "
-- |   """
-- |   >> Line 1
-- |   >> Line 2
-- |   >> Line 3
-- |   """
-- | == "Line 1\nLine 2\nLine 3"
-- | ```
stripMarginWith :: String -> String -> String
stripMarginWith delimiter = joinWith "\n" <<< map go <<< lines <<< trim
  where
  go :: String -> String
  go line =
    let
      trimmed = trimStart line
    in
      if startsWith delimiter trimmed
        then drop (String.length delimiter) trimmed
        else line

-- | Convert a string to an array of Unicode code points.
-- | Note that this function is different from
-- | `Data.String.CodeUnits.toCharArray` in `purescript-strings` which
-- | converts a string to an array of 16-bit code units.
-- | The difference becomes apparent when converting strings
-- | that contain characters which are internally represented
-- | as surrogate pairs.
-- | This function uses `String`s instead of `Char`s because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
-- |
-- | Example:
-- | ```purescript
-- | -- Data.String.Utils
-- | toCharArray "ℙ∪𝕣ⅇႽ𝚌𝕣ⅈ𝚙†"
-- |   == ["ℙ", "∪", "𝕣", "ⅇ", "Ⴝ", "𝚌", "𝕣", "ⅈ", "𝚙", "†"]
-- |
-- | -- Data.String.CodeUnits
-- | toCharArray "ℙ∪𝕣ⅇႽ𝚌𝕣ⅈ𝚙†" ==
-- |   ['ℙ', '∪', '�', '�', 'ⅇ', 'Ⴝ', '�', '�', '�', '�', 'ⅈ', '�', '�', '†']
-- | ```
toCharArray :: String -> Array String
toCharArray s = runFn1 toCharArrayImpl s

foreign import toCharArrayImpl :: Fn1 String (Array String)

-- | Remove whitespace from the end of a string.
-- | Wrapper around JavaScript's `String.prototype.trimEnd` method.
trimEnd :: String -> String
trimEnd s = s'.trimEnd unit
  where s' = unsafeCoerce s :: { trimEnd :: Unit -> String }

-- | Remove whitespace from the beginning of a string.
-- | Wrapper around JavaScript's `String.prototype.trimStart` method.
trimStart :: String -> String
trimStart s = s'.trimStart unit
  where s' = unsafeCoerce s :: { trimStart :: Unit -> String }

-- | Return the Unicode code point value of the character at the given index,
-- | if the index is within bounds.
-- | Note that this function handles Unicode as you would expect.
-- | If you want a simple (unsafe) wrapper around JavaScript's
-- | `String.prototype.codePointAt` method, you should use `unsafeCodePointAt'`.
-- |
-- | **Unsafe:** Throws runtime exception if the index is not within bounds.
-- |
-- | Example:
-- | ```purescript
-- | unsafeCodePointAt   0 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120792
-- | unsafeCodePointAt   1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120793
-- | unsafeCodePointAt   2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120794
-- | unsafeCodePointAt  19 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" -- Error
-- |
-- | unsafeCodePointAt'  0 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120793
-- | unsafeCodePointAt'  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 57304   -- Surrogate code point
-- | unsafeCodePointAt'  2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120794
-- | unsafeCodePointAt' 19 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 57313   -- Surrogate code point
-- | ```
unsafeCodePointAt :: Int -> String -> Int
unsafeCodePointAt n s = runFn2 unsafeCodePointAtImpl n s

foreign import unsafeCodePointAtImpl :: Fn2 Int String Int

-- | Return the Unicode code point value of the character at the given index,
-- | if the index is within bounds.
-- | This function is a simple (unsafe) wrapper around JavaScript's
-- | `String.prototype.codePointAt` method. This means that if the index does
-- | not point to the beginning of a valid surrogate pair, the code unit at
-- | the index (i.e. the Unicode code point of the surrogate pair half) is
-- | returned instead.
-- | If you want to treat a string as an array of Unicode Code Points, use
-- | `unsafeCodePointAt` instead.
-- |
-- | Example:
-- | ```purescript
-- | unsafeCodePointAt'  0 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120793
-- | unsafeCodePointAt'  1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 57304   -- Surrogate code point
-- | unsafeCodePointAt'  2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120794
-- | unsafeCodePointAt' 19 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 57313   -- Surrogate code point
-- |
-- | unsafeCodePointAt   0 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120792
-- | unsafeCodePointAt   1 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120793
-- | unsafeCodePointAt   2 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" == 120794
-- | unsafeCodePointAt  19 "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" -- Error
-- | ```
unsafeCodePointAt' :: Int -> String -> Int
unsafeCodePointAt' n s = runFn2 unsafeCodePointAtPrimeImpl n s

foreign import unsafeCodePointAtPrimeImpl :: Fn2 Int String Int

-- | Return a string that contains the specified number of copies of the input
-- | string concatenated together.
-- |
-- | **Unsafe:** Throws runtime exception if the repeat count is negative or if
-- | the resulting string would overflow the maximum string size.
unsafeRepeat :: Int -> String -> String
unsafeRepeat n s = runFn2 unsafeRepeatImpl n s

foreign import unsafeRepeatImpl :: Fn2 Int String String

-- | Split a string into an array of strings which were delimited by white space
-- | characters.
-- |
-- | Example:
-- | ```purescript
-- | words "Action is eloquence." == ["Action", "is", "eloquence."]
-- | ```
words :: String -> Array String
words s = runFn1 wordsImpl s

foreign import wordsImpl :: Fn1 String (Array String)
