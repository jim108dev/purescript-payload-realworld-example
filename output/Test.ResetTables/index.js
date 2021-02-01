// Generated by purs version 0.13.8
"use strict";
var Control_Bind = require("../Control.Bind/index.js");
var Effect_Aff = require("../Effect.Aff/index.js");
var Effect_Class = require("../Effect.Class/index.js");
var Server_Shell_Util_Aggregate = require("../Server.Shell.Util.Aggregate/index.js");
var Server_Shell_Util_Config = require("../Server.Shell.Util.Config/index.js");
var Test_Server_Shell_Persistence_Postgres = require("../Test.Server.Shell.Persistence.Postgres/index.js");
var main = Effect_Aff.launchAff_(Control_Bind.bind(Effect_Aff.bindAff)(Server_Shell_Util_Config.readOrThrow("./config/Server/Dev.json"))(function (config) {
    return Control_Bind.bind(Effect_Aff.bindAff)(Test_Server_Shell_Persistence_Postgres.readSqlStatements("./sql/ResetTables.sql"))(function (sqlStatements) {
        return Control_Bind.bind(Effect_Aff.bindAff)(Effect_Class.liftEffect(Effect_Aff.monadEffectAff)(Server_Shell_Util_Aggregate.mkHandle(config)))(function (h1) {
            return Control_Bind.discard(Control_Bind.discardUnit)(Effect_Aff.bindAff)(Test_Server_Shell_Persistence_Postgres.resetDB(h1.persistence.pool)(sqlStatements))(function () {
                return Test_Server_Shell_Persistence_Postgres.endPool(h1.persistence.pool);
            });
        });
    });
}));
module.exports = {
    main: main
};