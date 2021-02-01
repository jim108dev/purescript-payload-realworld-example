-- | Copied from https://github.com/justinwoo/purescript-simple-json/blob/master/test/EnumSumGeneric.purs
module Server.Shared.Util.Json where

import Prelude
import Control.Alt ((<|>))
import Control.Monad.Except (throwError)
import Data.Generic.Rep (class Generic, Constructor(..), NoArguments(..), Sum(..), to)
import Foreign (Foreign)
import Foreign as Foreign
import Simple.JSON as JSON
import Type.Prelude (class IsSymbol, SProxy(..), reflectSymbol)

enumReadForeign ::
  forall a rep.
  Generic a rep =>
  EnumReadForeign rep =>
  Foreign ->
  Foreign.F a
enumReadForeign f = to <$> enumReadForeignImpl f

-- type class for "enums", or nullary sum types
class EnumReadForeign rep where
  enumReadForeignImpl :: Foreign -> Foreign.F rep

instance sumEnumReadForeign ::
  ( EnumReadForeign a
  , EnumReadForeign b
  ) =>
  EnumReadForeign (Sum a b) where
  enumReadForeignImpl f =
    Inl <$> enumReadForeignImpl f
      <|> Inr
      <$> enumReadForeignImpl f

instance constructorEnumReadForeign ::
  ( IsSymbol name
    ) =>
  EnumReadForeign (Constructor name NoArguments) where
  enumReadForeignImpl f = do
    s <- JSON.readImpl f
    if s == name then
      pure $ Constructor NoArguments
    else
      throwError <<< pure <<< Foreign.ForeignError
        $ "Enum string "
        <> s
        <> " did not match expected string "
        <> name
    where
    name = reflectSymbol (SProxy :: SProxy name)

