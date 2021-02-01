// Generated by purs version 0.13.8
"use strict";
var Data_Bifunctor = require("../Data.Bifunctor/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Eq = require("../Data.Eq/index.js");
var Data_Generic_Rep = require("../Data.Generic.Rep/index.js");
var Data_Generic_Rep_Eq = require("../Data.Generic.Rep.Eq/index.js");
var Data_Generic_Rep_Show = require("../Data.Generic.Rep.Show/index.js");
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Foreign_Generic = require("../Foreign.Generic/index.js");
var Foreign_Generic_Class = require("../Foreign.Generic.Class/index.js");
var Payload_Server_DecodeBody = require("../Payload.Server.DecodeBody/index.js");
var Server_Shared_Api_Main = require("../Server.Shared.Api.Main/index.js");
var Shared_Type_LongString = require("../Shared.Type.LongString/index.js");
var Shared_Type_LowercaseString = require("../Shared.Type.LowercaseString/index.js");
var Shared_Type_ShortString = require("../Shared.Type.ShortString/index.js");
var Simple_JSON = require("../Simple.JSON/index.js");
var CreateDto = function (x) {
    return x;
};
var writeForeignCreateDto = Simple_JSON.recordWriteForeign()(Simple_JSON.consWriteForeignFields(new Data_Symbol.IsSymbol(function () {
    return "article";
}))(Simple_JSON.recordWriteForeign()(Simple_JSON.consWriteForeignFields(new Data_Symbol.IsSymbol(function () {
    return "body";
}))(Shared_Type_LongString.writeForeignLongString)(Simple_JSON.consWriteForeignFields(new Data_Symbol.IsSymbol(function () {
    return "description";
}))(Shared_Type_LongString.writeForeignLongString)(Simple_JSON.consWriteForeignFields(new Data_Symbol.IsSymbol(function () {
    return "tagList";
}))(Simple_JSON.writeForeignMaybe(Simple_JSON.writeForeignArray(Shared_Type_LowercaseString.writeForeignLowercaseString)))(Simple_JSON.consWriteForeignFields(new Data_Symbol.IsSymbol(function () {
    return "title";
}))(Shared_Type_ShortString.writeForeignShortString)(Simple_JSON.nilWriteForeignFields)()()())()()())()()())()()()))(Simple_JSON.nilWriteForeignFields)()()());
var wrapCreateDto = function (x) {
    return {
        article: x
    };
};
var unwrapCreateDto = function (v) {
    return v.article;
};
var readForeignCreateDto = Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "article";
}))(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "body";
}))(Shared_Type_LongString.readForeignLongString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "description";
}))(Shared_Type_LongString.readForeignLongString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "tagList";
}))(Simple_JSON.readMaybe(Simple_JSON.readArray(Shared_Type_LowercaseString.readForeignLowercaseString)))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "title";
}))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()()))(Simple_JSON.readFieldsNil)()());
var genericCreateDto = new Data_Generic_Rep.Generic(function (x) {
    return x;
}, function (x) {
    return x;
});
var showCreateDto = new Data_Show.Show(Data_Generic_Rep_Show.genericShow(genericCreateDto)(Data_Generic_Rep_Show.genericShowConstructor(Data_Generic_Rep_Show.genericShowArgsArgument(Data_Show.showRecord()(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "article";
}))(Data_Show.showRecordFieldsNil)(Data_Show.showRecord()(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "body";
}))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "description";
}))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "tagList";
}))(Data_Show.showRecordFieldsCons(new Data_Symbol.IsSymbol(function () {
    return "title";
}))(Data_Show.showRecordFieldsNil)(Shared_Type_ShortString.showShortString))(Data_Maybe.showMaybe(Data_Show.showArray(Shared_Type_LowercaseString.showLowercaseString))))(Shared_Type_LongString.showLongString))(Shared_Type_LongString.showLongString))))))(new Data_Symbol.IsSymbol(function () {
    return "CreateDto";
}))));
var eqCreateDto = new Data_Eq.Eq(Data_Generic_Rep_Eq.genericEq(genericCreateDto)(Data_Generic_Rep_Eq.genericEqConstructor(Data_Generic_Rep_Eq.genericEqArgument(Data_Eq.eqRec()(Data_Eq.eqRowCons(Data_Eq.eqRowNil)()(new Data_Symbol.IsSymbol(function () {
    return "article";
}))(Data_Eq.eqRec()(Data_Eq.eqRowCons(Data_Eq.eqRowCons(Data_Eq.eqRowCons(Data_Eq.eqRowCons(Data_Eq.eqRowNil)()(new Data_Symbol.IsSymbol(function () {
    return "title";
}))(Shared_Type_ShortString.eqShortString))()(new Data_Symbol.IsSymbol(function () {
    return "tagList";
}))(Data_Maybe.eqMaybe(Data_Eq.eqArray(Shared_Type_LowercaseString.eqLowercaseString))))()(new Data_Symbol.IsSymbol(function () {
    return "description";
}))(Shared_Type_LongString.eqLongString))()(new Data_Symbol.IsSymbol(function () {
    return "body";
}))(Shared_Type_LongString.eqLongString))))))));
var encodeCreateDto = new Foreign_Generic_Class.Encode(Foreign_Generic.genericEncode(genericCreateDto)(Foreign_Generic_Class.genericEncodeConstructor(new Data_Symbol.IsSymbol(function () {
    return "CreateDto";
}))(Foreign_Generic_Class.genericEncodeArgsArgument(Foreign_Generic_Class.encodeWithOptionsRecord()(Foreign_Generic_Class.encodeRecordCons()(Foreign_Generic_Class.encodeRecordNil)(new Data_Symbol.IsSymbol(function () {
    return "article";
}))(Foreign_Generic_Class.encodeWithOptionsRecord()(Foreign_Generic_Class.encodeRecordCons()(Foreign_Generic_Class.encodeRecordCons()(Foreign_Generic_Class.encodeRecordCons()(Foreign_Generic_Class.encodeRecordCons()(Foreign_Generic_Class.encodeRecordNil)(new Data_Symbol.IsSymbol(function () {
    return "title";
}))(Foreign_Generic_Class.encodeWithOptionsOther(Shared_Type_ShortString.encodeShortString)))(new Data_Symbol.IsSymbol(function () {
    return "tagList";
}))(Foreign_Generic_Class.encodeWithOptionsOther(Foreign_Generic_Class.maybeEncode(Foreign_Generic_Class.arrayEncode(Shared_Type_LowercaseString.encodeLowercaseString)))))(new Data_Symbol.IsSymbol(function () {
    return "description";
}))(Foreign_Generic_Class.encodeWithOptionsOther(Shared_Type_LongString.encodeLongString)))(new Data_Symbol.IsSymbol(function () {
    return "body";
}))(Foreign_Generic_Class.encodeWithOptionsOther(Shared_Type_LongString.encodeLongString))))))))({
    sumEncoding: Foreign_Generic_Class.defaultOptions.sumEncoding,
    unwrapSingleConstructors: true,
    unwrapSingleArguments: Foreign_Generic_Class.defaultOptions.unwrapSingleArguments,
    fieldTransform: Foreign_Generic_Class.defaultOptions.fieldTransform
}));
var decodeCreateDto = new Foreign_Generic_Class.Decode(Foreign_Generic.genericDecode(genericCreateDto)(Foreign_Generic_Class.genericDecodeConstructor(new Data_Symbol.IsSymbol(function () {
    return "CreateDto";
}))(Foreign_Generic_Class.genericDecodeArgsArgument(Foreign_Generic_Class.decodeWithOptionsRecord()(Foreign_Generic_Class.decodeRecordCons()(Foreign_Generic_Class.decodeRecordNil)(new Data_Symbol.IsSymbol(function () {
    return "article";
}))(Foreign_Generic_Class.decodeWithOptionsRecord()(Foreign_Generic_Class.decodeRecordCons()(Foreign_Generic_Class.decodeRecordCons()(Foreign_Generic_Class.decodeRecordCons()(Foreign_Generic_Class.decodeRecordCons()(Foreign_Generic_Class.decodeRecordNil)(new Data_Symbol.IsSymbol(function () {
    return "title";
}))(Foreign_Generic_Class.decodeWithOptionsOther(Shared_Type_ShortString.decodeShortString))())(new Data_Symbol.IsSymbol(function () {
    return "tagList";
}))(Foreign_Generic_Class.decodeWithOptionsOther(Foreign_Generic_Class.maybeDecode(Foreign_Generic_Class.arrayDecode(Shared_Type_LowercaseString.decodeLowercaseString))))())(new Data_Symbol.IsSymbol(function () {
    return "description";
}))(Foreign_Generic_Class.decodeWithOptionsOther(Shared_Type_LongString.decodeLongString))())(new Data_Symbol.IsSymbol(function () {
    return "body";
}))(Foreign_Generic_Class.decodeWithOptionsOther(Shared_Type_LongString.decodeLongString))()))())))(Foreign_Generic_Class.genericCountArgsArgument))({
    sumEncoding: Foreign_Generic_Class.defaultOptions.sumEncoding,
    unwrapSingleConstructors: true,
    unwrapSingleArguments: Foreign_Generic_Class.defaultOptions.unwrapSingleArguments,
    fieldTransform: Foreign_Generic_Class.defaultOptions.fieldTransform
}));
var decodeBodyCreateDto = function (dictReadForeign) {
    return new Payload_Server_DecodeBody.DecodeBody((function () {
        var $10 = Data_Bifunctor.lmap(Data_Either.bifunctorEither)(Server_Shared_Api_Main.renderJsonErrors);
        var $11 = Simple_JSON.readJSON(dictReadForeign);
        return function ($12) {
            return $10($11($12));
        };
    })());
};
module.exports = {
    CreateDto: CreateDto,
    wrapCreateDto: wrapCreateDto,
    unwrapCreateDto: unwrapCreateDto,
    genericCreateDto: genericCreateDto,
    showCreateDto: showCreateDto,
    eqCreateDto: eqCreateDto,
    decodeCreateDto: decodeCreateDto,
    encodeCreateDto: encodeCreateDto,
    readForeignCreateDto: readForeignCreateDto,
    writeForeignCreateDto: writeForeignCreateDto,
    decodeBodyCreateDto: decodeBodyCreateDto
};
