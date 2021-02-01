// Generated by purs version 0.13.8
"use strict";
var Control_Apply = require("../Control.Apply/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Control_Monad_Gen = require("../Control.Monad.Gen/index.js");
var Control_Monad_Gen_Class = require("../Control.Monad.Gen.Class/index.js");
var Data_Function = require("../Data.Function/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_List_Types = require("../Data.List.Types/index.js");
var Data_Tuple = require("../Data.Tuple/index.js");
var Foreign_Object = require("../Foreign.Object/index.js");
var genForeignObject = function (dictMonadRec) {
    return function (dictMonadGen) {
        return function (genKey) {
            return function (genValue) {
                return Control_Monad_Gen_Class.sized(dictMonadGen)(function (size) {
                    return Control_Bind.bind((dictMonadGen.Monad0()).Bind1())(Control_Monad_Gen_Class.chooseInt(dictMonadGen)(0)(size))(function (newSize) {
                        return Control_Monad_Gen_Class.resize(dictMonadGen)(Data_Function["const"](newSize))(Data_Functor.map((((dictMonadGen.Monad0()).Bind1()).Apply0()).Functor0())(Foreign_Object.fromFoldable(Data_List_Types.foldableList))(Control_Monad_Gen.unfoldable(dictMonadRec)(dictMonadGen)(Data_List_Types.unfoldableList)(Control_Apply.apply(((dictMonadGen.Monad0()).Bind1()).Apply0())(Data_Functor.map((((dictMonadGen.Monad0()).Bind1()).Apply0()).Functor0())(Data_Tuple.Tuple.create)(genKey))(genValue))));
                    });
                });
            };
        };
    };
};
module.exports = {
    genForeignObject: genForeignObject
};
