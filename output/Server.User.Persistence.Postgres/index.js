// Generated by purs version 0.13.8
"use strict";
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Control_Monad_Error_Class = require("../Control.Monad.Error.Class/index.js");
var Data_Array = require("../Data.Array/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var Database_Postgres = require("../Database.Postgres/index.js");
var Database_Postgres_SqlValue = require("../Database.Postgres.SqlValue/index.js");
var Effect_Aff = require("../Effect.Aff/index.js");
var Effect_Exception = require("../Effect.Exception/index.js");
var Server_Shared_Persistence_Postgres_Query = require("../Server.Shared.Persistence.Postgres.Query/index.js");
var Server_User_Type_Misc = require("../Server.User.Type.Misc/index.js");
var Shared_Type_LongString = require("../Shared.Type.LongString/index.js");
var Shared_Type_ShortString = require("../Shared.Type.ShortString/index.js");
var Simple_JSON = require("../Simple.JSON/index.js");
var validate = function (result) {
    if (result instanceof Data_Either.Left) {
        if (result.value0 instanceof Server_Shared_Persistence_Postgres_Query.IntegrityError) {
            if (result.value0.value0.constraint === "email_unique") {
                return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_User_Type_Misc.EMAIL_EXISTS.value));
            };
            if (result.value0.value0.constraint === "username_unique") {
                return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_User_Type_Misc.USERNAME_EXISTS.value));
            };
            return Control_Monad_Error_Class.throwError(Effect_Aff.monadThrowAff)(Effect_Exception.error(Data_Show.show(Server_Shared_Persistence_Postgres_Query.showPGError)(result.value0)));
        };
        return Control_Monad_Error_Class.throwError(Effect_Aff.monadThrowAff)(Effect_Exception.error(Data_Show.show(Server_Shared_Persistence_Postgres_Query.showPGError)(result.value0)));
    };
    if (result instanceof Data_Either.Right) {
        var v = Data_Array.head(result.value0);
        if (v instanceof Data_Maybe.Nothing) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Left(Server_User_Type_Misc.NOT_FOUND.value));
        };
        if (v instanceof Data_Maybe.Just) {
            return Control_Applicative.pure(Effect_Aff.applicativeAff)(new Data_Either.Right(v.value0));
        };
        throw new Error("Failed pattern match at Server.User.Persistence.Postgres (line 86, column 19 - line 88, column 35): " + [ v.constructor.name ]);
    };
    throw new Error("Failed pattern match at Server.User.Persistence.Postgres (line 79, column 3 - line 88, column 35): " + [ result.constructor.name ]);
};
var update = function (pool) {
    return function (r) {
        return function (id) {
            return Database_Postgres.withClient(pool)(function (conn) {
                return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "bio";
                }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "email";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "id";
                }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "image";
                }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "password";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                    return "username";
                }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())))("UPDATE \"user\" SET  bio = $1, email = $2, image = $3, password = $4, username = $5 WHERE id = $6 RETURNING *")([ Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Shared_Type_LongString.isSqlValueShortString))(r.bio), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(r.email), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Shared_Type_LongString.isSqlValueShortString))(r.image), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(r.password), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(r.username), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(id) ])(conn))(validate);
            });
        };
    };
};
var insert = function (pool) {
    return function (u) {
        return Database_Postgres.withClient(pool)(function (conn) {
            return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "bio";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "email";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "id";
            }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "image";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "password";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "username";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())))("INSERT INTO \"user\" (bio, email, image, password, username) VALUES ($1, $2, $3, $4, $5) RETURNING *")([ Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Shared_Type_LongString.isSqlValueShortString))(u.bio), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(u.email), Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueMaybe(Shared_Type_LongString.isSqlValueShortString))(u.image), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(u.password), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(u.username) ])(conn))(validate);
        });
    };
};
var findByUsername = function (pool) {
    return function (username) {
        return Database_Postgres.withClient(pool)(function (conn) {
            return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "bio";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "email";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "id";
            }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "image";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "password";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "username";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())))("SELECT * FROM \"user\" WHERE username = $1")([ Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(username) ])(conn))(validate);
        });
    };
};
var findById = function (pool) {
    return function (id) {
        return Database_Postgres.withClient(pool)(function (conn) {
            return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "bio";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "email";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "id";
            }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "image";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "password";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "username";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())))("SELECT * FROM \"user\" WHERE id = $1")([ Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(id) ])(conn))(validate);
        });
    };
};
var findByCredentials = function (pool) {
    return function (v) {
        return Database_Postgres.withClient(pool)(function (conn) {
            return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "bio";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "email";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "id";
            }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "image";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "password";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "username";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())))("SELECT * FROM \"user\" WHERE email = $1 AND password = $2")([ Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(v.email), Server_Shared_Persistence_Postgres_Query.p_(Shared_Type_ShortString.isSqlValueShortString)(v.password) ])(conn))(validate);
        });
    };
};
var $$delete = function (pool) {
    return function (id) {
        return Database_Postgres.withClient(pool)(function (conn) {
            return Control_Bind.bind(Effect_Aff.bindAff)(Server_Shared_Persistence_Postgres_Query.query(Server_Shared_Persistence_Postgres_Query.readJson(Simple_JSON.readRecord()(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "bio";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "email";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "id";
            }))(Simple_JSON.readInt)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "image";
            }))(Simple_JSON.readMaybe(Shared_Type_LongString.readForeignLongString))(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "password";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsCons(new Data_Symbol.IsSymbol(function () {
                return "username";
            }))(Shared_Type_ShortString.readForeignShortString)(Simple_JSON.readFieldsNil)()())()())()())()())()())()())))("DELETE FROM \"user\" WHERE id = $1 RETURNING *")([ Server_Shared_Persistence_Postgres_Query.p_(Database_Postgres_SqlValue.isSqlValueInt)(id) ])(conn))(validate);
        });
    };
};
var mkHandle = function (p) {
    return {
        findByCredentials: findByCredentials(p),
        findByUsername: findByUsername(p),
        findById: findById(p),
        insert: insert(p),
        update: update(p),
        "delete": $$delete(p)
    };
};
module.exports = {
    mkHandle: mkHandle,
    findByCredentials: findByCredentials,
    findByUsername: findByUsername,
    findById: findById,
    insert: insert,
    update: update,
    "delete": $$delete,
    validate: validate
};