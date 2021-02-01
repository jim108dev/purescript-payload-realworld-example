// Generated by purs version 0.13.8
"use strict";
var Data_Functor = require("../Data.Functor/index.js");
var Data_Identity = require("../Data.Identity/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var Data_Profunctor_Choice = require("../Data.Profunctor.Choice/index.js");
var Data_Profunctor_Star = require("../Data.Profunctor.Star/index.js");
var Data_Profunctor_Strong = require("../Data.Profunctor.Strong/index.js");
var Wander = function (Choice1, Strong0, wander) {
    this.Choice1 = Choice1;
    this.Strong0 = Strong0;
    this.wander = wander;
};
var wanderStar = function (dictApplicative) {
    return new Wander(function () {
        return Data_Profunctor_Star.choiceStar(dictApplicative);
    }, function () {
        return Data_Profunctor_Star.strongStar((dictApplicative.Apply0()).Functor0());
    }, function (t) {
        return function (v) {
            return t(dictApplicative)(v);
        };
    });
};
var wanderFunction = new Wander(function () {
    return Data_Profunctor_Choice.choiceFn;
}, function () {
    return Data_Profunctor_Strong.strongFn;
}, function (t) {
    return Data_Newtype.alaF(Data_Functor.functorFn)(Data_Functor.functorFn)(Data_Identity.newtypeIdentity)(Data_Identity.newtypeIdentity)(Data_Identity.Identity)(t(Data_Identity.applicativeIdentity));
});
var wander = function (dict) {
    return dict.wander;
};
module.exports = {
    wander: wander,
    Wander: Wander,
    wanderFunction: wanderFunction,
    wanderStar: wanderStar
};
