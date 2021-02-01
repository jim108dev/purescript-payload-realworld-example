// Generated by purs version 0.13.8
"use strict";
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Control_Monad_Error_Class = require("../Control.Monad.Error.Class/index.js");
var Data_Array = require("../Data.Array/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Database_Postgres = require("../Database.Postgres/index.js");
var Database_Postgres_SqlValue = require("../Database.Postgres.SqlValue/index.js");
var Effect_Aff = require("../Effect.Aff/index.js");
var Effect_Exception = require("../Effect.Exception/index.js");
var Server_Article_Type_Misc = require("../Server.Article.Type.Misc/index.js");
var Server_Shared_Persistence_Postgres_Query = require("../Server.Shared.Persistence.Postgres.Query/index.js");
var Shared_Type_LongString = require("../Shared.Type.LongString/index.js");
var Shared_Type_LowercaseString = require("../Shared.Type.LowercaseString/index.js");
var Shared_Type_ShortString = require("../Shared.Type.ShortString/index.js");
var Shared_Util_String = require("../Shared.Util.String/index.js");
var Simple_JSON = require("../Simple.JSON/index.js");
var Timestamp = require("../Timestamp/index.js");
var validateTags = function (result) {
    if (result instanceof Data_Either.Left) {
        return Control_Monad_Error_Class.throwError(Effect_Aff.monadThrowAff)(Effect_Exception.error(Data_Show.show(Server_Shared_Persistence_Postgres_Query.showPGError)(result.value0)));
    };
    if (result instanceof Data_Either.Right) {
        var v = Data_Array.head(result.value0);
        if (v instanceof Data_Maybe.Nothing) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)([  ]);
        };
        if (v instanceof Data_Maybe.Just) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(v.value0.tags);
        };
        throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 204, column 19 - line 206, column 32): " + [ v.constructor.name ]);
    };
    throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 202, column 3 - line 206, column 32): " + [ result.constructor.name ]);
};
var validateSlug = function (result) {
    if (result instanceof Data_Either.Left) {
        if (result.value0 instanceof Server_Shared_Persistence_Postgres_Query.IntegrityError) {
            if (result.value0.value0.constraint === "slug_unique") {
                return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_Article_Type_Misc.SLUG_EXISTS.value));
            };
            if (result.value0.value0.constraint === "favorited_unique") {
                return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_Article_Type_Misc.FAVORITED_EXISTS.value));
            };
            return Control_Monad_Error_Class.throwError(Effect_Aff.monadThrowAff)(Effect_Exception.error(Data_Show.show(Server_Shared_Persistence_Postgres_Query.showPGError)(result.value0)));
        };
        return Control_Monad_Error_Class.throwError(Effect_Aff.monadThrowAff)(Effect_Exception.error(Data_Show.show(Server_Shared_Persistence_Postgres_Query.showPGError)(result.value0)));
    };
    if (result instanceof Data_Either.Right) {
        var v = Data_Array.head(result.value0);
        if (v instanceof Data_Maybe.Nothing) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_Article_Type_Misc.NOT_FOUND.value));
        };
        if (v instanceof Data_Maybe.Just) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(Data_Either.Right.create(v.value0.slug));
        };
        throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 196, column 19 - line 198, column 42): " + [ v.constructor.name ]);
    };
    throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 189, column 3 - line 198, column 42): " + [ result.constructor.name ]);
};
var update = function (pool) {
    return function (r) {
        return function (slug) {
            var v = Shared_Type_LowercaseString.fromString(Shared_Type_ShortString.toString(r.title));
            if (v instanceof Data_Either.Left) {
                return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_Article_Type_Misc.SLUG_CREATION_FAILED.value));
            };
            if (v instanceof Data_Either.Right) {
                return Database_Postgres.withClient(pool)(function (conn) {
                    return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                        return "slug";
                    }))(Shared_Type_LowercaseString.readForeignLowercaseString)(Simple_JSON.readFieldsNil)()())))("UPDATE article SET body = $1, description = $2, slug = $3, title = $4 WHERE slug = $5 RETURNING slug")([ Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LongString.isSqlValueShortString)(r.body), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LongString.isSqlValueShortString)(r.description), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LowercaseString.isSqlValueLowercaseString)(v.value0), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(r.title), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LowercaseString.isSqlValueLowercaseString)(slug) ])(conn))(validateSlug);
                });
            };
            throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 118, column 22 - line 129, column 25): " + [ v.constructor.name ]);
        };
    };
};
var selectArticle = function (param) {
    return Shared_Util_String.format1(" SELECT\x0a  u.bio,\x0a  fo.followee_id IS NOT NULL AS following,\x0a  u.image,\x0a  u.username,\x0a  a.body,\x0a  timestamp_to_char (a.created_at) AS created_at,\x0a  a.description,\x0a  a.id,\x0a  fa.article_id IS NOT NULL AS favorited,\x0a  CAST((SELECT COUNT(*) FROM favorited WHERE favorited.article_id = a.id) AS INTEGER) AS favorites_count,\x0a  a.slug,\x0a  a.tag_list::TEXT[],\x0a  a.title,\x0a  timestamp_to_char (a.updated_at) AS updated_at\x0aFROM\x0a  article AS a\x0a  INNER JOIN \"user\" AS u ON (a.author_id = u.id)\x0a  LEFT JOIN following AS fo ON (u.id = fo.followee_id) AND (fo.follower_id = {1})\x0a  LEFT JOIN favorited AS fa ON (a.id = fa.article_id) ")(param);
};
var mkArticle = function (r) {
    return {
        author: {
            bio: r.bio,
            following: r.following,
            image: r.image,
            username: r.username
        },
        body: r.body,
        createdAt: r.created_at,
        description: r.description,
        favorited: r.favorited,
        favoritesCount: r.favorites_count,
        slug: r.slug,
        tagList: r.tag_list,
        title: r.title,
        updatedAt: r.updated_at
    };
};
var validateArray = function (result) {
    if (result instanceof Data_Either.Left) {
        return Control_Monad_Error_Class.throwError(Effect_Aff.monadThrowAff)(Effect_Exception.error(Data_Show.show(Server_Shared_Persistence_Postgres_Query.showPGError)(result.value0)));
    };
    if (result instanceof Data_Either.Right) {
        return Control_Applicative.pure(Effect_Aff.applicativeAff)(Data_Functor.map(Data_Functor.functorArray)(mkArticle)(result.value0));
    };
    throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 210, column 3 - line 212, column 44): " + [ result.constructor.name ]);
};
var search = function (pool) {
    return function (followerId) {
        return function (q) {
            return Database_Postgres.withClient(pool)(function (conn) {
                return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "bio";
                }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "body";
                }))(Shared_Type_LongString.readForeignLongString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "created_at";
                }))(Timestamp.readTimestamp)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "description";
                }))(Shared_Type_LongString.readForeignLongString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "favorited";
                }))(Simple_JSON.readBoolean)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "favorites_count";
                }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "following";
                }))(Simple_JSON.readBoolean)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "id";
                }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "image";
                }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "slug";
                }))(Shared_Type_LowercaseString.readForeignLowercaseString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "tag_list";
                }))(Simple_JSON.readArray(Shared_Type_LowercaseString.readForeignLowercaseString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "title";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "updated_at";
                }))(Timestamp.readTimestamp)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "username";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())()())()())()())()())()())()())()())()())))(selectArticle("$1") + "\x0a        LEFT JOIN \"user\" AS fa_user ON (fa.user_id = fa_user.id)\x0a        WHERE (($2::text IS NULL) OR (u.username = $2))\x0a          AND (($3::text IS NULL) OR (fa_user.username = $3))\x0a          AND (($6::text IS NULL) OR ($6=ANY(a.tag_list))) \x0a        ORDER BY a.updated_at DESC LIMIT $4 OFFSET $5 ")([ Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Database_Postgres_SqlValue.isSqlValueInt))(followerId), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Shared_Type_ShortString.isSqlValueShortString))(q.author), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Shared_Type_ShortString.isSqlValueShortString))(q.favorited), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(Data_Maybe.fromMaybe(1000)(q.limit)), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Database_Postgres_SqlValue.isSqlValueInt))(q.offset), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Shared_Type_LowercaseString.isSqlValueLowercaseString))(q.tag) ])(conn))(validateArray);
            });
        };
    };
};
var validateSingle = function (result) {
    if (result instanceof Data_Either.Left) {
        if (result.value0 instanceof Server_Shared_Persistence_Postgres_Query.IntegrityError) {
            if (result.value0.value0.constraint === "slug_unique") {
                return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_Article_Type_Misc.SLUG_EXISTS.value));
            };
            if (result.value0.value0.constraint === "favorited_unique") {
                return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_Article_Type_Misc.FAVORITED_EXISTS.value));
            };
            return Control_Monad_Error_Class.throwError(Effect_Aff.monadThrowAff)(Effect_Exception.error(Data_Show.show(Server_Shared_Persistence_Postgres_Query.showPGError)(result.value0)));
        };
        return Control_Monad_Error_Class.throwError(Effect_Aff.monadThrowAff)(Effect_Exception.error(Data_Show.show(Server_Shared_Persistence_Postgres_Query.showPGError)(result.value0)));
    };
    if (result instanceof Data_Either.Right) {
        var v = Data_Array.head(result.value0);
        if (v instanceof Data_Maybe.Nothing) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_Article_Type_Misc.NOT_FOUND.value));
        };
        if (v instanceof Data_Maybe.Just) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(Data_Either.Right.create(mkArticle(v.value0)));
        };
        throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 260, column 19 - line 262, column 47): " + [ v.constructor.name ]);
    };
    throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 253, column 3 - line 262, column 47): " + [ result.constructor.name ]);
};
var insertFavorite = function (pool) {
    return function (slug) {
        return function (userId) {
            return Database_Postgres.withClient(pool)(function (conn) {
                return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "slug";
                }))(Shared_Type_LowercaseString.readForeignLowercaseString)(Simple_JSON.readFieldsNil)()())))("INSERT INTO favorited (user_id, article_id)\x0a  SELECT\x0a    $2,\x0a    a.id\x0a  FROM\x0a    article AS a\x0a  WHERE\x0a    a.slug = $1\x0a  RETURNING $1 as slug\x0a    ")([ Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LowercaseString.isSqlValueLowercaseString)(slug), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(userId) ])(conn))(validateSlug);
            });
        };
    };
};
var insert = function (pool) {
    return function (r) {
        return function (userId) {
            var v = Shared_Type_LowercaseString.fromString(Shared_Type_ShortString.toString(r.title));
            if (v instanceof Data_Either.Left) {
                return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_Article_Type_Misc.SLUG_CREATION_FAILED.value));
            };
            if (v instanceof Data_Either.Right) {
                return Database_Postgres.withClient(pool)(function (conn) {
                    return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                        return "slug";
                    }))(Shared_Type_LowercaseString.readForeignLowercaseString)(Simple_JSON.readFieldsNil)()())))("INSERT INTO article (author_id, body, description, slug, tag_list, title)\x0a      VALUES ($1, $2, $3, $4, $5, $6)\x0a    RETURNING slug\x0a      ")([ Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(userId), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LongString.isSqlValueShortString)(r.body), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LongString.isSqlValueShortString)(r.description), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LowercaseString.isSqlValueLowercaseString)(v.value0), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Database_Postgres_SqlValue.isSqlValueArray(Shared_Type_LowercaseString.isSqlValueLowercaseString)))(r.tagList), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(r.title) ])(conn))(validateSlug);
                });
            };
            throw new Error("Failed pattern match at Server.Article.Persistence.Postgres (line 101, column 24 - line 115, column 25): " + [ v.constructor.name ]);
        };
    };
};
var findTags = function (pool) {
    return Database_Postgres.withClient(pool)(function (conn) {
        return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query_(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
            return "tags";
        }))(Simple_JSON.readArray(Shared_Type_LowercaseString.readForeignLowercaseString))(Simple_JSON.readFieldsNil)()())))("SELECT ARRAY(SELECT DISTINCT unnest(tag_list)FROM article ORDER BY 1)::TEXT[] AS tags")(conn))(validateTags);
    });
};
var findOne = function (pool) {
    return function (followerId) {
        return function (slug) {
            return Database_Postgres.withClient(pool)(function (conn) {
                return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "bio";
                }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "body";
                }))(Shared_Type_LongString.readForeignLongString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "created_at";
                }))(Timestamp.readTimestamp)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "description";
                }))(Shared_Type_LongString.readForeignLongString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "favorited";
                }))(Simple_JSON.readBoolean)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "favorites_count";
                }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "following";
                }))(Simple_JSON.readBoolean)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "id";
                }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "image";
                }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "slug";
                }))(Shared_Type_LowercaseString.readForeignLowercaseString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "tag_list";
                }))(Simple_JSON.readArray(Shared_Type_LowercaseString.readForeignLowercaseString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "title";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "updated_at";
                }))(Timestamp.readTimestamp)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "username";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())()())()())()())()())()())()())()())()())))(selectArticle("$1") + "WHERE a.slug = $2")([ Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Database_Postgres_SqlValue.isSqlValueInt))(followerId), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LowercaseString.isSqlValueLowercaseString)(slug) ])(conn))(validateSingle);
            });
        };
    };
};
var findMostRecentFromFollowee = function (pool) {
    return function (followerId) {
        return function (q) {
            return Database_Postgres.withClient(pool)(function (conn) {
                return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "bio";
                }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "body";
                }))(Shared_Type_LongString.readForeignLongString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "created_at";
                }))(Timestamp.readTimestamp)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "description";
                }))(Shared_Type_LongString.readForeignLongString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "favorited";
                }))(Simple_JSON.readBoolean)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "favorites_count";
                }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "following";
                }))(Simple_JSON.readBoolean)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "id";
                }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "image";
                }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "slug";
                }))(Shared_Type_LowercaseString.readForeignLowercaseString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "tag_list";
                }))(Simple_JSON.readArray(Shared_Type_LowercaseString.readForeignLowercaseString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "title";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "updated_at";
                }))(Timestamp.readTimestamp)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "username";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())()())()())()())()())()())()())()())()())))(selectArticle("$1") + " WHERE fo.follower_id = $1 ORDER BY updated_at DESC LIMIT $2 OFFSET $3 ")([ Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(followerId), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(Data_Maybe.fromMaybe(1000)(q.limit)), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Database_Postgres_SqlValue.isSqlValueInt))(q.offset) ])(conn))(validateArray);
            });
        };
    };
};
var deleteFavorite = function (pool) {
    return function (slug) {
        return function (userId) {
            return Database_Postgres.withClient(pool)(function (conn) {
                return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "slug";
                }))(Shared_Type_LowercaseString.readForeignLowercaseString)(Simple_JSON.readFieldsNil)()())))("DELETE FROM favorited\x0aUSING article as a\x0aWHERE a.slug = $1\x0a  AND favorited.user_id = $2\x0aRETURNING $1 as slug\x0a    ")([ Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LowercaseString.isSqlValueLowercaseString)(slug), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(userId) ])(conn))(validateSlug);
            });
        };
    };
};
var $$delete = function (pool) {
    return function (id) {
        return function (slug) {
            return Database_Postgres.withClient(pool)(function (conn) {
                return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "slug";
                }))(Shared_Type_LowercaseString.readForeignLowercaseString)(Simple_JSON.readFieldsNil)()())))("DELETE FROM article WHERE slug = $1 AND author_id = $2 RETURNING slug")([ Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_LowercaseString.isSqlValueLowercaseString)(id), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(slug) ])(conn))(validateSlug);
            });
        };
    };
};
var mkHandle = function (p) {
    return {
        findMostRecentFromFollowee: findMostRecentFromFollowee(p),
        findOne: findOne(p),
        findTags: findTags(p),
        insert: insert(p),
        "delete": $$delete(p),
        update: update(p),
        insertFavorite: insertFavorite(p),
        deleteFavorite: deleteFavorite(p),
        search: search(p)
    };
};
module.exports = {
    mkHandle: mkHandle
};
