/* global exports */
/* global require */
"use strict";

// module Gzip

exports.gzip = require('zlib').createGzip;
exports.stdout = process.stdout;
exports.stdin = process.stdin;
