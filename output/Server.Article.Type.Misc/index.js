// Generated by purs version 0.13.8
"use strict";
var Data_Maybe = require("../Data.Maybe/index.js");
var SLUG_EXISTS = (function () {
    function SLUG_EXISTS() {

    };
    SLUG_EXISTS.value = new SLUG_EXISTS();
    return SLUG_EXISTS;
})();
var TITLE_EXISTS = (function () {
    function TITLE_EXISTS() {

    };
    TITLE_EXISTS.value = new TITLE_EXISTS();
    return TITLE_EXISTS;
})();
var NOT_FOUND = (function () {
    function NOT_FOUND() {

    };
    NOT_FOUND.value = new NOT_FOUND();
    return NOT_FOUND;
})();
var FAVORITED_EXISTS = (function () {
    function FAVORITED_EXISTS() {

    };
    FAVORITED_EXISTS.value = new FAVORITED_EXISTS();
    return FAVORITED_EXISTS;
})();
var SLUG_CREATION_FAILED = (function () {
    function SLUG_CREATION_FAILED() {

    };
    SLUG_CREATION_FAILED.value = new SLUG_CREATION_FAILED();
    return SLUG_CREATION_FAILED;
})();
var mkRawFromPatch = function (f) {
    return function (p) {
        return {
            body: Data_Maybe.fromMaybe(f.body)(p.body),
            description: Data_Maybe.fromMaybe(f.description)(p.description),
            title: Data_Maybe.fromMaybe(f.title)(p.title),
            tagList: Data_Maybe.Nothing.value
        };
    };
};
module.exports = {
    mkRawFromPatch: mkRawFromPatch,
    SLUG_EXISTS: SLUG_EXISTS,
    TITLE_EXISTS: TITLE_EXISTS,
    NOT_FOUND: NOT_FOUND,
    FAVORITED_EXISTS: FAVORITED_EXISTS,
    SLUG_CREATION_FAILED: SLUG_CREATION_FAILED
};