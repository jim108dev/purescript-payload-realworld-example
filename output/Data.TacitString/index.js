// Generated by purs version 0.13.8
"use strict";
var Data_Eq = require("../Data.Eq/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var Data_Ord = require("../Data.Ord/index.js");
var Data_Show = require("../Data.Show/index.js");
var TacitString = function (x) {
    return x;
};
var showTacitString = new Data_Show.Show(function (v) {
    return v;
});
var newtypeTacitString = new Data_Newtype.Newtype(function (n) {
    return n;
}, TacitString);
var hush = TacitString;
var eqTacitString = new Data_Eq.Eq(function (x) {
    return function (y) {
        return x === y;
    };
});
var ordTacitString = new Data_Ord.Ord(function () {
    return eqTacitString;
}, function (x) {
    return function (y) {
        return Data_Ord.compare(Data_Ord.ordString)(x)(y);
    };
});
module.exports = {
    hush: hush,
    newtypeTacitString: newtypeTacitString,
    eqTacitString: eqTacitString,
    ordTacitString: ordTacitString,
    showTacitString: showTacitString
};