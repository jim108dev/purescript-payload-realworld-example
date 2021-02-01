// Generated by purs version 0.13.8
"use strict";
var Data_Function = require("../Data.Function/index.js");
var Data_Functor_Contravariant = require("../Data.Functor.Contravariant/index.js");
var Data_Monoid = require("../Data.Monoid/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var Data_Ord = require("../Data.Ord/index.js");
var Data_Ordering = require("../Data.Ordering/index.js");
var Data_Semigroup = require("../Data.Semigroup/index.js");
var Comparison = function (x) {
    return x;
};
var semigroupComparison = new Data_Semigroup.Semigroup(function (v) {
    return function (v1) {
        return Data_Semigroup.append(Data_Semigroup.semigroupFn(Data_Semigroup.semigroupFn(Data_Ordering.semigroupOrdering)))(v)(v1);
    };
});
var newtypeComparison = new Data_Newtype.Newtype(function (n) {
    return n;
}, Comparison);
var monoidComparison = new Data_Monoid.Monoid(function () {
    return semigroupComparison;
}, function (v) {
    return function (v1) {
        return Data_Ordering.EQ.value;
    };
});
var defaultComparison = function (dictOrd) {
    return Data_Ord.compare(dictOrd);
};
var contravariantComparison = new Data_Functor_Contravariant.Contravariant(function (f) {
    return function (v) {
        return Data_Function.on(v)(f);
    };
});
module.exports = {
    Comparison: Comparison,
    defaultComparison: defaultComparison,
    newtypeComparison: newtypeComparison,
    contravariantComparison: contravariantComparison,
    semigroupComparison: semigroupComparison,
    monoidComparison: monoidComparison
};
