// Generated by purs version 0.13.8
"use strict";
var Data_Functor_Coproduct = require("../Data.Functor.Coproduct/index.js");
var Data_Lens_Iso_Newtype = require("../Data.Lens.Iso.Newtype/index.js");
var Data_Lens_Prism_Either = require("../Data.Lens.Prism.Either/index.js");
var _Right = function (dictChoice) {
    var $2 = Data_Lens_Iso_Newtype["_Newtype"](Data_Functor_Coproduct.newtypeCoproduct)(Data_Functor_Coproduct.newtypeCoproduct)(dictChoice.Profunctor0());
    var $3 = Data_Lens_Prism_Either["_Right"](dictChoice);
    return function ($4) {
        return $2($3($4));
    };
};
var _Left = function (dictChoice) {
    var $5 = Data_Lens_Iso_Newtype["_Newtype"](Data_Functor_Coproduct.newtypeCoproduct)(Data_Functor_Coproduct.newtypeCoproduct)(dictChoice.Profunctor0());
    var $6 = Data_Lens_Prism_Either["_Left"](dictChoice);
    return function ($7) {
        return $5($6($7));
    };
};
module.exports = {
    "_Left": _Left,
    "_Right": _Right
};
