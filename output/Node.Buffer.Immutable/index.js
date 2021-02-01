// Generated by purs version 0.13.8
"use strict";
var $foreign = require("./foreign.js");
var Data_Eq = require("../Data.Eq/index.js");
var Data_Maybe = require("../Data.Maybe/index.js");
var Data_Ord = require("../Data.Ord/index.js");
var Data_Ordering = require("../Data.Ordering/index.js");
var Data_Show = require("../Data.Show/index.js");
var Node_Buffer_Types = require("../Node.Buffer.Types/index.js");
var Node_Encoding = require("../Node.Encoding/index.js");
var toString = function ($3) {
    return $foreign.toStringImpl(Node_Encoding.encodingToNode($3));
};
var showBuffer = new Data_Show.Show($foreign.showImpl);
var readString = function ($4) {
    return $foreign.readStringImpl(Node_Encoding.encodingToNode($4));
};
var read = (function () {
    var $5 = Data_Show.show(Node_Buffer_Types.showBufferValueType);
    return function ($6) {
        return $foreign.readImpl($5($6));
    };
})();
var getAtOffset = $foreign.getAtOffsetImpl(Data_Maybe.Just.create)(Data_Maybe.Nothing.value);
var fromString = function (str) {
    var $7 = $foreign.fromStringImpl(str);
    return function ($8) {
        return $7(Node_Encoding.encodingToNode($8));
    };
};
var eqBuffer = new Data_Eq.Eq($foreign.eqImpl);
var ordBuffer = new Data_Ord.Ord(function () {
    return eqBuffer;
}, function (a) {
    return function (b) {
        var v = $foreign.compareImpl(a)(b);
        if (v < 0) {
            return Data_Ordering.LT.value;
        };
        if (v > 0) {
            return Data_Ordering.GT.value;
        };
        return Data_Ordering.EQ.value;
    };
});
module.exports = {
    fromString: fromString,
    read: read,
    readString: readString,
    toString: toString,
    getAtOffset: getAtOffset,
    showBuffer: showBuffer,
    eqBuffer: eqBuffer,
    ordBuffer: ordBuffer,
    create: $foreign.create,
    fromArray: $foreign.fromArray,
    fromArrayBuffer: $foreign.fromArrayBuffer,
    toArray: $foreign.toArray,
    toArrayBuffer: $foreign.toArrayBuffer,
    concat: $foreign.concat,
    "concat'": $foreign["concat'"],
    slice: $foreign.slice,
    size: $foreign.size
};
