// Generated by purs version 0.13.8
"use strict";
var Data_Foldable = require("../Data.Foldable/index.js");
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Monoid = require("../Data.Monoid/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var Data_Semigroup = require("../Data.Semigroup/index.js");
var Data_Semiring = require("../Data.Semiring/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Test_Spec_Result = require("../Test.Spec.Result/index.js");
var Test_Spec_Tree = require("../Test.Spec.Tree/index.js");
var Count = function (x) {
    return x;
};
var semigroupCount = new Data_Semigroup.Semigroup(function (v) {
    return function (v1) {
        return Count(Data_Semiring.add(Data_Semiring.semiringRecord()(Data_Semiring.semiringRecordCons(new Data_Symbol.IsSymbol(function () {
            return "failed";
        }))()(Data_Semiring.semiringRecordCons(new Data_Symbol.IsSymbol(function () {
            return "passed";
        }))()(Data_Semiring.semiringRecordCons(new Data_Symbol.IsSymbol(function () {
            return "pending";
        }))()(Data_Semiring.semiringRecordNil)(Data_Semiring.semiringInt))(Data_Semiring.semiringInt))(Data_Semiring.semiringInt)))(v)(v1));
    };
});
var newtypeSummary = new Data_Newtype.Newtype(function (n) {
    return n;
}, Count);
var monoidCount = new Data_Monoid.Monoid(function () {
    return semigroupCount;
}, Data_Semiring.zero(Data_Semiring.semiringRecord()(Data_Semiring.semiringRecordCons(new Data_Symbol.IsSymbol(function () {
    return "failed";
}))()(Data_Semiring.semiringRecordCons(new Data_Symbol.IsSymbol(function () {
    return "passed";
}))()(Data_Semiring.semiringRecordCons(new Data_Symbol.IsSymbol(function () {
    return "pending";
}))()(Data_Semiring.semiringRecordNil)(Data_Semiring.semiringInt))(Data_Semiring.semiringInt))(Data_Semiring.semiringInt))));
var summarize = Data_Foldable.foldMap(Data_Foldable.foldableArray)(monoidCount)(function (v) {
    if (v instanceof Test_Spec_Tree.Leaf && (v.value1 instanceof Data_Maybe.Just && v.value1.value0 instanceof Test_Spec_Result.Success)) {
        return {
            passed: 1,
            failed: 0,
            pending: 0
        };
    };
    if (v instanceof Test_Spec_Tree.Leaf && (v.value1 instanceof Data_Maybe.Just && v.value1.value0 instanceof Test_Spec_Result.Failure)) {
        return {
            passed: 0,
            failed: 1,
            pending: 0
        };
    };
    if (v instanceof Test_Spec_Tree.Leaf && v.value1 instanceof Data_Maybe.Nothing) {
        return {
            passed: 0,
            failed: 0,
            pending: 1
        };
    };
    if (v instanceof Test_Spec_Tree.Node) {
        return summarize(v.value1);
    };
    throw new Error("Failed pattern match at Test.Spec.Summary (line 25, column 21 - line 29, column 32): " + [ v.constructor.name ]);
});
var successful = function (groups) {
    return (Data_Newtype.un(newtypeSummary)(Count)(summarize(groups))).failed === 0;
};
module.exports = {
    Count: Count,
    summarize: summarize,
    successful: successful,
    newtypeSummary: newtypeSummary,
    semigroupCount: semigroupCount,
    monoidCount: monoidCount
};
