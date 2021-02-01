// Generated by purs version 0.13.8
"use strict";
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Control_Category = require("../Control.Category/index.js");
var Control_Monad_Except_Trans = require("../Control.Monad.Except.Trans/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Eq = require("../Data.Eq/index.js");
var Data_Generic_Rep = require("../Data.Generic.Rep/index.js");
var Data_Generic_Rep_Eq = require("../Data.Generic.Rep.Eq/index.js");
var Data_Generic_Rep_Show = require("../Data.Generic.Rep.Show/index.js");
var Data_Identity = require("../Data.Identity/index.js");
var Data_List_Types = require("../Data.List.Types/index.js");
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_String_CodePoints = require("../Data.String.CodePoints/index.js");
var Data_String_Common = require("../Data.String.Common/index.js");
var Data_String_Regex = require("../Data.String.Regex/index.js");
var Data_String_Regex_Flags = require("../Data.String.Regex.Flags/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Database_Postgres_SqlValue = require("../Database.Postgres.SqlValue/index.js");
var Foreign = require("../Foreign/index.js");
var Foreign_Generic = require("../Foreign.Generic/index.js");
var Foreign_Generic_Class = require("../Foreign.Generic.Class/index.js");
var Foreign_Object = require("../Foreign.Object/index.js");
var Partial_Unsafe = require("../Partial.Unsafe/index.js");
var Payload_Server_Params = require("../Payload.Server.Params/index.js");
var Payload_Server_QueryParams = require("../Payload.Server.QueryParams/index.js");
var Simple_JSON = require("../Simple.JSON/index.js");
var Unsafe_Coerce = require("../Unsafe.Coerce/index.js");
var LowercaseString = function (x) {
    return x;
};
var toString = function (v) {
    return v;
};
var writeImpl = function ($27) {
    return Foreign.unsafeToForeign(toString($27));
};
var writeForeignLowercaseString = new Simple_JSON.WriteForeign(writeImpl);
var mkIdentifier = (function () {
    var theRegex = Data_Either.either(Partial_Unsafe.unsafeCrashWith)(Control_Category.identity(Control_Category.categoryFn))(Data_String_Regex.regex("[^ a-z0-9_.:-]")(Data_String_Regex_Flags.global));
    var $28 = Data_String_Common.replaceAll(" ")("-");
    var $29 = Data_String_Regex.replace(theRegex)("");
    return function ($30) {
        return $28($29(Data_String_Common.toLower(Data_String_Common.trim($30))));
    };
})();
var isSqlValueLowercaseString = new Database_Postgres_SqlValue.IsSqlValue(Unsafe_Coerce.unsafeCoerce);
var genericLowercaseString = new Data_Generic_Rep.Generic(function (x) {
    return x;
}, function (x) {
    return x;
});
var showLowercaseString = new Data_Show.Show(Data_Generic_Rep_Show.genericShow(genericLowercaseString)(Data_Generic_Rep_Show.genericShowConstructor(Data_Generic_Rep_Show.genericShowArgsArgument(Data_Show.showString))(new Data_Symbol.IsSymbol(function () {
    return "LowercaseString";
}))));
var fromString = function (s) {
    var i = mkIdentifier(s);
    var len = Data_String_CodePoints.length(i);
    if (len === 0) {
        return new Data_Either.Left("can't be empty");
    };
    if (len > 50) {
        return new Data_Either.Left("can't be longer than 50 characters");
    };
    return Data_Either.Right.create(i);
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
            throw new Error("Failed pattern match at Shared.Type.LowercaseString (line 82, column 10 - line 84, column 23): " + [ v1.constructor.name ]);
        })());
    });
};
var readForeignLowercaseString = new Simple_JSON.ReadForeign(readImpl);
var unsafeFromString = function (dictPartial) {
    var $31 = Data_Either.fromRight();
    return function ($32) {
        return $31(fromString($32));
    };
};
var s_ = function (dictPartial) {
    return unsafeFromString();
};
var eqLowercaseString = new Data_Eq.Eq(Data_Generic_Rep_Eq.genericEq(genericLowercaseString)(Data_Generic_Rep_Eq.genericEqConstructor(Data_Generic_Rep_Eq.genericEqArgument(Data_Eq.eqString))));
var encodeLowercaseString = new Foreign_Generic_Class.Encode(Foreign_Generic.genericEncode(genericLowercaseString)(Foreign_Generic_Class.genericEncodeConstructor(new Data_Symbol.IsSymbol(function () {
    return "LowercaseString";
}))(Foreign_Generic_Class.genericEncodeArgsArgument(Foreign_Generic_Class.encodeWithOptionsOther(Foreign_Generic_Class.stringEncode))))({
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
            throw new Error("Failed pattern match at Shared.Type.LowercaseString (line 105, column 19 - line 107, column 23): " + [ v1.constructor.name ]);
        };
        if (v instanceof Data_Maybe.Just) {
            return decodeErr(v.value0)("Expected single value but received multiple: " + Data_Show.show(Data_Show.showArray(Data_Show.showString))(v.value0));
        };
        throw new Error("Failed pattern match at Shared.Type.LowercaseString (line 102, column 38 - line 108, column 90): " + [ v.constructor.name ]);
    };
};
var decodeQueryParamString = new Payload_Server_QueryParams.DecodeQueryParam(decodeQueryParam);
var decodeParamLowercaseString = new Payload_Server_Params.DecodeParam(function ($33) {
    return fromString(Data_String_Common.toLower($33));
});
var decodeLowercaseString = new Foreign_Generic_Class.Decode(Foreign_Generic.genericDecode(genericLowercaseString)(Foreign_Generic_Class.genericDecodeConstructor(new Data_Symbol.IsSymbol(function () {
    return "LowercaseString";
}))(Foreign_Generic_Class.genericDecodeArgsArgument(Foreign_Generic_Class.decodeWithOptionsOther(Foreign_Generic_Class.stringDecode)))(Foreign_Generic_Class.genericCountArgsArgument))({
    sumEncoding: Foreign_Generic_Class.defaultOptions.sumEncoding,
    unwrapSingleConstructors: true,
    unwrapSingleArguments: Foreign_Generic_Class.defaultOptions.unwrapSingleArguments,
    fieldTransform: Foreign_Generic_Class.defaultOptions.fieldTransform
}));
module.exports = {
    fromString: fromString,
    genericLowercaseString: genericLowercaseString,
    showLowercaseString: showLowercaseString,
    eqLowercaseString: eqLowercaseString,
    decodeLowercaseString: decodeLowercaseString,
    encodeLowercaseString: encodeLowercaseString,
    readForeignLowercaseString: readForeignLowercaseString,
    writeForeignLowercaseString: writeForeignLowercaseString,
    isSqlValueLowercaseString: isSqlValueLowercaseString,
    decodeParamLowercaseString: decodeParamLowercaseString,
    decodeQueryParamString: decodeQueryParamString
};
