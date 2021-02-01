// Generated by purs version 0.13.8
"use strict";
var Control_Category = require("../Control.Category/index.js");
var Control_Monad_ST_Global = require("../Control.Monad.ST.Global/index.js");
var MonadST = function (liftST) {
    this.liftST = liftST;
};
var monadSTST = new MonadST(Control_Category.identity(Control_Category.categoryFn));
var monadSTEffect = new MonadST(Control_Monad_ST_Global.toEffect);
var liftST = function (dict) {
    return dict.liftST;
};
module.exports = {
    liftST: liftST,
    MonadST: MonadST,
    monadSTEffect: monadSTEffect,
    monadSTST: monadSTST
};
