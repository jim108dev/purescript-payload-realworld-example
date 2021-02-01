// Generated by purs version 0.13.8
"use strict";
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Control_Monad_Except_Trans = require("../Control.Monad.Except.Trans/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Eq = require("../Data.Eq/index.js");
var Data_Generic_Rep = require("../Data.Generic.Rep/index.js");
var Data_Generic_Rep_Show = require("../Data.Generic.Rep.Show/index.js");
var Data_Identity = require("../Data.Identity/index.js");
var Data_List_Types = require("../Data.List.Types/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_String_CodePoints = require("../Data.String.CodePoints/index.js");
var Data_String_Common = require("../Data.String.Common/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Database_Postgres_SqlValue = require("../Database.Postgres.SqlValue/index.js");
var Foreign = require("../Foreign/index.js");
var Foreign_Generic = require("../Foreign.Generic/index.js");
var Foreign_Generic_Class = require("../Foreign.Generic.Class/index.js");
var Payload_Server_Params = require("../Payload.Server.Params/index.js");
var Simple_JSON = require("../Simple.JSON/index.js");
var Unsafe_Coerce = require("../Unsafe.Coerce/index.js");
var LongString = function (x) {
    return x;
};
var toString = function (v) {
    return v;
};
var writeImpl = function ($17) {
    return Foreign.unsafeToForeign(toString($17));
};
var writeForeignLongString = new Simple_JSON.WriteForeign(writeImpl);
var isSqlValueShortString = new Database_Postgres_SqlValue.IsSqlValue(Unsafe_Coerce.unsafeCoerce);
var genericLongString = new Data_Generic_Rep.Generic(function (x) {
    return x;
}, function (x) {
    return x;
});
var showLongString = new Data_Show.Show(Data_Generic_Rep_Show.genericShow(genericLongString)(Data_Generic_Rep_Show.genericShowConstructor(Data_Generic_Rep_Show.genericShowArgsArgument(Data_Show.showString))(new Data_Symbol.IsSymbol(function () {
    return "LongString";
}))));
var fromString = function (s) {
    var len = Data_String_CodePoints.length(s);
    if (len === 0) {
        return new Data_Either.Left("can't be empty");
    };
    if (len > 1000) {
        return new Data_Either.Left("can't be longer than 1000 characters");
    };
    return new Data_Either.Right(s);
};
var readImpl = function (f) {
    return Control_Bind.bind(Control_Monad_Except_Trans.bindExceptT(Data_Identity.monadIdentity))(Simple_JSON.readImpl(Simple_JSON.readString)(f))(function (v) {
        return Control_Monad_Except_Trans.except(Data_Identity.applicativeIdentity)((function () {
            var v1 = fromString(v);
            if (v1 instanceof Data_Either.Left) {
                return Data_Either.Left.create(Control_Applicative.pure(Data_List_Types.applicativeNonEmptyList)(new Foreign.ForeignError(v1.value0)));
            };
            if (v1 instanceof Data_Either.Right) {
                return new Data_Either.Right(v1.value0);
            };
            throw new Error("Failed pattern match at Shared.Type.LongString (line 61, column 10 - line 63, column 23): " + [ v1.constructor.name ]);
        })());
    });
};
var readForeignLongString = new Simple_JSON.ReadForeign(readImpl);
var unsafeFromString = function (dictPartial) {
    var $18 = Data_Either.fromRight();
    return function ($19) {
        return $18(fromString($19));
    };
};
var l_ = function (dictPartial) {
    return unsafeFromString();
};
var eqLongString = new Data_Eq.Eq(function (o1) {
    return function (o2) {
        return Data_String_Common.toLower(toString(o1)) === Data_String_Common.toLower(toString(o2));
    };
});
var encodeLongString = new Foreign_Generic_Class.Encode(Foreign_Generic.genericEncode(genericLongString)(Foreign_Generic_Class.genericEncodeConstructor(new Data_Symbol.IsSymbol(function () {
    return "LongString";
}))(Foreign_Generic_Class.genericEncodeArgsArgument(Foreign_Generic_Class.encodeWithOptionsOther(Foreign_Generic_Class.stringEncode))))({
    sumEncoding: Foreign_Generic_Class.defaultOptions.sumEncoding,
    unwrapSingleConstructors: true,
    unwrapSingleArguments: Foreign_Generic_Class.defaultOptions.unwrapSingleArguments,
    fieldTransform: Foreign_Generic_Class.defaultOptions.fieldTransform
}));
var decodeParamLongString = new Payload_Server_Params.DecodeParam(fromString);
var decodeLongString = new Foreign_Generic_Class.Decode(Foreign_Generic.genericDecode(genericLongString)(Foreign_Generic_Class.genericDecodeConstructor(new Data_Symbol.IsSymbol(function () {
    return "LongString";
}))(Foreign_Generic_Class.genericDecodeArgsArgument(Foreign_Generic_Class.decodeWithOptionsOther(Foreign_Generic_Class.stringDecode)))(Foreign_Generic_Class.genericCountArgsArgument))({
    sumEncoding: Foreign_Generic_Class.defaultOptions.sumEncoding,
    unwrapSingleConstructors: true,
    unwrapSingleArguments: Foreign_Generic_Class.defaultOptions.unwrapSingleArguments,
    fieldTransform: Foreign_Generic_Class.defaultOptions.fieldTransform
}));
module.exports = {
    LongString: LongString,
    fromString: fromString,
    unsafeFromString: unsafeFromString,
    l_: l_,
    toString: toString,
    readImpl: readImpl,
    writeImpl: writeImpl,
    genericLongString: genericLongString,
    showLongString: showLongString,
    eqLongString: eqLongString,
    decodeLongString: decodeLongString,
    encodeLongString: encodeLongString,
    readForeignLongString: readForeignLongString,
    writeForeignLongString: writeForeignLongString,
    decodeParamLongString: decodeParamLongString,
    isSqlValueShortString: isSqlValueShortString
};