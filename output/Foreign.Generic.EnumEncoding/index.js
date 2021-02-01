// Generated by purs version 0.13.8
"use strict";
var Control_Alt = require("../Control.Alt/index.js");
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Control_Category = require("../Control.Category/index.js");
var Control_Monad_Except_Trans = require("../Control.Monad.Except.Trans/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_Generic_Rep = require("../Data.Generic.Rep/index.js");
var Data_Identity = require("../Data.Identity/index.js");
var Data_List_Types = require("../Data.List.Types/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Foreign = require("../Foreign/index.js");
var Partial_Unsafe = require("../Partial.Unsafe/index.js");
var GenericEncodeEnum = function (encodeEnum) {
    this.encodeEnum = encodeEnum;
};
var GenericDecodeEnum = function (decodeEnum) {
    this.decodeEnum = decodeEnum;
};
var encodeEnum = function (dict) {
    return dict.encodeEnum;
};
var genericEncodeEnum = function (dictGeneric) {
    return function (dictGenericEncodeEnum) {
        return function (opts) {
            var $36 = encodeEnum(dictGenericEncodeEnum)(opts);
            var $37 = Data_Generic_Rep.from(dictGeneric);
            return function ($38) {
                return $36($37($38));
            };
        };
    };
};
var sumGenericEncodeEnum = function (dictGenericEncodeEnum) {
    return function (dictGenericEncodeEnum1) {
        return new GenericEncodeEnum(function (opts) {
            return function (v) {
                if (v instanceof Data_Generic_Rep.Inl) {
                    return encodeEnum(dictGenericEncodeEnum)(opts)(v.value0);
                };
                if (v instanceof Data_Generic_Rep.Inr) {
                    return encodeEnum(dictGenericEncodeEnum1)(opts)(v.value0);
                };
                throw new Error("Failed pattern match at Foreign.Generic.EnumEncoding (line 92, column 1 - line 96, column 46): " + [ opts.constructor.name, v.constructor.name ]);
            };
        });
    };
};
var defaultGenericEnumOptions = {
    constructorTagTransform: Control_Category.identity(Control_Category.categoryFn)
};
var decodeEnum = function (dict) {
    return dict.decodeEnum;
};
var genericDecodeEnum = function (dictGeneric) {
    return function (dictGenericDecodeEnum) {
        return function (opts) {
            var $39 = Data_Functor.map(Control_Monad_Except_Trans.functorExceptT(Data_Identity.functorIdentity))(Data_Generic_Rep.to(dictGeneric));
            var $40 = decodeEnum(dictGenericDecodeEnum)(opts);
            return function ($41) {
                return $39($40($41));
            };
        };
    };
};
var sumGenericDecodeEnum = function (dictGenericDecodeEnum) {
    return function (dictGenericDecodeEnum1) {
        return new GenericDecodeEnum(function (opts) {
            return function (f) {
                return Control_Alt.alt(Control_Monad_Except_Trans.altExceptT(Data_List_Types.semigroupNonEmptyList)(Data_Identity.monadIdentity))(Data_Functor.map(Control_Monad_Except_Trans.functorExceptT(Data_Identity.functorIdentity))(Data_Generic_Rep.Inl.create)(decodeEnum(dictGenericDecodeEnum)(opts)(f)))(Data_Functor.map(Control_Monad_Except_Trans.functorExceptT(Data_Identity.functorIdentity))(Data_Generic_Rep.Inr.create)(decodeEnum(dictGenericDecodeEnum1)(opts)(f)));
            };
        });
    };
};
var ctorProductGenericEncodeEnum = function (dictFail) {
    return new GenericEncodeEnum(function (v) {
        return function (v1) {
            return Partial_Unsafe.unsafeCrashWith("unreachable encodeEnum was reached.");
        };
    });
};
var ctorProductGenericDecodeEnum = function (dictFail) {
    return new GenericDecodeEnum(function (v) {
        return function (v1) {
            return Partial_Unsafe.unsafeCrashWith("unreachable decodeEnum was reached.");
        };
    });
};
var ctorNoArgsGenericEncodeEnum = function (dictIsSymbol) {
    return new GenericEncodeEnum(function (v) {
        return function (v1) {
            var ctorName = v.constructorTagTransform(Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value));
            return Foreign.unsafeToForeign(ctorName);
        };
    });
};
var ctorNoArgsGenericDecodeEnum = function (dictIsSymbol) {
    return new GenericDecodeEnum(function (v) {
        return function (f) {
            var ctorName = v.constructorTagTransform(Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value));
            return Control_Bind.bind(Control_Monad_Except_Trans.bindExceptT(Data_Identity.monadIdentity))(Foreign.readString(f))(function (tag) {
                return Control_Bind.discard(Control_Bind.discardUnit)(Control_Monad_Except_Trans.bindExceptT(Data_Identity.monadIdentity))(Control_Applicative.unless(Control_Monad_Except_Trans.applicativeExceptT(Data_Identity.monadIdentity))(tag === ctorName)(Foreign.fail(new Foreign.ForeignError("Expected " + (Data_Show.show(Data_Show.showString)(ctorName) + (" tag for unary constructor literal " + ctorName))))))(function () {
                    return Control_Applicative.pure(Control_Monad_Except_Trans.applicativeExceptT(Data_Identity.monadIdentity))(Data_Generic_Rep.NoArguments.value);
                });
            });
        };
    });
};
var ctorArgumentGenericEncodeEnum = function (dictFail) {
    return new GenericEncodeEnum(function (v) {
        return function (v1) {
            return Partial_Unsafe.unsafeCrashWith("unreachable encodeEnum was reached.");
        };
    });
};
var ctorArgumentGenericDecodeEnum = function (dictFail) {
    return new GenericDecodeEnum(function (v) {
        return function (v1) {
            return Partial_Unsafe.unsafeCrashWith("unreachable decodeEnum was reached.");
        };
    });
};
module.exports = {
    decodeEnum: decodeEnum,
    encodeEnum: encodeEnum,
    defaultGenericEnumOptions: defaultGenericEnumOptions,
    genericDecodeEnum: genericDecodeEnum,
    genericEncodeEnum: genericEncodeEnum,
    GenericDecodeEnum: GenericDecodeEnum,
    GenericEncodeEnum: GenericEncodeEnum,
    sumGenericDecodeEnum: sumGenericDecodeEnum,
    ctorNoArgsGenericDecodeEnum: ctorNoArgsGenericDecodeEnum,
    ctorArgumentGenericDecodeEnum: ctorArgumentGenericDecodeEnum,
    ctorProductGenericDecodeEnum: ctorProductGenericDecodeEnum,
    sumGenericEncodeEnum: sumGenericEncodeEnum,
    ctorNoArgsGenericEncodeEnum: ctorNoArgsGenericEncodeEnum,
    ctorArgumentGenericEncodeEnum: ctorArgumentGenericEncodeEnum,
    ctorProductGenericEncodeEnum: ctorProductGenericEncodeEnum
};
