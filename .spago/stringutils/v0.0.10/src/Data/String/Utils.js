"use strict";

function codePointAtImpl (just, nothing, i, s) {
  var codePointArray = Array.from(s);
  var isWithinRange  = i >= 0 && i < codePointArray.length;

  return isWithinRange ? just(codePointArray[i].codePointAt(0)) : nothing;
}

function codePointAtPrimeImpl (just, nothing, i, s) {
  return i >= 0 && i < s.length ? just(s.codePointAt(i)) : nothing;
}

function endsWithImpl (searchString, s) {
  return s.endsWith(searchString);
}

function endsWithPrimeImpl (searchString, position, s) {
  return s.endsWith(searchString, position);
}

function escapeRegexImpl (str) {
  return str.replace(/[.*+?^${}()|[\]\-\\]/g, "\\$&");
}

function fromCharArrayImpl (array) {
  return array.join("");
}

function includesImpl (searchString, str) {
  return str.includes(searchString);
}

function includesPrimeImpl (needle, position, haystack) {
  // For negative `position` values, we search from the beginning of the
  // string. This is in accordance with the native
  // `String.prototype.include` function.
  var pos = Math.max(0, position);

  // Converting to arrays takes care of any surrogate code points
  var needleA    = Array.from(needle);
  var haystackA  = Array.from(haystack).slice(pos);
  var needleALen = needleA.length;

  var maxIndex = haystackA.length + 1 - needleALen;
  var found    = false;
  var i;

  // Naive implementation, at some point we should check whether Boyer-Moore
  // or Knuth-Morris-Pratt are worthwhile
  for (i = 0; i < maxIndex; i++) {
    if (needleA.every(function (e, j) { return e === haystackA[i+j]; })) {
      found = true;
      break;
    }
  }

  return found;
}

function lengthImpl (str) {
  return Array.from(str).length;
}

function linesImpl (str) {
  // See http://www.unicode.org/reports/tr18/#RL1.6
  return str.split(/\r\n|[\n\v\f\r\u0085\u2028\u2029]/);
}

function normalizeImpl (str) {
  return str.normalize();
}

function normalizePrimeImpl (normalizationForm, str) {
  return str.normalize(normalizationForm);
}

function padEndPrimeImpl (targetLength, str) {
  return str.padEnd(targetLength);
}

function padStartPrimeImpl (targetLength, str) {
  return str.padStart(targetLength);
}

function repeatImpl (just, nothing, n, str) {
  var result;

  try {
    result = just(str.repeat(n));
  }
  catch (error) {
    result = nothing;
  }

  return result;
}

function startsWithImpl (searchString, s) {
  return s.startsWith(searchString);
}

function startsWithPrimeImpl (searchString, position, s) {
  return s.startsWith(searchString, position);
}

function stripCharsImpl (chars, s) {
  return s.replace(RegExp("[" + escapeRegexImpl(chars) + "]", "g"), "");
}

function stripDiacriticsImpl (str) {
  return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
}

function toCharArrayImpl (str) {
  return Array.from(str);
}

function unsafeCodePointAtImpl (i, s) {
  var codePointArray = Array.from(s);
  var isWithinRange = i >= 0 && i < codePointArray.length;

  if (isWithinRange) {
    return codePointArray[i].codePointAt(0);
  }
  else {
    throw new Error("Data.String.Utils.unsafeCodePointAt: Invalid index");
  }
}

function unsafeCodePointAtPrimeImpl (i, s) {
  if (i >= 0 && i < s.length) {
    return s.codePointAt(i);
  }
  else {
    throw new Error("Data.String.Utils.unsafeCodePointAt': Invalid index");
  }
}

function unsafeRepeatImpl (n, str) {
  try {
    return str.repeat(n);
  }
  catch (error) {
    throw new Error("Data.String.Utils.unsafeRepeat: Invalid count");
  }
}

function wordsImpl (s) {
  // Split at every Unicode whitespace character (25 as of Unicode 12.1)
  return s.split(/[\u000a-\u000d\u0085\u2028\u2029\u0009\u0020\u00a0\u1680\u2000-\u200a\u202f\u205f\u3000]+/);
}

exports.codePointAtImpl            = codePointAtImpl;
exports.codePointAtPrimeImpl       = codePointAtPrimeImpl;
exports.endsWithImpl               = endsWithImpl;
exports.endsWithPrimeImpl          = endsWithPrimeImpl;
exports.escapeRegexImpl            = escapeRegexImpl;
exports.fromCharArrayImpl          = fromCharArrayImpl;
exports.includesImpl               = includesImpl;
exports.includesPrimeImpl          = includesPrimeImpl;
exports.lengthImpl                 = lengthImpl;
exports.linesImpl                  = linesImpl;
exports.normalizeImpl              = normalizeImpl;
exports.normalizePrimeImpl         = normalizePrimeImpl;
exports.padEndPrimeImpl            = padEndPrimeImpl;
exports.padStartPrimeImpl          = padStartPrimeImpl;
exports.repeatImpl                 = repeatImpl;
exports.startsWithImpl             = startsWithImpl;
exports.startsWithPrimeImpl        = startsWithPrimeImpl;
exports.stripCharsImpl             = stripCharsImpl;
exports.stripDiacriticsImpl        = stripDiacriticsImpl;
exports.toCharArrayImpl            = toCharArrayImpl;
exports.unsafeCodePointAtImpl      = unsafeCodePointAtImpl;
exports.unsafeCodePointAtPrimeImpl = unsafeCodePointAtPrimeImpl;
exports.unsafeRepeatImpl           = unsafeRepeatImpl;
exports.wordsImpl                  = wordsImpl;
