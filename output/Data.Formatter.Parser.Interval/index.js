// Generated by purs version 0.13.8
"use strict";
var Control_Alt = require("../Control.Alt/index.js");
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Apply = require("../Control.Apply/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Eq = require("../Data.Eq/index.js");
var Data_Foldable = require("../Data.Foldable/index.js");
var Data_Formatter_DateTime = require("../Data.Formatter.DateTime/index.js");
var Data_Formatter_Parser_Number = require("../Data.Formatter.Parser.Number/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_Identity = require("../Data.Identity/index.js");
var Data_Interval = require("../Data.Interval/index.js");
var Data_Interval_Duration = require("../Data.Interval.Duration/index.js");
var Data_Interval_Duration_Iso = require("../Data.Interval.Duration.Iso/index.js");
var Data_List_Types = require("../Data.List.Types/index.js");
var Data_Monoid = require("../Data.Monoid/index.js");
var Data_Semigroup = require("../Data.Semigroup/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_Traversable = require("../Data.Traversable/index.js");
var Data_Tuple = require("../Data.Tuple/index.js");
var Text_Parsing_Parser = require("../Text.Parsing.Parser/index.js");
var Text_Parsing_Parser_Combinators = require("../Text.Parsing.Parser.Combinators/index.js");
var Text_Parsing_Parser_String = require("../Text.Parsing.Parser.String/index.js");
var parseInterval = function (duration) {
    return function (date) {
        var startEnd = Control_Apply.apply(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Control_Apply.applyFirst(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Data_Functor.map(Text_Parsing_Parser.functorParserT(Data_Identity.functorIdentity))(Data_Interval.StartEnd.create)(date))(Text_Parsing_Parser_String.string(Text_Parsing_Parser_String.stringLikeString)(Data_Identity.monadIdentity)("/")))(date);
        var startDuration = Control_Apply.apply(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Control_Apply.applyFirst(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Data_Functor.map(Text_Parsing_Parser.functorParserT(Data_Identity.functorIdentity))(Data_Interval.StartDuration.create)(date))(Text_Parsing_Parser_String.string(Text_Parsing_Parser_String.stringLikeString)(Data_Identity.monadIdentity)("/")))(duration);
        var durationOnly = Data_Functor.map(Text_Parsing_Parser.functorParserT(Data_Identity.functorIdentity))(Data_Interval.DurationOnly.create)(duration);
        var durationEnd = Control_Apply.apply(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Control_Apply.applyFirst(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Data_Functor.map(Text_Parsing_Parser.functorParserT(Data_Identity.functorIdentity))(Data_Interval.DurationEnd.create)(duration))(Text_Parsing_Parser_String.string(Text_Parsing_Parser_String.stringLikeString)(Data_Identity.monadIdentity)("/")))(date);
        return Text_Parsing_Parser_Combinators.choice(Data_Foldable.foldableArray)(Data_Identity.monadIdentity)(Data_Functor.mapFlipped(Data_Functor.functorArray)([ startEnd, durationEnd, startDuration, durationOnly ])(Text_Parsing_Parser_Combinators["try"](Data_Identity.monadIdentity)));
    };
};
var parseRecurringInterval = function (duration) {
    return function (date) {
        return Control_Apply.apply(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Data_Functor.map(Text_Parsing_Parser.functorParserT(Data_Identity.functorIdentity))(Data_Interval.RecurringInterval.create)(Control_Apply.applySecond(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Text_Parsing_Parser_String.string(Text_Parsing_Parser_String.stringLikeString)(Data_Identity.monadIdentity)("R"))(Data_Formatter_Parser_Number.parseMaybeInteger(Data_Identity.monadIdentity)(Text_Parsing_Parser_String.stringLikeString))))(Control_Apply.applySecond(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Text_Parsing_Parser_String.string(Text_Parsing_Parser_String.stringLikeString)(Data_Identity.monadIdentity)("/"))(parseInterval(duration)(date)));
    };
};
var failIfEmpty = function (dictMonoid) {
    return function (dictEq) {
        return function (p) {
            return function (str) {
                return Control_Bind.bind(Text_Parsing_Parser.bindParserT(Data_Identity.monadIdentity))(p)(function (x) {
                    var $8 = Data_Eq.eq(dictEq)(x)(Data_Monoid.mempty(dictMonoid));
                    if ($8) {
                        return Text_Parsing_Parser.fail(Data_Identity.monadIdentity)(str);
                    };
                    return Control_Applicative.pure(Text_Parsing_Parser.applicativeParserT(Data_Identity.monadIdentity))(x);
                });
            };
        };
    };
};
var mkComponentsParser = function (arr) {
    var foldFoldableMaybe = function (dictFoldable) {
        return function (dictMonoid) {
            return Data_Foldable.foldMap(dictFoldable)(dictMonoid)(Data_Foldable.fold(Data_Foldable.foldableMaybe)(dictMonoid));
        };
    };
    var component = function (designator) {
        return Control_Apply.applyFirst(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Data_Formatter_Parser_Number.parseNumber(Data_Identity.monadIdentity)(Text_Parsing_Parser_String.stringLikeString))(Text_Parsing_Parser_String.string(Text_Parsing_Parser_String.stringLikeString)(Data_Identity.monadIdentity)(designator));
    };
    var applyDurations = function (v) {
        return Text_Parsing_Parser_Combinators.optionMaybe(Data_Identity.monadIdentity)(Text_Parsing_Parser_Combinators["try"](Data_Identity.monadIdentity)(Data_Functor.map(Text_Parsing_Parser.functorParserT(Data_Identity.functorIdentity))(v.value0)(component(v.value1))));
    };
    var p = Data_Functor.mapFlipped(Text_Parsing_Parser.functorParserT(Data_Identity.functorIdentity))(Data_Traversable.sequence(Data_Traversable.traversableArray)(Text_Parsing_Parser.applicativeParserT(Data_Identity.monadIdentity))(Data_Functor.mapFlipped(Data_Functor.functorArray)(arr)(applyDurations)))(foldFoldableMaybe(Data_Foldable.foldableArray)(Data_Interval_Duration.monoidDuration));
    return failIfEmpty(Data_Interval_Duration.monoidDuration)(Data_Interval_Duration.eqDuration)(p)("None of valid duration components (" + (Data_Show.show(Data_Show.showArray(Data_Show.showString))(Data_Functor.map(Data_Functor.functorArray)(Data_Tuple.snd)(arr)) + ") were present"));
};
var parseDuration = (function () {
    var weekDuration = mkComponentsParser([ new Data_Tuple.Tuple(Data_Interval_Duration.week, "W") ]);
    var durationTimePart = Text_Parsing_Parser_Combinators.option(Data_Identity.monadIdentity)(Data_Monoid.mempty(Data_Interval_Duration.monoidDuration))(Control_Apply.applySecond(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Text_Parsing_Parser_Combinators["try"](Data_Identity.monadIdentity)(Text_Parsing_Parser_String.string(Text_Parsing_Parser_String.stringLikeString)(Data_Identity.monadIdentity)("T")))(mkComponentsParser([ new Data_Tuple.Tuple(Data_Interval_Duration.hour, "H"), new Data_Tuple.Tuple(Data_Interval_Duration.minute, "M"), new Data_Tuple.Tuple(Data_Interval_Duration.second, "S") ])));
    var durationDatePart = Text_Parsing_Parser_Combinators.option(Data_Identity.monadIdentity)(Data_Monoid.mempty(Data_Interval_Duration.monoidDuration))(Text_Parsing_Parser_Combinators["try"](Data_Identity.monadIdentity)(mkComponentsParser([ new Data_Tuple.Tuple(Data_Interval_Duration.year, "Y"), new Data_Tuple.Tuple(Data_Interval_Duration.month, "M"), new Data_Tuple.Tuple(Data_Interval_Duration.day, "D") ])));
    var fullDuration = failIfEmpty(Data_Interval_Duration.monoidDuration)(Data_Interval_Duration.eqDuration)(Control_Apply.apply(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Data_Functor.map(Text_Parsing_Parser.functorParserT(Data_Identity.functorIdentity))(Data_Semigroup.append(Data_Interval_Duration.semigroupDuration))(durationDatePart))(durationTimePart))("Must contain valid duration components");
    return Control_Apply.applySecond(Text_Parsing_Parser.applyParserT(Data_Identity.monadIdentity))(Text_Parsing_Parser_String.string(Text_Parsing_Parser_String.stringLikeString)(Data_Identity.monadIdentity)("P"))(Control_Alt.alt(Text_Parsing_Parser.altParserT(Data_Identity.monadIdentity))(weekDuration)(fullDuration));
})();
var parseIsoDuration = Control_Bind.bind(Text_Parsing_Parser.bindParserT(Data_Identity.monadIdentity))(parseDuration)(function (dur) {
    var v = Data_Interval_Duration_Iso.mkIsoDuration(dur);
    if (v instanceof Data_Either.Left) {
        var errorStr = Data_Foldable.intercalate(Data_List_Types.foldableNonEmptyList)(Data_Monoid.monoidString)(", ")(Data_Functor.map(Data_List_Types.functorNonEmptyList)(Data_Interval_Duration_Iso.prettyError)(v.value0));
        return Text_Parsing_Parser.fail(Data_Identity.monadIdentity)("Extracted Duration is not valid ISO duration (" + (errorStr + ")"));
    };
    if (v instanceof Data_Either.Right) {
        return Control_Applicative.pure(Text_Parsing_Parser.applicativeParserT(Data_Identity.monadIdentity))(v.value0);
    };
    throw new Error("Failed pattern match at Data.Formatter.Parser.Interval (line 42, column 3 - line 46, column 21): " + [ v.constructor.name ]);
});
var extendedDateTimeFormatInUTC = Data_Either.fromRight()(Data_Formatter_DateTime.parseFormatString("YYYY-MM-DDTHH:mm:ssZ"));
var parseDateTime = function (dictMonad) {
    return Data_Formatter_DateTime.unformatParser(dictMonad)(extendedDateTimeFormatInUTC);
};
module.exports = {
    parseRecurringInterval: parseRecurringInterval,
    parseInterval: parseInterval,
    parseIsoDuration: parseIsoDuration,
    parseDateTime: parseDateTime,
    extendedDateTimeFormatInUTC: extendedDateTimeFormatInUTC
};