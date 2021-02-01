"use strict";

exports._unsafeReadProtoTagged = function (nothing, just, name, value) {
  if (typeof window !== "undefined") {
    var ty = window[name];
    if (ty != null && value instanceof ty) {
      return just(value);
    }
    return nothing;
  } 
  var obj = value;
  while (obj != null) {
    var proto = Object.getPrototypeOf(obj);
    var constructorName = proto.constructor.name;
    if (constructorName === name) {
      return just(value);
    } else if (constructorName === "Object") {
      return nothing;
    }
    obj = proto;
  }
  return nothing;
};
