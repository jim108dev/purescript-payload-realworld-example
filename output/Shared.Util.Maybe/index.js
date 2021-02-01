// Generated by purs version 0.13.8
"use strict";
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Nullable = require("../Data.Nullable/index.js");
var fromMaybeNullable = function (fallback) {
    return function (value) {
        if (value instanceof Data_Maybe.Just) {
            return Data_Nullable.toMaybe(value.value0);
        };
        if (value instanceof Data_Maybe.Nothing) {
            return fallback;
        };
        throw new Error("Failed pattern match at Shared.Util.Maybe (line 7, column 36 - line 9, column 22): " + [ value.constructor.name ]);
    };
};
module.exports = {
    fromMaybeNullable: fromMaybeNullable
};