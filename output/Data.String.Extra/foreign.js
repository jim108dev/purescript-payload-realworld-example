/* eslint-disable no-undef */
"use strict";

// Source: https://github.com/hiddentao/fast-levenshtein/blob/master/levenshtein.js
// Benchmark: https://jsperf.com/levenshtein-distance2
exports.levenshtein = function (str1) {
  return function (str2) {
    var prevRow = [],
      str2Char = [];

    var str1Len = str1.length,
      str2Len = str2.length;

    // base cases
    if (str1Len === 0) return str2Len;
    if (str2Len === 0) return str1Len;

    // two rows
    var curCol, nextCol, i, j, tmp;

    // initialise previous row
    for (i = 0; i < str2Len; ++i) {
      prevRow[i] = i;
      str2Char[i] = str2.charCodeAt(i);
    }

    prevRow[str2Len] = str2Len;

    var strCmp;

    // calculate current row distance from previous row without collator
    for (i = 0; i < str1Len; ++i) {
      nextCol = i + 1;

      for (j = 0; j < str2Len; ++j) {
        curCol = nextCol;

        // substution
        strCmp = str1.charCodeAt(i) === str2Char[j];

        nextCol = prevRow[j] + (strCmp ? 0 : 1);

        // insertion
        tmp = curCol + 1;
        if (nextCol > tmp) {
          nextCol = tmp;
        }

        // deletion
        tmp = prevRow[j + 1] + 1;
        if (nextCol > tmp) {
          nextCol = tmp;
        }

        // copy current col value into previous (in preparation for next iteration)
        prevRow[j] = curCol;
      }

      // copy last col value into previous (in preparation for next iteration)
      prevRow[j] = nextCol;
    }

    return nextCol;
  };
};

// Source: https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Dice%27s_coefficient#Javascript
// Benchmark: https://jsperf.com/sorensen-dice-coefficient
exports.sorensenDiceCoefficient = function (l) {
  return function (r) {
    if (l.length < 2 || r.length < 2) return 0;

    var lBigrams = new Map();

    for (var i = 0; i < l.length - 1; i++) {
      var lBigram = l.substr(i, 2);
      var lCount = lBigrams.has(lBigram) ? lBigrams.get(lBigram) + 1 : 1;

      lBigrams.set(lBigram, lCount);
    }

    var intersectionSize = 0;
    for (var j = 0; j < r.length - 1; j++) {
      var rBigram = r.substr(j, 2);
      var rCount = lBigrams.has(rBigram) ? lBigrams.get(rBigram) : 0;

      if (rCount > 0) {
        lBigrams.set(rBigram, rCount - 1);
        intersectionSize++;
      }
    }

    return (2.0 * intersectionSize) / (l.length + r.length - 2);
  };
};
