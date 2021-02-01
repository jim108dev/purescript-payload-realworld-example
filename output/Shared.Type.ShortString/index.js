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
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_String_CodePoints = require("../Data.String.CodePoints/index.js");
var Data_String_Common = require("../Data.String.Common/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Database_Postgres_SqlValue = require("../Database.Postgres.SqlValue/index.js");
var Foreign = require("../Foreign/index.js");
var Foreign_Generic = require("../Foreign.Generic/index.js");
var Foreign_Generic_Class = require("../Foreign.Generic.Class/index.js");
var Foreign_Object = require("../Foreign.Object/index.js");
var Payload_Server_Params = require("../Payload.Server.Params/index.js");
var Payload_Server_QueryParams = require("../Payload.Server.QueryParams/index.js");
var Simple_JSON = require("../Simple.JSON/index.js");
var Unsafe_Coerce = require("../Unsafe.Coerce/index.js");
var ShortString = function (x) {
    return x;
};
var toString = function (v) {
    return v;
};
var writeImpl = function ($27) {
    return Foreign.unsafeToForeign(toString($27));
};
var writeForeignShortString = new Simple_JSON.WriteForeign(writeImpl);
var isSqlValueShortString = new Database_Postgres_SqlValue.IsSqlValue(Unsafe_Coerce.unsafeCoerce);
var genericShortString = new Data_Generic_Rep.Generic(function (x) {
    return x;
}, function (x) {
    return x;
});
var showShortString = new Data_Show.Show(Data_Generic_Rep_Show.genericShow(genericShortString)(Data_Generic_Rep_Show.genericShowConstructor(Data_Generic_Rep_Show.genericShowArgsArgument(Data_Show.showString))(new Data_Symbol.IsSymbol(function () {
    return "ShortString";
}))));
var fromString = function (s) {
    var len = Data_String_CodePoints.length(s);
    if (len === 0) {
        return new Data_Either.Left("can't be empty");
    };
    if (len > 50) {
        return new Data_Either.Left("can't be longer than 50 characters");
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
            throw new Error("Failed pattern match at Shared.Type.ShortString (line 68, column 10 - line 70, column 23): " + [ v1.constructor.name ]);
        })());
    });
};
var readForeignShortString = new Simple_JSON.ReadForeign(readImpl);
var unsafeFromString = function (dictPartial) {
    var $28 = Data_Either.fromRight();
    return function ($29) {
        return $28(fromString($29));
    };
};
var s_ = function (dictPartial) {
    return unsafeFromString();
};
var eqShortString = new Data_Eq.Eq(function (o1) {
    return function (o2) {
        return Data_String_Common.toLower(toString(o1)) === Data_String_Common.toLower(toString(o2));
    };
});
var encodeShortString = new Foreign_Generic_Class.Encode(Foreign_Generic.genericEncode(genericShortString)(Foreign_Generic_Class.genericEncodeConstructor(new Data_Symbol.IsSymbol(function () {
    return "ShortString";
}))(Foreign_Generic_Class.genericEncodeArgsArgument(Foreign_Generic_Class.encodeWithOptionsOther(Foreign_Generic_Class.stringEncode))))({
    sumEncoding: Foreign_Generic_Class.defaultOptions.sumEncoding,
    unwrapSingleConstructors: true,
    unwrapSingleArguments: Foreign_Generic_Class.defaultOptions.unwrapSingleArguments,
    fieldTransform: Foreign_Generic_Class.defaultOptions.fieldTransform
}));
var decodeShortString = new Foreign_Generic_Class.Decode(Foreign_Generic.genericDecode(genericShortString)(Foreign_Generic_Class.genericDecodeConstructor(new Data_Symbol.IsSymbol(function () {
    return "ShortString";
}))(Foreign_Generic_Class.genericDecodeArgsArgument(Foreign_Generic_Class.decodeWithOptionsOther(Foreign_Generic_Class.stringDecode)))(Foreign_Generic_Class.genericCountArgsArgument))({
    sumEncoding: Foreign_Generic_Class.defaultOptions.sumEncoding,
    unwrapSingleConstructors: true,
    unwrapSingleArguments: Foreign_Generic_Class.defaultOptions.unwrapSingleArguments,
    fieldTransform: Foreign_Generic_Class.defaultOptions.fieldTransform
}));
var decodeQueryParam = function (queryObj) {
    return function (queryKey) {
        var decodeErr = function (values) {
            return function (msg) {
                return new Data_Either.Left(new Payload_Server_QueryParams.QueryDecodeError({
                    key: queryKey,
                    values: values,
                    message: msg,
                    queryObj: queryObj
                }));
            };
        };
        var v = Foreign_Object.lookup(queryKey)(queryObj);
        if (v instanceof Data_Maybe.Nothing) {
            return new Data_Either.Left(new Payload_Server_QueryParams.QueryParamNotFound({
                key: queryKey,
                queryObj: queryObj
            }));
        };
        if (v instanceof Data_Maybe.Just && v.value0.length === 0) {
            return decodeErr([  ])("Expected single value but received empty Array");
        };
        if (v instanceof Data_Maybe.Just && v.value0.length === 1) {
            var v1 = fromString(Data_String_Common.toLower(v["value0"][0]));
            if (v1 instanceof Data_Either.Left) {
                return decodeErr([  ])(v1.value0);
            };
            if (v1 instanceof Data_Either.Right) {
                return new Data_Either.Right(v1.value0);
            };
            throw new Error("Failed pattern match at Shared.Type.ShortString (line 91, column 19 - line 93, column 23): " + [ v1.constructor.name ]);
        };
        if (v instanceof Data_Maybe.Just) {
            return decodeErr(v.value0)("Expected single value but received multiple: " + Data_Show.show(Data_Show.showArray(Data_Show.showString))(v.value0));
        };
        throw new Error("Failed pattern match at Shared.Type.ShortString (line 88, column 38 - line 94, column 90): " + [ v.constructor.name ]);
    };
};
var decodeQueryParamString = new Payload_Server_QueryParams.DecodeQueryParam(decodeQueryParam);
var decodeParamShortString = new Payload_Server_Params.DecodeParam(function ($30) {
    return fromString(Data_String_Common.toLower($30));
});
module.exports = {
    ShortString: ShortString,
    fromString: fromString,
    unsafeFromString: unsafeFromString,
    s_: s_,
    toString: toString,
    readImpl: readImpl,
    writeImpl: writeImpl,
    decodeQueryParam: decodeQueryParam,
    genericShortString: genericShortString,
    showShortString: showShortString,
    eqShortString: eqShortString,
    decodeShortString: decodeShortString,
    encodeShortString: encodeShortString,
    readForeignShortString: readForeignShortString,
    writeForeignShortString: writeForeignShortString,
    isSqlValueShortString: isSqlValueShortString,
    decodeParamShortString: decodeParamShortString,
    decodeQueryParamString: decodeQueryParamString
};