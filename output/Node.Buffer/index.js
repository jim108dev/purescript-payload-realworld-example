// Generated by purs version 0.13.8
"use strict";
var Effect = require("../Effect/index.js");
var Node_Buffer_Class = require("../Node.Buffer.Class/index.js");
var Node_Buffer_Internal = require("../Node.Buffer.Internal/index.js");
var mutableBufferEffect = new Node_Buffer_Class.MutableBuffer(function () {
    return Effect.monadEffect;
}, Node_Buffer_Internal.concat, Node_Buffer_Internal["concat'"](Effect.monadEffect), Node_Buffer_Internal.copy, Node_Buffer_Internal.create(Effect.monadEffect), Node_Buffer_Internal.fill, Node_Buffer_Internal.copyAll, Node_Buffer_Internal.fromArray(Effect.monadEffect), Node_Buffer_Internal.fromArrayBuffer(Effect.monadEffect), Node_Buffer_Internal.fromString(Effect.monadEffect), Node_Buffer_Internal.getAtOffset(Effect.monadEffect), Node_Buffer_Internal.read(Effect.monadEffect), Node_Buffer_Internal.readString(Effect.monadEffect), Node_Buffer_Internal.setAtOffset, Node_Buffer_Internal.size(Effect.monadEffect), Node_Buffer_Internal.slice, Node_Buffer_Internal.copyAll, Node_Buffer_Internal.toArray(Effect.monadEffect), Node_Buffer_Internal.toArrayBuffer(Effect.monadEffect), Node_Buffer_Internal.toString(Effect.monadEffect), Node_Buffer_Internal.unsafeFreeze(Effect.monadEffect), Node_Buffer_Internal.unsafeThaw(Effect.monadEffect), Node_Buffer_Internal.write(Effect.monadEffect), Node_Buffer_Internal.writeString(Effect.monadEffect));
module.exports = {
    mutableBufferEffect: mutableBufferEffect
};
