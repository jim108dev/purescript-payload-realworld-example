// Generated by purs version 0.13.8
"use strict";
var $foreign = require("./foreign.js");
var Affjax_RequestBody = require("../Affjax.RequestBody/index.js");
var Affjax_RequestHeader = require("../Affjax.RequestHeader/index.js");
var Affjax_ResponseFormat = require("../Affjax.ResponseFormat/index.js");
var Affjax_ResponseHeader = require("../Affjax.ResponseHeader/index.js");
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Control_Monad_Error_Class = require("../Control.Monad.Error.Class/index.js");
var Control_Monad_Except = require("../Control.Monad.Except/index.js");
var Control_Monad_Except_Trans = require("../Control.Monad.Except.Trans/index.js");
var Data_Argonaut_Core = require("../Data.Argonaut.Core/index.js");
var Data_Argonaut_Parser = require("../Data.Argonaut.Parser/index.js");
var Data_Array = require("../Data.Array/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Eq = require("../Data.Eq/index.js");
var Data_Foldable = require("../Data.Foldable/index.js");
var Data_FormURLEncoded = require("../Data.FormURLEncoded/index.js");
var Data_Function = require("../Data.Function/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_HTTP_Method = require("../Data.HTTP.Method/index.js");
var Data_HeytingAlgebra = require("../Data.HeytingAlgebra/index.js");
var Data_Identity = require("../Data.Identity/index.js");
var Data_List_NonEmpty = require("../Data.List.NonEmpty/index.js");
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Nullable = require("../Data.Nullable/index.js");
var Data_Unit = require("../Data.Unit/index.js");
var Effect_Aff = require("../Effect.Aff/index.js");
var Effect_Aff_Compat = require("../Effect.Aff.Compat/index.js");
var Effect_Exception = require("../Effect.Exception/index.js");
var Foreign = require("../Foreign/index.js");
var RequestContentError = (function () {
    function RequestContentError(value0) {
        this.value0 = value0;
    };
    RequestContentError.create = function (value0) {
        return new RequestContentError(value0);
    };
    return RequestContentError;
})();
var ResponseBodyError = (function () {
    function ResponseBodyError(value0, value1) {
        this.value0 = value0;
        this.value1 = value1;
    };
    ResponseBodyError.create = function (value0) {
        return function (value1) {
            return new ResponseBodyError(value0, value1);
        };
    };
    return ResponseBodyError;
})();
var XHRError = (function () {
    function XHRError(value0) {
        this.value0 = value0;
    };
    XHRError.create = function (value0) {
        return new XHRError(value0);
    };
    return XHRError;
})();
var request = function (req) {
    var parseJSON = function (v) {
        if (v === "") {
            return Control_Applicative.pure(Control_Monad_Except_Trans.applicativeExceptT(Data_Identity.monadIdentity))(Data_Argonaut_Core.jsonEmptyObject);
        };
        return Data_Either.either(function ($49) {
            return Foreign.fail(Foreign.ForeignError.create($49));
        })(Control_Applicative.pure(Control_Monad_Except_Trans.applicativeExceptT(Data_Identity.monadIdentity)))(Data_Argonaut_Parser.jsonParser(v));
    };
    var fromResponse = (function () {
        if (req.responseFormat instanceof Affjax_ResponseFormat["ArrayBuffer"]) {
            return Foreign.unsafeReadTagged("ArrayBuffer");
        };
        if (req.responseFormat instanceof Affjax_ResponseFormat.Blob) {
            return Foreign.unsafeReadTagged("Blob");
        };
        if (req.responseFormat instanceof Affjax_ResponseFormat.Document) {
            return Foreign.unsafeReadTagged("Document");
        };
        if (req.responseFormat instanceof Affjax_ResponseFormat.Json) {
            return Control_Bind.composeKleisliFlipped(Control_Monad_Except_Trans.bindExceptT(Data_Identity.monadIdentity))(function ($50) {
                return req.responseFormat.value0(parseJSON($50));
            })(Foreign.unsafeReadTagged("String"));
        };
        if (req.responseFormat instanceof Affjax_ResponseFormat["String"]) {
            return Foreign.unsafeReadTagged("String");
        };
        if (req.responseFormat instanceof Affjax_ResponseFormat.Ignore) {
            return Data_Function["const"](req.responseFormat.value0(Control_Applicative.pure(Control_Monad_Except_Trans.applicativeExceptT(Data_Identity.monadIdentity))(Data_Unit.unit)));
        };
        throw new Error("Failed pattern match at Affjax (line 241, column 18 - line 247, column 57): " + [ req.responseFormat.constructor.name ]);
    })();
    var extractContent = function (v) {
        if (v instanceof Affjax_RequestBody.ArrayView) {
            return Data_Either.Right.create(v.value0(Foreign.unsafeToForeign));
        };
        if (v instanceof Affjax_RequestBody.Blob) {
            return Data_Either.Right.create(Foreign.unsafeToForeign(v.value0));
        };
        if (v instanceof Affjax_RequestBody.Document) {
            return Data_Either.Right.create(Foreign.unsafeToForeign(v.value0));
        };
        if (v instanceof Affjax_RequestBody["String"]) {
            return Data_Either.Right.create(Foreign.unsafeToForeign(v.value0));
        };
        if (v instanceof Affjax_RequestBody.FormData) {
            return Data_Either.Right.create(Foreign.unsafeToForeign(v.value0));
        };
        if (v instanceof Affjax_RequestBody.FormURLEncoded) {
            return Data_Either.note("Body contains values that cannot be encoded as application/x-www-form-urlencoded")(Data_Functor.map(Data_Maybe.functorMaybe)(Foreign.unsafeToForeign)(Data_FormURLEncoded.encode(v.value0)));
        };
        if (v instanceof Affjax_RequestBody.Json) {
            return Data_Either.Right.create(Foreign.unsafeToForeign(Data_Argonaut_Core.stringify(v.value0)));
        };
        throw new Error("Failed pattern match at Affjax (line 207, column 20 - line 222, column 69): " + [ v.constructor.name ]);
    };
    var addHeader = function (mh) {
        return function (hs) {
            if (mh instanceof Data_Maybe.Just && !Data_Foldable.any(Data_Foldable.foldableArray)(Data_HeytingAlgebra.heytingAlgebraBoolean)(Data_Function.on(Data_Eq.eq(Data_Eq.eqString))(Affjax_RequestHeader.name)(mh.value0))(hs)) {
                return Data_Array.snoc(hs)(mh.value0);
            };
            return hs;
        };
    };
    var headers = function (reqContent) {
        return addHeader(Data_Functor.map(Data_Maybe.functorMaybe)(Affjax_RequestHeader.ContentType.create)(Control_Bind.bindFlipped(Data_Maybe.bindMaybe)(Affjax_RequestBody.toMediaType)(reqContent)))(addHeader(Data_Functor.map(Data_Maybe.functorMaybe)(Affjax_RequestHeader.Accept.create)(Affjax_ResponseFormat.toMediaType(req.responseFormat)))(req.headers));
    };
    var ajaxRequest = function (v) {
        return {
            method: Data_HTTP_Method.print(req.method),
            url: req.url,
            headers: Data_Functor.map(Data_Functor.functorArray)(function (h) {
                return {
                    field: Affjax_RequestHeader.name(h),
                    value: Affjax_RequestHeader.value(h)
                };
            })(headers(req.content)),
            content: v,
            responseType: Affjax_ResponseFormat.toResponseType(req.responseFormat),
            username: Data_Nullable.toNullable(req.username),
            password: Data_Nullable.toNullable(req.password),
            withCredentials: req.withCredentials,
            timeout: Data_Maybe.fromMaybe(0.0)(Data_Functor.map(Data_Maybe.functorMaybe)(function (v1) {
                return v1;
            })(req.timeout))
        };
    };
    var send = function (content) {
        return Data_Functor.mapFlipped(Effect_Aff.functorAff)(Control_Monad_Error_Class["try"](Effect_Aff.monadErrorAff)(Effect_Aff_Compat.fromEffectFnAff($foreign["_ajax"](Affjax_ResponseHeader.ResponseHeader.create, ajaxRequest(content)))))(function (v) {
            if (v instanceof Data_Either.Right) {
                var v1 = Control_Monad_Except.runExcept(fromResponse(v.value0.body));
                if (v1 instanceof Data_Either.Left) {
                    return new Data_Either.Left(new ResponseBodyError(Data_List_NonEmpty.head(v1.value0), v.value0));
                };
                if (v1 instanceof Data_Either.Right) {
                    return new Data_Either.Right({
                        body: v1.value0,
                        headers: v.value0.headers,
                        status: v.value0.status,
                        statusText: v.value0.statusText
                    });
                };
                throw new Error("Failed pattern match at Affjax (line 187, column 9 - line 189, column 52): " + [ v1.constructor.name ]);
            };
            if (v instanceof Data_Either.Left) {
                return new Data_Either.Left(new XHRError(v.value0));
            };
            throw new Error("Failed pattern match at Affjax (line 185, column 86 - line 191, column 28): " + [ v.constructor.name ]);
        });
    };
    if (req.content instanceof Data_Maybe.Nothing) {
        return send(Data_Nullable.toNullable(Data_Maybe.Nothing.value));
    };
    if (req.content instanceof Data_Maybe.Just) {
        var v = extractContent(req.content.value0);
        if (v instanceof Data_Either.Right) {
            return send(Data_Nullable.toNullable(new Data_Maybe.Just(v.value0)));
        };
        if (v instanceof Data_Either.Left) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(new RequestContentError(v.value0)));
        };
        throw new Error("Failed pattern match at Affjax (line 176, column 7 - line 180, column 48): " + [ v.constructor.name ]);
    };
    throw new Error("Failed pattern match at Affjax (line 172, column 3 - line 180, column 48): " + [ req.content.constructor.name ]);
};
var printError = function (v) {
    if (v instanceof RequestContentError) {
        return "There was a problem with the request content: " + v.value0;
    };
    if (v instanceof ResponseBodyError) {
        return "There was a problem with the response body: " + Foreign.renderForeignError(v.value0);
    };
    if (v instanceof XHRError) {
        return "There was a problem making the request: " + Effect_Exception.message(v.value0);
    };
    throw new Error("Failed pattern match at Affjax (line 94, column 14 - line 100, column 66): " + [ v.constructor.name ]);
};
var defaultRequest = {
    method: new Data_Either.Left(Data_HTTP_Method.GET.value),
    url: "/",
    headers: [  ],
    content: Data_Maybe.Nothing.value,
    username: Data_Maybe.Nothing.value,
    password: Data_Maybe.Nothing.value,
    withCredentials: false,
    responseFormat: Affjax_ResponseFormat.ignore,
    timeout: Data_Maybe.Nothing.value
};
var $$delete = function (rf) {
    return function (u) {
        return request({
            method: new Data_Either.Left(Data_HTTP_Method.DELETE.value),
            url: u,
            headers: defaultRequest.headers,
            content: defaultRequest.content,
            username: defaultRequest.username,
            password: defaultRequest.password,
            withCredentials: defaultRequest.withCredentials,
            responseFormat: rf,
            timeout: defaultRequest.timeout
        });
    };
};
var delete_ = (function () {
    var $51 = Data_Functor.map(Effect_Aff.functorAff)(Data_Functor["void"](Data_Either.functorEither));
    var $52 = $$delete(Affjax_ResponseFormat.ignore);
    return function ($53) {
        return $51($52($53));
    };
})();
var get = function (rf) {
    return function (u) {
        return request({
            method: defaultRequest.method,
            url: u,
            headers: defaultRequest.headers,
            content: defaultRequest.content,
            username: defaultRequest.username,
            password: defaultRequest.password,
            withCredentials: defaultRequest.withCredentials,
            responseFormat: rf,
            timeout: defaultRequest.timeout
        });
    };
};
var patch = function (rf) {
    return function (u) {
        return function (c) {
            return request({
                method: new Data_Either.Left(Data_HTTP_Method.PATCH.value),
                url: u,
                headers: defaultRequest.headers,
                content: new Data_Maybe.Just(c),
                username: defaultRequest.username,
                password: defaultRequest.password,
                withCredentials: defaultRequest.withCredentials,
                responseFormat: rf,
                timeout: defaultRequest.timeout
            });
        };
    };
};
var patch_ = function (url) {
    var $54 = Data_Functor.map(Effect_Aff.functorAff)(Data_Functor["void"](Data_Either.functorEither));
    var $55 = patch(Affjax_ResponseFormat.ignore)(url);
    return function ($56) {
        return $54($55($56));
    };
};
var post = function (rf) {
    return function (u) {
        return function (c) {
            return request({
                method: new Data_Either.Left(Data_HTTP_Method.POST.value),
                url: u,
                headers: defaultRequest.headers,
                content: c,
                username: defaultRequest.username,
                password: defaultRequest.password,
                withCredentials: defaultRequest.withCredentials,
                responseFormat: rf,
                timeout: defaultRequest.timeout
            });
        };
    };
};
var post_ = function (url) {
    var $57 = Data_Functor.map(Effect_Aff.functorAff)(Data_Functor["void"](Data_Either.functorEither));
    var $58 = post(Affjax_ResponseFormat.ignore)(url);
    return function ($59) {
        return $57($58($59));
    };
};
var put = function (rf) {
    return function (u) {
        return function (c) {
            return request({
                method: new Data_Either.Left(Data_HTTP_Method.PUT.value),
                url: u,
                headers: defaultRequest.headers,
                content: c,
                username: defaultRequest.username,
                password: defaultRequest.password,
                withCredentials: defaultRequest.withCredentials,
                responseFormat: rf,
                timeout: defaultRequest.timeout
            });
        };
    };
};
var put_ = function (url) {
    var $60 = Data_Functor.map(Effect_Aff.functorAff)(Data_Functor["void"](Data_Either.functorEither));
    var $61 = put(Affjax_ResponseFormat.ignore)(url);
    return function ($62) {
        return $60($61($62));
    };
};
module.exports = {
    defaultRequest: defaultRequest,
    RequestContentError: RequestContentError,
    ResponseBodyError: ResponseBodyError,
    XHRError: XHRError,
    printError: printError,
    request: request,
    get: get,
    post: post,
    post_: post_,
    put: put,
    put_: put_,
    "delete": $$delete,
    delete_: delete_,
    patch: patch,
    patch_: patch_
};