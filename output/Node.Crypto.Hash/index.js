// Generated by purs version 0.13.8
"use strict";
var $foreign = require("./foreign.js");
var Control_Bind = require("../Control.Bind/index.js");
var Data_Function = require("../Data.Function/index.js");
var Data_Show = require("../Data.Show/index.js");
var Effect = require("../Effect/index.js");
var Node_Buffer = require("../Node.Buffer/index.js");
var Node_Buffer_Class = require("../Node.Buffer.Class/index.js");
var Node_Encoding = require("../Node.Encoding/index.js");
var MD5 = (function () {
    function MD5() {

    };
    MD5.value = new MD5();
    return MD5;
})();
var SHA256 = (function () {
    function SHA256() {

    };
    SHA256.value = new SHA256();
    return SHA256;
})();
var SHA512 = (function () {
    function SHA512() {

    };
    SHA512.value = new SHA512();
    return SHA512;
})();
var SHA1 = (function () {
    function SHA1() {

    };
    SHA1.value = new SHA1();
    return SHA1;
})();
var showAlgorithm = new Data_Show.Show(function (v) {
    if (v instanceof MD5) {
        return "md5";
    };
    if (v instanceof SHA256) {
        return "sha256";
    };
    if (v instanceof SHA512) {
        return "sha512";
    };
    if (v instanceof SHA1) {
        return "sha1";
    };
    throw new Error("Failed pattern match at Node.Crypto.Hash (line 24, column 1 - line 28, column 21): " + [ v.constructor.name ]);
});
var createHash = function (alg) {
    return $foreign["_createHash"](Data_Show.show(showAlgorithm)(alg));
};
var hash = function (alg) {
    return function (str) {
        return function (enc) {
            return function __do() {
                var buf = Node_Buffer_Class.fromString(Node_Buffer.mutableBufferEffect)(str)(Node_Encoding.UTF8.value)();
                return Control_Bind.bind(Effect.bindEffect)(Control_Bind.bind(Effect.bindEffect)(Control_Bind.bind(Effect.bindEffect)(createHash(alg))(Data_Function.flip($foreign.update)(buf)))($foreign.digest))(Node_Buffer_Class.toString(Node_Buffer.mutableBufferEffect)(enc))();
            };
        };
    };
};
var hex = function (alg) {
    return function (str) {
        return hash(alg)(str)(Node_Encoding.Hex.value);
    };
};
var base64 = function (alg) {
    return function (str) {
        return hash(alg)(str)(Node_Encoding.Base64.value);
    };
};
module.exports = {
    MD5: MD5,
    SHA256: SHA256,
    SHA512: SHA512,
    SHA1: SHA1,
    hex: hex,
    base64: base64,
    createHash: createHash,
    showAlgorithm: showAlgorithm,
    update: $foreign.update,
    digest: $foreign.digest
};
