"use strict";

var url = require("url");
var queryString = require("querystring");

exports.parse = url.parse;

exports.format = url.format;

exports.resolve = function (from) {
  return function (to) {
    return url.resolve(from, to);
  };
};

exports.parseQueryString = queryString.parse;

exports.toQueryString = queryString.stringify;
