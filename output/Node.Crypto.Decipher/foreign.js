"use strict";

var crypto = require('crypto');

exports._createDecipher = function(algorithm) {
  return function(password) {
    return function() {
      return crypto.createDecipher(algorithm, password);
    }
  }
}

exports.update = function(decipher) {
  return function(buffer) {
    return function() {
      return decipher.update(buffer);
    }
  }
}

exports.final = function(decipher) {
  return function() {
    return decipher.final();
  }
}
