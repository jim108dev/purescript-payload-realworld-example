// Generated by purs version 0.13.8
"use strict";
var Control_Bind = require("../Control.Bind/index.js");
var Control_Monad_Except_Trans = require("../Control.Monad.Except.Trans/index.js");
var Effect_Aff = require("../Effect.Aff/index.js");
var Server_User_Type_Misc = require("../Server.User.Type.Misc/index.js");
var update = function (h) {
    return function (patch) {
        return function (id) {
            return Control_Monad_Except_Trans.runExceptT(Control_Bind.bind(Control_Monad_Except_Trans.bindExceptT(Effect_Aff.monadAff))(Control_Monad_Except_Trans.ExceptT(h.findById(id)))(function (fallback) {
                return Control_Monad_Except_Trans.ExceptT(h.update(Server_User_Type_Misc.mkRawFromPatch(fallback)(patch))(id));
            }));
        };
    };
};
module.exports = {
    update: update
};