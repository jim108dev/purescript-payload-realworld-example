// Generated by purs version 0.13.8
"use strict";
var $foreign = require("./foreign.js");
var Data_Eq = require("../Data.Eq/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var Data_Nullable = require("../Data.Nullable/index.js");
var Data_Ord = require("../Data.Ord/index.js");
var FileName = function (x) {
    return x;
};
var EntryName = function (x) {
    return x;
};
var setBlob = function (name) {
    return function (value) {
        return function (filename) {
            return function (fd) {
                return function () {
                    return $foreign["_setBlob"](name, value, Data_Nullable.toNullable(filename), fd);
                };
            };
        };
    };
};
var set = function (name) {
    return function (value) {
        return function (fd) {
            return function () {
                return $foreign["_set"](name, value, fd);
            };
        };
    };
};
var ordFileName = Data_Ord.ordString;
var ordEntryName = Data_Ord.ordString;
var newtypeFileName = new Data_Newtype.Newtype(function (n) {
    return n;
}, FileName);
var newtypeEntryName = new Data_Newtype.Newtype(function (n) {
    return n;
}, EntryName);
var has = function (name) {
    return function (fd) {
        return function () {
            return $foreign["_has"](name, fd);
        };
    };
};
var eqFileName = Data_Eq.eqString;
var eqEntryName = Data_Eq.eqString;
var $$delete = function (name) {
    return function (fd) {
        return function () {
            return $foreign["_delete"](name, fd);
        };
    };
};
var appendBlob = function (name) {
    return function (value) {
        return function (filename) {
            return function (fd) {
                return function () {
                    return $foreign["_appendBlob"](name, value, Data_Nullable.toNullable(filename), fd);
                };
            };
        };
    };
};
var append = function (name) {
    return function (value) {
        return function (fd) {
            return function () {
                return $foreign["_append"](name, value, fd);
            };
        };
    };
};
module.exports = {
    EntryName: EntryName,
    FileName: FileName,
    append: append,
    appendBlob: appendBlob,
    "delete": $$delete,
    has: has,
    set: set,
    setBlob: setBlob,
    eqEntryName: eqEntryName,
    ordEntryName: ordEntryName,
    newtypeEntryName: newtypeEntryName,
    eqFileName: eqFileName,
    ordFileName: ordFileName,
    newtypeFileName: newtypeFileName,
    "new": $foreign["new"]
};
