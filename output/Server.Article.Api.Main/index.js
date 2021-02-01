// Generated by purs version 0.13.8
"use strict";
var Data_Bifunctor = require("../Data.Bifunctor/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Effect_Aff = require("../Effect.Aff/index.js");
var Payload_ResponseTypes = require("../Payload.ResponseTypes/index.js");
var Payload_Server_Response = require("../Payload.Server.Response/index.js");
var Server_Article_Api_Type_CreateDto = require("../Server.Article.Api.Type.CreateDto/index.js");
var Server_Article_Api_Type_Misc = require("../Server.Article.Api.Type.Misc/index.js");
var Server_Article_Api_Type_UpdateDto = require("../Server.Article.Api.Type.UpdateDto/index.js");
var Server_Article_Application_Main = require("../Server.Article.Application.Main/index.js");
var Server_Article_Persistence_Postgres = require("../Server.Article.Persistence.Postgres/index.js");
var Server_Article_Type_Misc = require("../Server.Article.Type.Misc/index.js");
var Server_Shared_Api_Main = require("../Server.Shared.Api.Main/index.js");
var renderError = function (v) {
    if (v instanceof Server_Article_Type_Misc.SLUG_EXISTS) {
        return Payload_Server_Response.unprocessableEntity(Server_Shared_Api_Main.renderErrorEntity("slug")("exists"));
    };
    if (v instanceof Server_Article_Type_Misc.TITLE_EXISTS) {
        return Payload_Server_Response.unprocessableEntity(Server_Shared_Api_Main.renderErrorEntity("title")("exists"));
    };
    if (v instanceof Server_Article_Type_Misc.NOT_FOUND) {
        return Payload_Server_Response.notFound(Server_Shared_Api_Main.renderErrorMessage("article not found"));
    };
    if (v instanceof Server_Article_Type_Misc.FAVORITED_EXISTS) {
        return Payload_Server_Response.unprocessableEntity(Server_Shared_Api_Main.renderErrorEntity("slug")("exists"));
    };
    if (v instanceof Server_Article_Type_Misc.SLUG_CREATION_FAILED) {
        return Payload_Server_Response.unprocessableEntity(Server_Shared_Api_Main.renderErrorEntity("title")("cannot be converted to slug"));
    };
    throw new Error("Failed pattern match at Server.Article.Api.Main (line 96, column 1 - line 96, column 45): " + [ v.constructor.name ]);
};
var next = function (h) {
    return Server_Article_Persistence_Postgres.mkHandle(h.pool.value0);
};
var unfavorite = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function ($50) {
            return Payload_Server_Response.ok(Server_Article_Api_Type_Misc.mkSingleDto($50));
        })))(Server_Article_Application_Main.unfavorite(next(h))(v.params.slug)(v.guards.userId));
    };
};
var update = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function ($51) {
            return Payload_Server_Response.ok(Server_Article_Api_Type_Misc.mkSingleDto($51));
        })))(Server_Article_Application_Main.update(next(h))(Server_Article_Api_Type_UpdateDto.unwrapUpdateDto(v.body))(v.params.slug)(v.guards.userId));
    };
};
var list = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function ($52) {
            return Payload_Server_Response.ok(Server_Article_Api_Type_Misc.mkMultipleDto($52));
        })))(Data_Either.Right.create))((next(h)).search(v.guards.maybeUserId)(v.query));
    };
};
var getTags = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function ($53) {
            return Payload_Server_Response.ok(Server_Article_Api_Type_Misc.mkTagsDto($53));
        })))(Data_Either.Right.create))((next(h)).findTags);
    };
};
var get = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function ($54) {
            return Payload_Server_Response.ok(Server_Article_Api_Type_Misc.mkSingleDto($54));
        })))((next(h)).findOne(v.guards.maybeUserId)(v.params.slug));
    };
};
var feed = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function ($55) {
            return Payload_Server_Response.ok(Server_Article_Api_Type_Misc.mkMultipleDto($55));
        })))(Data_Either.Right.create))((next(h)).findMostRecentFromFollowee(v.guards.userId)(v.query));
    };
};
var favorite = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function ($56) {
            return Payload_Server_Response.ok(Server_Article_Api_Type_Misc.mkSingleDto($56));
        })))(Server_Article_Application_Main.favorite(next(h))(v.params.slug)(v.guards.userId));
    };
};
var $$delete = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function (v1) {
            return Payload_Server_Response.ok(Payload_ResponseTypes.Empty.value);
        })))((next(h))["delete"](v.params.slug)(v.guards.userId));
    };
};
var create = function (h) {
    return function (v) {
        return Data_Functor.map(Effect_Aff.functorAff)(Data_Functor.map(Data_Functor.functorFn)(Server_Shared_Api_Main.setHeaders(v.guards.origin))(Data_Bifunctor.bimap(Data_Either.bifunctorEither)(renderError)(function ($57) {
            return Payload_Server_Response.ok(Server_Article_Api_Type_Misc.mkSingleDto($57));
        })))(Server_Article_Application_Main.create(next(h))(Server_Article_Api_Type_CreateDto.unwrapCreateDto(v.body))(v.guards.userId));
    };
};
var mkHandle = function (h) {
    return {
        create: create(h),
        list: list(h),
        "delete": $$delete(h),
        favorite: favorite(h),
        feed: feed(h),
        get: get(h),
        getTags: getTags(h),
        unfavorite: unfavorite(h),
        update: update(h)
    };
};
module.exports = {
    mkHandle: mkHandle
};