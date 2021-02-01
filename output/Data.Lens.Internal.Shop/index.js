// Generated by purs version 0.13.8
"use strict";
var Data_Profunctor = require("../Data.Profunctor/index.js");
var Data_Profunctor_Strong = require("../Data.Profunctor.Strong/index.js");
var Data_Tuple = require("../Data.Tuple/index.js");
var Shop = (function () {
    function Shop(value0, value1) {
        this.value0 = value0;
        this.value1 = value1;
    };
    Shop.create = function (value0) {
        return function (value1) {
            return new Shop(value0, value1);
        };
    };
    return Shop;
})();
var profunctorShop = new Data_Profunctor.Profunctor(function (f) {
    return function (g) {
        return function (v) {
            return new Shop(function ($30) {
                return v.value0(f($30));
            }, function (s) {
                var $31 = v.value1(f(s));
                return function ($32) {
                    return g($31($32));
                };
            });
        };
    };
});
var strongShop = new Data_Profunctor_Strong.Strong(function () {
    return profunctorShop;
}, function (v) {
    return new Shop(function (v1) {
        return v.value0(v1.value0);
    }, function (v1) {
        return function (b) {
            return new Data_Tuple.Tuple(v.value1(v1.value0)(b), v1.value1);
        };
    });
}, function (v) {
    return new Shop(function (v1) {
        return v.value0(v1.value1);
    }, function (v1) {
        return function (b) {
            return new Data_Tuple.Tuple(v1.value0, v.value1(v1.value1)(b));
        };
    });
});
module.exports = {
    Shop: Shop,
    profunctorShop: profunctorShop,
    strongShop: strongShop
};