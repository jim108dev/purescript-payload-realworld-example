"use strict";

var crypto = require('crypto');

exports._createHmac = function(algorithm) {
  return function(secret) {
    return function() {
      return crypto.createHmac(algorithm, secret);
    }
  }
}

exports.update = function(hmac) {
  return function(buffer) {
    return function() {
      return hmac.update(buffer);
    }
  }
}

exports.digest = function(hmac) {
  return function() {
    return hmac.digest();
  }
}
