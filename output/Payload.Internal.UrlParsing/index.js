// Generated by purs version 0.13.8
"use strict";
var Data_Eq = require("../Data.Eq/index.js");
var Data_List = require("../Data.List/index.js");
var Data_List_Types = require("../Data.List.Types/index.js");
var Data_Ord = require("../Data.Ord/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_Symbol = require("../Data.Symbol/index.js");
var UrlListProxy = (function () {
    function UrlListProxy() {

    };
    UrlListProxy.value = new UrlListProxy();
    return UrlListProxy;
})();
var Lit = (function () {
    function Lit(value0) {
        this.value0 = value0;
    };
    Lit.create = function (value0) {
        return new Lit(value0);
    };
    return Lit;
})();
var Key = (function () {
    function Key(value0) {
        this.value0 = value0;
    };
    Key.create = function (value0) {
        return new Key(value0);
    };
    return Key;
})();
var Multi = (function () {
    function Multi(value0) {
        this.value0 = value0;
    };
    Multi.create = function (value0) {
        return new Multi(value0);
    };
    return Multi;
})();
var ToSegments = function (toSegments) {
    this.toSegments = toSegments;
};
var ShowUrl = function (showUrl) {
    this.showUrl = showUrl;
};
var ParseUrl = {};
var ParseError = {};
var Match = {};
var toSegmentsUrlNil = new ToSegments(function (v) {
    return function (acc) {
        return acc;
    };
});
var toSegments = function (dict) {
    return dict.toSegments;
};
var toSegmentsConsKey = function (dictIsSymbol) {
    return function (dictToSegments) {
        return new ToSegments(function (v) {
            return function (segs) {
                var keyStr = Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value);
                return toSegments(dictToSegments)(UrlListProxy.value)(new Data_List_Types.Cons(new Key(keyStr), segs));
            };
        });
    };
};
var toSegmentsConsLit = function (dictIsSymbol) {
    return function (dictToSegments) {
        return new ToSegments(function (v) {
            return function (segs) {
                var litStr = Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value);
                return toSegments(dictToSegments)(UrlListProxy.value)(new Data_List_Types.Cons(new Lit(litStr), segs));
            };
        });
    };
};
var toSegmentsConsMulti = function (dictIsSymbol) {
    return function (dictToSegments) {
        return new ToSegments(function (v) {
            return function (segs) {
                var multiStr = Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value);
                return toSegments(dictToSegments)(UrlListProxy.value)(new Data_List_Types.Cons(new Multi(multiStr), segs));
            };
        });
    };
};
var switchKeyToMulti = function (dictCons) {
    return function (dictCons1) {
        return function (dictMatch) {
            return Match;
        };
    };
};
var startSlash = function (dictCons) {
    return function (dictMatch) {
        return Match;
    };
};
var startLit = function (dictCons) {
    return function (dictMatch) {
        return Match;
    };
};
var startKey = function (dictCons) {
    return function (dictMatch) {
        return Match;
    };
};
var splitLit = function (dictCons) {
    return function (dictMatch) {
        return Match;
    };
};
var showUrlUrlNil = new ShowUrl(function (v) {
    return function (acc) {
        return acc;
    };
});
var showUrl = function (dict) {
    return dict.showUrl;
};
var showUrlConsKey = function (dictIsSymbol) {
    return function (dictShowUrl) {
        return new ShowUrl(function (v) {
            return function (str) {
                var keyStr = Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value);
                return showUrl(dictShowUrl)(UrlListProxy.value)(str + ("(key: " + (keyStr + ")")));
            };
        });
    };
};
var showUrlConsLit = function (dictIsSymbol) {
    return function (dictShowUrl) {
        return new ShowUrl(function (v) {
            return function (str) {
                var litStr = Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value);
                return showUrl(dictShowUrl)(UrlListProxy.value)(str + ("(lit: " + (litStr + ")")));
            };
        });
    };
};
var showUrlConsMulti = function (dictIsSymbol) {
    return function (dictShowUrl) {
        return new ShowUrl(function (v) {
            return function (str) {
                var multiStr = Data_Symbol.reflectSymbol(dictIsSymbol)(Data_Symbol.SProxy.value);
                return showUrl(dictShowUrl)(UrlListProxy.value)(str + ("(multi: " + (multiStr + ")")));
            };
        });
    };
};
var showSegment = new Data_Show.Show(function (v) {
    if (v instanceof Lit) {
        return v.value0;
    };
    if (v instanceof Key) {
        return "<" + (v.value0 + ">");
    };
    if (v instanceof Multi) {
        return "<" + (v.value0 + "..>");
    };
    throw new Error("Failed pattern match at Payload.Internal.UrlParsing (line 58, column 1 - line 61, column 37): " + [ v.constructor.name ]);
});
var queryAfterMulti = function (dictCons) {
    return function (dictMatch) {
        return Match;
    };
};
var parseError = function (dictFail) {
    return function (dictAppend) {
        return function (dictPrintArrow) {
            return ParseError;
        };
    };
};
var failNoSlashAtStart = function (dictCons) {
    return function (dictParseError) {
        return Match;
    };
};
var failNestedOpenMulti = function (dictParseError) {
    return Match;
};
var failNestedOpenKey = function (dictParseError) {
    return Match;
};
var failMissingMultiEnd = function (dictParseError) {
    return Match;
};
var failMissingKeyEnd = function (dictAppend) {
    return function (dictParseError) {
        return Match;
    };
};
var failMatch = function (dictFail) {
    return Match;
};
var failEndKeyWithoutStart = function (dictParseError) {
    return Match;
};
var failEmptyMulti = function (dictParseError) {
    return Match;
};
var failEmptyKey = function (dictParseError) {
    return Match;
};
var eqSegment = new Data_Eq.Eq(function (v) {
    return function (v1) {
        if (v instanceof Lit && v1 instanceof Lit) {
            return v.value0 === v1.value0;
        };
        if (v instanceof Key && v1 instanceof Key) {
            return v.value0 === v1.value0;
        };
        if (v instanceof Multi && v1 instanceof Multi) {
            return v.value0 === v1.value0;
        };
        return false;
    };
});
var ordSegment = new Data_Ord.Ord(function () {
    return eqSegment;
}, function (v) {
    return function (v1) {
        if (v instanceof Lit && v1 instanceof Lit) {
            return Data_Ord.compare(Data_Ord.ordString)(v.value0)(v1.value0);
        };
        if (v instanceof Key && v1 instanceof Key) {
            return Data_Ord.compare(Data_Ord.ordString)(v.value0)(v1.value0);
        };
        if (v instanceof Multi && v1 instanceof Multi) {
            return Data_Ord.compare(Data_Ord.ordString)(v.value0)(v1.value0);
        };
        var rank = function (v2) {
            if (v2 instanceof Lit) {
                return 1;
            };
            if (v2 instanceof Key) {
                return 2;
            };
            if (v2 instanceof Multi) {
                return 3;
            };
            throw new Error("Failed pattern match at Payload.Internal.UrlParsing (line 69, column 7 - line 69, column 23): " + [ v2.constructor.name ]);
        };
        return Data_Ord.compare(Data_Ord.ordInt)(rank(v))(rank(v1));
    };
});
var endTrailingSlashLit = Match;
var endLitAtQuery = Match;
var endKey = function (dictCons) {
    return function (dictMatch) {
        return Match;
    };
};
var endEmptyTrailingSlashLit = Match;
var endAtQuery = Match;
var endAtMulti = Match;
var endAtLit = function (dictAppend) {
    return Match;
};
var endAtKey = Match;
var emptyLit = function (dictCons) {
    return function (dictMatch) {
        return Match;
    };
};
var debugShowUrl = function (dictParseUrl) {
    return function (dictShowUrl) {
        return function (v) {
            return showUrl(dictShowUrl)(UrlListProxy.value)("");
        };
    };
};
var contMulti = function (dictCons) {
    return function (dictAppend) {
        return function (dictMatch) {
            return Match;
        };
    };
};
var contLit = function (dictCons) {
    return function (dictAppend) {
        return function (dictMatch) {
            return Match;
        };
    };
};
var contKey = function (dictCons) {
    return function (dictAppend) {
        return function (dictMatch) {
            return Match;
        };
    };
};
var bConsParse = function (dictCons) {
    return function (dictMatch) {
        return ParseUrl;
    };
};
var asSegments = function (dictParseUrl) {
    return function (dictToSegments) {
        return function (v) {
            return Data_List.reverse(toSegments(dictToSegments)(UrlListProxy.value)(Data_List_Types.Nil.value));
        };
    };
};
var aNilParse = ParseUrl;
module.exports = {
    showUrl: showUrl,
    toSegments: toSegments,
    debugShowUrl: debugShowUrl,
    ShowUrl: ShowUrl,
    Lit: Lit,
    Key: Key,
    Multi: Multi,
    asSegments: asSegments,
    ToSegments: ToSegments,
    UrlListProxy: UrlListProxy,
    ParseUrl: ParseUrl,
    Match: Match,
    ParseError: ParseError,
    showUrlUrlNil: showUrlUrlNil,
    showUrlConsKey: showUrlConsKey,
    showUrlConsMulti: showUrlConsMulti,
    showUrlConsLit: showUrlConsLit,
    eqSegment: eqSegment,
    showSegment: showSegment,
    ordSegment: ordSegment,
    toSegmentsUrlNil: toSegmentsUrlNil,
    toSegmentsConsKey: toSegmentsConsKey,
    toSegmentsConsMulti: toSegmentsConsMulti,
    toSegmentsConsLit: toSegmentsConsLit,
    aNilParse: aNilParse,
    bConsParse: bConsParse,
    endEmptyTrailingSlashLit: endEmptyTrailingSlashLit,
    endTrailingSlashLit: endTrailingSlashLit,
    startSlash: startSlash,
    failNoSlashAtStart: failNoSlashAtStart,
    failEmptyMulti: failEmptyMulti,
    endAtMulti: endAtMulti,
    queryAfterMulti: queryAfterMulti,
    failMissingMultiEnd: failMissingMultiEnd,
    failNestedOpenMulti: failNestedOpenMulti,
    contMulti: contMulti,
    startKey: startKey,
    switchKeyToMulti: switchKeyToMulti,
    failEmptyKey: failEmptyKey,
    endAtKey: endAtKey,
    endKey: endKey,
    failMissingKeyEnd: failMissingKeyEnd,
    failNestedOpenKey: failNestedOpenKey,
    contKey: contKey,
    failEndKeyWithoutStart: failEndKeyWithoutStart,
    endLitAtQuery: endLitAtQuery,
    endAtQuery: endAtQuery,
    emptyLit: emptyLit,
    startLit: startLit,
    splitLit: splitLit,
    endAtLit: endAtLit,
    contLit: contLit,
    failMatch: failMatch,
    parseError: parseError
};