// Generated by purs version 0.13.8
"use strict";
var Data_Lens_Fold = require("../Data.Lens.Fold/index.js");
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Maybe_First = require("../Data.Maybe.First/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var Data_Tuple = require("../Data.Tuple/index.js");
var Partial_Unsafe = require("../Partial.Unsafe/index.js");
var unsafeView = function (dictPartial) {
    return function (s) {
        return function (l) {
            return Data_Maybe["fromMaybe'"](function (v) {
                return Partial_Unsafe.unsafeCrashWith("unsafeView: Empty fold");
            })(Data_Lens_Fold.previewOn(s)(l));
        };
    };
};
var unsafeIndexedFold = function (dictPartial) {
    return function (s) {
        return function (l) {
            return Data_Maybe["fromMaybe'"](function (v) {
                return Partial_Unsafe.unsafeCrashWith("unsafeIndexedFold: empty Fold");
            })(Data_Newtype.unwrap(Data_Maybe_First.newtypeFirst)(Data_Lens_Fold.ifoldMapOf(l)(function (i) {
                return function (a) {
                    return Data_Maybe_First.First(new Data_Maybe.Just(new Data_Tuple.Tuple(i, a)));
                };
            })(s)));
        };
    };
};
module.exports = {
    unsafeView: unsafeView,
    unsafeIndexedFold: unsafeIndexedFold
};