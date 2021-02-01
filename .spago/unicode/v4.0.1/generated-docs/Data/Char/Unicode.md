## Module Data.Char.Unicode

#### `GeneralCategory`

``` purescript
data GeneralCategory
  = UppercaseLetter
  | LowercaseLetter
  | TitlecaseLetter
  | ModifierLetter
  | OtherLetter
  | NonSpacingMark
  | SpacingCombiningMark
  | EnclosingMark
  | DecimalNumber
  | LetterNumber
  | OtherNumber
  | ConnectorPunctuation
  | DashPunctuation
  | OpenPunctuation
  | ClosePunctuation
  | InitialQuote
  | FinalQuote
  | OtherPunctuation
  | MathSymbol
  | CurrencySymbol
  | ModifierSymbol
  | OtherSymbol
  | Space
  | LineSeparator
  | ParagraphSeparator
  | Control
  | Format
  | Surrogate
  | PrivateUse
  | NotAssigned
```

Unicode General Categories (column 2 of the UnicodeData table) in
the order they are listed in the Unicode standard (the Unicode
Character Database, in particular).

*Examples*

Basic usage:

```
>>> :t OtherLetter
OtherLetter :: GeneralCategory
```

`Eq` instance:

```
>>> UppercaseLetter == UppercaseLetter
True
>>> UppercaseLetter == LowercaseLetter
False
```

`Ord` instance:

```
>>> NonSpacingMark <= MathSymbol
True
```

`Enum` instance (TODO: this is not implemented yet):

```
>>> enumFromTo ModifierLetter SpacingCombiningMark
[ModifierLetter,OtherLetter,NonSpacingMark,SpacingCombiningMark]
```

`Show` instance:

```
>>> show EnclosingMark
"EnclosingMark"
```

`Bounded` instance:

```
>>> bottom :: GeneralCategory
UppercaseLetter
>>> top :: GeneralCategory
NotAssigned
```

##### Instances
``` purescript
Show GeneralCategory
Eq GeneralCategory
Ord GeneralCategory
Bounded GeneralCategory
```

#### `generalCatToInt`

``` purescript
generalCatToInt :: GeneralCategory -> Int
```

#### `generalCatToUnicodeCat`

``` purescript
generalCatToUnicodeCat :: GeneralCategory -> UnicodeCategory
```

#### `unicodeCatToGeneralCat`

``` purescript
unicodeCatToGeneralCat :: UnicodeCategory -> GeneralCategory
```

#### `generalCategory`

``` purescript
generalCategory :: Char -> Maybe GeneralCategory
```

The Unicode general category of the character.

*Examples*

Basic usage:

```
>>> generalCategory 'a'
Just LowercaseLetter
>>> generalCategory 'A'
Just UppercaseLetter
>>> generalCategory '0'
Just DecimalNumber
>>> generalCategory '%'
Just OtherPunctuation
>>> generalCategory '♥'
Just OtherSymbol
>>> generalCategory '\31'
Just Control
>>> generalCategory ' '
Just Space
```

#### `isAscii`

``` purescript
isAscii :: Char -> Boolean
```

Selects the first 128 characters of the Unicode character set,
corresponding to the ASCII character set.

#### `isLatin1`

``` purescript
isLatin1 :: Char -> Boolean
```

Selects the first 256 characters of the Unicode character set,
corresponding to the ISO 8859-1 (Latin-1) character set.

#### `isAsciiLower`

``` purescript
isAsciiLower :: Char -> Boolean
```

Selects ASCII lower-case letters,
i.e. characters satisfying both `isAscii` and `isLower`.

#### `isAsciiUpper`

``` purescript
isAsciiUpper :: Char -> Boolean
```

Selects ASCII upper-case letters,
i.e. characters satisfying both `isAscii` and `isUpper`.

#### `isControl`

``` purescript
isControl :: Char -> Boolean
```

Selects control characters, which are the non-printing characters of
the Latin-1 subset of Unicode.

