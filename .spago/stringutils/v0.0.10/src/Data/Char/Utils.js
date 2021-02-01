"use strict";

function fromCodePointImpl (Just, Nothing, i) {
  return i >= 0 && i <= 0x10FFFF ? Just(String.fromCodePoint(i)) : Nothing;
}

function toCodePointImpl (c) {
  return c.codePointAt(0);
}

function unsafeFromCodePointImpl (cp) {
  if (cp >= 0 && cp <= 0x10FFFF) {
    return String.fromCodePoint(cp);
  }
  else {
    throw new Error("Data.Char.Utils.unsafeFromCodePoint': Invalid codepoint");
  }
}

exports.fromCodePointImpl       = fromCodePointImpl;
exports.toCodePointImpl         = toCodePointImpl;
exports.unsafeFromCodePointImpl = unsafeFromCodePointImpl;
