// Generated by purs version 0.13.8
"use strict";
var Server_Shell_Persistence_Postgres = require("../Server.Shell.Persistence.Postgres/index.js");
var Server_Shell_Util_Token = require("../Server.Shell.Util.Token/index.js");
var mkHandle = function (config) {
    return function __do() {
        var persistence = Server_Shell_Persistence_Postgres.mkHandle(config)();
        return {
            persistence: persistence,
            token: Server_Shell_Util_Token.mkHandle(config.token.secret)
        };
    };
};
module.exports = {
    mkHandle: mkHandle
};