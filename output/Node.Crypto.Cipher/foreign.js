"use strict";

var crypto = require('crypto');

exports._createCipher = function(algorithm) {
  return function(password) {
    return function() {
      return crypto.createCipher(algorithm, password);
    }
  }
}

exports.update = function(cipher) {
  return function(buffer) {
    return function() {
      return cipher.update(buffer);
    }
  }
}

exports.final = function(cipher) {
  return function() {
    return cipher.final();
  }
}
