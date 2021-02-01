// Generated by purs version 0.13.8
"use strict";
var Data_Argonaut_Encode_Class = require("../Data.Argonaut.Encode.Class/index.js");
var Data_Argonaut_Encode_Encoders = require("../Data.Argonaut.Encode.Encoders/index.js");
var extendOptional = function (dictEncodeJson) {
    return Data_Argonaut_Encode_Encoders.extendOptional(Data_Argonaut_Encode_Class.encodeJson(dictEncodeJson));
};
var extend = function (dictEncodeJson) {
    return Data_Argonaut_Encode_Encoders.extend(Data_Argonaut_Encode_Class.encodeJson(dictEncodeJson));
};
var assocOptional = function (dictEncodeJson) {
    return Data_Argonaut_Encode_Encoders.assocOptional(Data_Argonaut_Encode_Class.encodeJson(dictEncodeJson));
};
var assoc = function (dictEncodeJson) {
    return Data_Argonaut_Encode_Encoders.assoc(Data_Argonaut_Encode_Class.encodeJson(dictEncodeJson));
};
module.exports = {
    assoc: assoc,
    assocOptional: assocOptional,
    extend: extend,
    extendOptional: extendOptional
};
