// Generated by purs version 0.13.8
"use strict";
var Control_Category = require("../Control.Category/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var Profunctor = function (dimap) {
    this.dimap = dimap;
};
var profunctorFn = new Profunctor(function (a2b) {
    return function (c2d) {
        return function (b2c) {
            return function ($9) {
                return c2d(b2c(a2b($9)));
            };
        };
    };
});
var dimap = function (dict) {
    return dict.dimap;
};
var lcmap = function (dictProfunctor) {
    return function (a2b) {
        return dimap(dictProfunctor)(a2b)(Control_Category.identity(Control_Category.categoryFn));
    };
};
var rmap = function (dictProfunctor) {
    return function (b2c) {
        return dimap(dictProfunctor)(Control_Category.identity(Control_Category.categoryFn))(b2c);
    };
};
var unwrapIso = function (dictProfunctor) {
    return function (dictNewtype) {
        return dimap(dictProfunctor)(Data_Newtype.wrap(dictNewtype))(Data_Newtype.unwrap(dictNewtype));
    };
};
var wrapIso = function (dictProfunctor) {
    return function (dictNewtype) {
        return function (v) {
            return dimap(dictProfunctor)(Data_Newtype.unwrap(dictNewtype))(Data_Newtype.wrap(dictNewtype));
        };
    };
};
var arr = function (dictCategory) {
    return function (dictProfunctor) {
        return function (f) {
            return rmap(dictProfunctor)(f)(Control_Category.identity(dictCategory));
        };
    };
};
module.exports = {
    dimap: dimap,
    Profunctor: Profunctor,
    lcmap: lcmap,
    rmap: rmap,
    arr: arr,
    unwrapIso: unwrapIso,
    wrapIso: wrapIso,
    profunctorFn: profunctorFn
};