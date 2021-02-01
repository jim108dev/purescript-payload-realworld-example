"use strict";

var crypto = require('crypto');

exports.timingSafeEqual = function(b1) {
  return function(b2) {
    return function() {
      return crypto.timingSafeEqual(b1, b2);
    }
  }
}

exports.randomBytes = function(size) {
  return function() {
    return crypto.randomBytes(size);
  }
}
