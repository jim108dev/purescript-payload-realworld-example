"use strict";

var crypto = require('crypto');

exports._createHash = function(algorithm) {
  return function() {
    return crypto.createHash(algorithm);
  }
}

exports.update = function(hash) {
  return function(buffer) {
    return function() {
      return hash.update(buffer);
    }
  }
}

exports.digest = function(hash) {
  return function() {
    return hash.digest();
  }
}
