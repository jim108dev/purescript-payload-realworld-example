module Test.Input
  ( CodePoint (..)
  , NegativeInt (..)
  , NewlineChar (..)
  , NonNegativeInt (..)
  , SurrogateCodePoint (..)
  , WhiteSpaceChar (..)
  , OneCharString (..)
  )
where

import Data.List                  ( List, fromFoldable )
import Prelude
import Test.StrongCheck.Arbitrary ( class Arbitrary, arbitrary )
import Test.StrongCheck.Gen       ( chooseInt, elements )
import Unsafe.Coerce              ( unsafeCoerce )


newtype CodePoint          = CodePoint Int
newtype NegativeInt        = NegativeInt Int
newtype NewlineChar        = NewlineChar Char
newtype NonNegativeInt     = NonNegativeInt Int
newtype SurrogateCodePoint = SurrogateCodePoint Int
newtype WhiteSpaceChar     = WhiteSpaceChar Char
newtype OneCharString      = OneCharString String

-- Unicode code points are in the range 0 .. U+10FFFF
instance arbCodePoint :: Arbitrary CodePoint where
  arbitrary = CodePoint <$> chooseInt 0 0x10FFFF

instance arbNegativeInt :: Arbitrary NegativeInt where
  arbitrary = NegativeInt <$> chooseInt bottom (-1)

instance arbNewlineChar :: Arbitrary NewlineChar where
  arbitrary = NewlineChar <$> elements '\n' newlineChars

instance arbNonNegativeInt :: Arbitrary NonNegativeInt where
  arbitrary = NonNegativeInt <$> chooseInt 0 top

-- Surrogate code points are in the range U+D800 .. U+DFFF
instance arbSurrogateCodePoint :: Arbitrary SurrogateCodePoint where
  arbitrary = SurrogateCodePoint <$> chooseInt 0xD800 0xDFFF

instance arbWhiteSpaceChar :: Arbitrary WhiteSpaceChar where
  arbitrary = WhiteSpaceChar <$> elements ' ' whiteSpaceChars

instance arbOneCharString :: Arbitrary OneCharString where
  arbitrary = OneCharString <<< (unsafeCoerce :: Char -> String) <$> arbitrary

-- Unicode line terminators
newlineChars :: List Char
newlineChars = fromFoldable
  [ '\x000A' -- LINE FEED
  , '\x000B' -- VERTICAL TAB
  , '\x000C' -- FORM FEED
  , '\x000D' -- CARRIAGE RETURN
  , '\x0085' -- NEXT LINE
  , '\x2028' -- LINE SEPARATOR
  , '\x2029' -- PARAGRAPH SEPARATOR
  ]

-- Unicode whitespace characters (25 as of Unicode 12.1)
whiteSpaceChars :: List Char
whiteSpaceChars = newlineChars <> fromFoldable
  [ '\x0009' -- CHARACTER TABULATION
  , '\x0020' -- SPACE
  , '\x00A0' -- NO-BREAK SPACE
  , '\x1680' -- OGHAM SPACE MARK
  , '\x2000' -- EN QUAD
  , '\x2001' -- EM QUAD
  , '\x2002' -- EN SPACE
  , '\x2003' -- EM SPACE
  , '\x2004' -- THREE-PER-EM SPACE
  , '\x2005' -- FOUR-PER-EM SPACE
  , '\x2006' -- SIX-PER-EM SPACE
  , '\x2007' -- FIGURE SPACE
  , '\x2008' -- PUNCTUATION SPACE
  , '\x2009' -- THIN SPACE
  , '\x200A' -- HAIR SPACE
  , '\x202F' -- NARROW NO-BREAK SPACE
  , '\x205F' -- MEDIUM MATHEMATICAL SPACE
  , '\x3000' -- IDEOGRAPHIC SPACE
  ]
