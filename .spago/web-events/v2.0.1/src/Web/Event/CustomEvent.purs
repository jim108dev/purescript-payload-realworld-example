module Web.Event.CustomEvent where

import Data.Maybe (Maybe)
import Unsafe.Coerce as U
import Web.Event.Event (Event)
import Web.Internal.FFI (unsafeReadProtoTagged)

foreign import data CustomEvent :: Type

fromEvent :: Event -> Maybe CustomEvent
fromEvent = unsafeReadProtoTagged "CustomEvent"

toEvent :: CustomEvent -> Event
toEvent = U.unsafeCoerce