#### `isPrint`

``` purescript
isPrint :: Char -> Boolean
```

Selects printable Unicode characters
(letters, numbers, marks, punctuation, symbols and spaces).

#### `isSpace`

``` purescript
isSpace :: Char -> Boolean
```

Returns `True` for any Unicode space character, and the control
characters `\t`, `\n`, `\r`, `\f`, `\v`.

`isSpace` includes non-breaking space.

#### `isUpper`

``` purescript
isUpper :: Char -> Boolean
```

Selects upper-case or title-case alphabetic Unicode characters (letters).
Title case is used by a small number of letter ligatures like the
single-character form of /Lj/.

#### `isLower`

``` purescript
isLower :: Char -> Boolean
```

Selects lower-case alphabetic Unicode characters (letters).

#### `isAlpha`

``` purescript
isAlpha :: Char -> Boolean
```

Selects alphabetic Unicode characters (lower-case, upper-case and
title-case letters, plus letters of caseless scripts and modifiers letters).

#### `isAlphaNum`

``` purescript
isAlphaNum :: Char -> Boolean
```

Selects alphabetic or numeric digit Unicode characters.

Note that numeric digits outside the ASCII range are selected by this
function but not by `isDigit`.  Such digits may be part of identifiers
but are not used by the printer and reader to represent numbers.

#### `isDigit`

``` purescript
isDigit :: Char -> Boolean
```

Selects ASCII digits, i.e. `0..9`.

#### `isOctDigit`

``` purescript
isOctDigit :: Char -> Boolean
```

Selects ASCII octal digits, i.e. `0..7`.

#### `isHexDigit`

``` purescript
isHexDigit :: Char -> Boolean
```

Selects ASCII hexadecimal digits,
i.e. `0..9, A..F, a..f`.

#### `isPunctuation`

``` purescript
isPunctuation :: Char -> Boolean
```

Selects Unicode punctuation characters, including various kinds
of connectors, brackets and quotes.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `ConnectorPunctuation`
- `DashPunctuation`
- `OpenPunctuation`
- `ClosePunctuation`
- `InitialQuote`
- `FinalQuote`
- `OtherPunctuation`

These classes are defined in the
[Unicode Character Database])http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table)
part of the Unicode standard. The same document defines what is
and is not a "Punctuation".

*Examples*

Basic usage:

```
>>> isPunctuation 'a'
false
>>> isPunctuation '7'
false
>>> isPunctuation '♥'
false
>>> isPunctuation '"'
true
>>> isPunctuation '?'
true
>>> isPunctuation '—'
true
```

#### `isSymbol`

``` purescript
isSymbol :: Char -> Boolean
```

Selects Unicode symbol characters, including mathematical and
currency symbols.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `MathSymbol`
- `CurrencySymbol`
- `ModifierSymbol`
- `OtherSymbol`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table),
part of the Unicode standard. The same document defines what is
and is not a "Symbol".

*Examples*

Basic usage:

```
>>> isSymbol 'a'
false
>>> isSymbol '6'
false
>>> isSymbol '='
true
```

The definition of \"math symbol\" may be a little
counter-intuitive depending on one's background:

```
>>> isSymbol '+'
true
>>> isSymbol '-'
false
```

#### `toUpper`

``` purescript
toUpper :: Char -> Char
```

Convert a letter to the corresponding upper-case letter, if any.
Any other character is returned unchanged.

#### `toLower`

``` purescript
toLower :: Char -> Char
```

Convert a letter to the corresponding lower-case letter, if any.
Any other character is returned unchanged.

#### `toTitle`

``` purescript
toTitle :: Char -> Char
```

Convert a letter to the corresponding title-case or upper-case
letter, if any.  (Title case differs from upper case only for a small
number of ligature letters.)
Any other character is returned unchanged.

#### `digitToInt`

``` purescript
digitToInt :: Char -> Maybe Int
```

