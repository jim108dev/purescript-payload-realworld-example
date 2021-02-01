// Generated by purs version 0.13.8
"use strict";
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Foldable = require("../Data.Foldable/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_List_Types = require("../Data.List.Types/index.js");
var Data_Monoid = require("../Data.Monoid/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Effect_Aff = require("../Effect.Aff/index.js");
var Effect_Class = require("../Effect.Class/index.js");
var Effect_Exception = require("../Effect.Exception/index.js");
var Foreign = require("../Foreign/index.js");
var Node_Encoding = require("../Node.Encoding/index.js");
var Node_FS_Aff = require("../Node.FS.Aff/index.js");
var Server_Shell_Type_LogLevel = require("../Server.Shell.Type.LogLevel/index.js");
var Server_Shell_Type_PersistenceImpl = require("../Server.Shell.Type.PersistenceImpl/index.js");
var Simple_JSON = require("../Simple.JSON/index.js");
var read = (function () {
    var parse = function (s) {
        var v = Simple_JSON.readJSON(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "persistence";
        }))(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "database";
        }))(Simple_JSON.readString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "hostname";
        }))(Simple_JSON.readString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "impl";
        }))(Server_Shell_Type_PersistenceImpl.persistenceImplReadForeign)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "password";
        }))(Simple_JSON.readString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "user";
        }))(Simple_JSON.readString)(Simple_JSON.readFieldsNil)()())()())()())()())()()))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "server";
        }))(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "hostname";
        }))(Simple_JSON.readString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "logLevel";
        }))(Server_Shell_Type_LogLevel.logLevelReadForeign)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "port";
        }))(Simple_JSON.readInt)(Simple_JSON.readFieldsNil)()())()())()()))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "token";
        }))(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "secret";
        }))(Simple_JSON.readString)(Simple_JSON.readFieldsNil)()()))(Simple_JSON.readFieldsNil)()())()())()()))(s);
        if (v instanceof Data_Either.Left) {
            return Data_Either.Left.create(Data_Foldable.intercalate(Data_List_Types.foldableNonEmptyList)(Data_Monoid.monoidString)(".\x0a")(Data_Functor.map(Data_List_Types.functorNonEmptyList)(Foreign.renderForeignError)(v.value0)));
        };
        if (v instanceof Data_Either.Right) {
            return Control_Applicative.pure(Data_Either.applicativeEither)(v.value0);
        };
        throw new Error("Failed pattern match at Server.Shell.Util.Config (line 19, column 13 - line 21, column 22): " + [ v.constructor.name ]);
    };
    var $8 = Data_Functor.map(Effect_Aff.functorAff)(parse);
    var $9 = Node_FS_Aff.readTextFile(Node_Encoding.UTF8.value);
    return function ($10) {
        return $8($9($10));
    };
})();
var readOrThrow = function (path) {
    return Control_Bind.bind(Effect_Aff.bindAff)(read(path))(function (v) {
        if (v instanceof Data_Either.Left) {
            return Effect_Class.liftEffect(Effect_Aff.monadEffectAff)(Effect_Exception["throw"](v.value0));
        };
        if (v instanceof Data_Either.Right) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(v.value0);
        };
        throw new Error("Failed pattern match at Server.Shell.Util.Config (line 26, column 9 - line 28, column 26): " + [ v.constructor.name ]);
    });
};
module.exports = {
    read: read,
    readOrThrow: readOrThrow
};
