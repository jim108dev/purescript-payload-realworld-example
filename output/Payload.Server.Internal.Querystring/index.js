// Generated by purs version 0.13.8
"use strict";
var $foreign = require("./foreign.js");
var DecodeQuery = function (decodeQuery) {
    this.decodeQuery = decodeQuery;
};
var decodeQuery = function (dict) {
    return dict.decodeQuery;
};
module.exports = {
    decodeQuery: decodeQuery,
    DecodeQuery: DecodeQuery,
    querystringParse: $foreign.querystringParse
};