Convert a single digit `Char` to the corresponding `Just Int` if its argument
satisfies `isHexDigit`, if it is one of `0..9, A..F, a..f`. Anything else
converts to `Nothing`

```
>>> import Data.Traversable

>>> traverse digitToInt ['0','1','2','3','4','5','6','7','8','9']
(Just [0,1,2,3,4,5,6,7,8,9])

>>> traverse digitToInt ['a','b','c','d','e','f']
(Just [10,11,12,13,14,15])

>>> traverse digitToInt ['A','B','C','D','E','F']
(Just [10,11,12,13,14,15])

>>> digitToInt 'G'
Nothing
```

#### `isLetter`

``` purescript
isLetter :: Char -> Boolean
```

Selects alphabetic Unicode characters (lower-case, upper-case and
title-case letters, plus letters of caseless scripts and
modifiers letters). This function is equivalent to
`Data.Char.isAlpha`.

This function returns `True` if its argument has one of the
following `GeneralCategory`s, or `False` otherwise:

- `UppercaseLetter`
- `LowercaseLetter`
- `TitlecaseLetter`
- `ModifierLetter`
- `OtherLetter`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table)
part of the Unicode standard. The same document defines what is
and is not a "Letter".

*Examples*

Basic usage:

```
>>> isLetter 'a'
True
>>> isLetter 'A'
True
>>> isLetter '0'
False
>>> isLetter '%'
False
>>> isLetter '♥'
False
>>> isLetter '\31'
False
```

Ensure that 'isLetter' and 'isAlpha' are equivalent.

```
>>> let chars = [(chr 0)..]
>>> let letters = map isLetter chars
>>> let alphas = map isAlpha chars
>>> letters == alphas
True
```

#### `isMark`

``` purescript
isMark :: Char -> Boolean
```

Selects Unicode mark characters, for example accents and the
like, which combine with preceding characters.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `NonSpacingMark`
- `SpacingCombiningMark`
- `EnclosingMark`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table),
part of the Unicode standard. The same document defines what is
and is not a "Mark".

*Examples*

Basic usage:

```
>>> isMark 'a'
false
>>> isMark '0'
false
```

Combining marks such as accent characters usually need to follow
another character before they become printable:

```
>>> map isMark "ò"
[false,true]
```

Puns are not necessarily supported:

```
>>> isMark '✓'
false
```

#### `isNumber`

``` purescript
isNumber :: Char -> Boolean
```

Selects Unicode numeric characters, including digits from various
scripts, Roman numerals, et cetera.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

* `DecimalNumber`
* `LetterNumber`
* `OtherNumber`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table),
part of the Unicode standard. The same document defines what is
and is not a "Number".

*Examples*

Basic usage:

```
>>> isNumber 'a'
false
>>> isNumber '%'
false
>>> isNumber '3'
true
```

ASCII @\'0\'@ through @\'9\'@ are all numbers:

```
>>> and $ map isNumber ['0'..'9']
true
```

Unicode Roman numerals are \"numbers\" as well:

```
>>> isNumber 'Ⅸ'
true
```

#### `isSeparator`

``` purescript
isSeparator :: Char -> Boolean
```

Selects Unicode space and separator characters.

This function returns `true` if its argument has one of the
following `GeneralCategory`s, or `false` otherwise:

- `Space`
- `LineSeparator`
- `ParagraphSeparator`

These classes are defined in the
[Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-14.html#GC_Values_Table)
part of the Unicode standard. The same document defines what is
and is not a "Separator".

*Examples*

Basic usage:

```
>>> isSeparator 'a'
false
>>> isSeparator '6'
false
>>> isSeparator ' '
true
```

Warning: newlines and tab characters are not considered
separators.

```
>>> isSeparator '\n'
false
>>> isSeparator '\t'
false
```

But some more exotic characters are (like HTML's @&nbsp;@):

```
>>> isSeparator '\160'
true
```


