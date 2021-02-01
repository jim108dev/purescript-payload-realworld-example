"use strict";

exports.writableStreamBuffer = function() {
  var W = require('stream-buffers').WritableStreamBuffer;
  return new W;
};

exports.getContentsAsString = function(w) {
  return function() {
    return w.getContentsAsString('utf8');
  };
};

exports.readableStreamBuffer = function() {
  var R = require('stream-buffers').ReadableStreamBuffer;
  return new R;
};

exports.putImpl = function(str) {
  return function(enc) {
    return function(r) {
      return function() {
        r.put(str, enc);
      };
    };
  };
};

exports.createGzip = require('zlib').createGzip;
exports.createGunzip = require('zlib').createGunzip;

exports.passThrough = function () {
    var s = require('stream');
    return new s.PassThrough();
};
