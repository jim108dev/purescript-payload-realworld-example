// Generated by purs version 0.13.8
"use strict";
var Control_Comonad_Store = require("../Control.Comonad.Store/index.js");
var Data_Exists = require("../Data.Exists/index.js");
var Data_Function = require("../Data.Function/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var NuF = function (x) {
    return x;
};
var Nu = function (x) {
    return x;
};
var unfold = function (pos) {
    return function (peek) {
        return Nu(Data_Exists.mkExists(NuF(Control_Comonad_Store.store(peek)(pos))));
    };
};
var observeF = function (dictFunctor) {
    return function (v) {
        var v1 = Control_Comonad_Store.runStore(v);
        return Data_Functor.map(dictFunctor)(Data_Function.flip(unfold)(v1.value0))(v1.value0(v1.value1));
    };
};
var observe = function (dictFunctor) {
    return function (v) {
        return Data_Exists.runExists(observeF(dictFunctor))(v);
    };
};
var newtypeNu = new Data_Newtype.Newtype(function (n) {
    return n;
}, Nu);
module.exports = {
    Nu: Nu,
    NuF: NuF,
    unfold: unfold,
    observe: observe,
    newtypeNu: newtypeNu
};