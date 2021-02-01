// Generated by purs version 0.13.8
"use strict";
var Data_Eq = require("../Data.Eq/index.js");
var Data_Foldable = require("../Data.Foldable/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_List_Types = require("../Data.List.Types/index.js");
var Data_Monoid = require("../Data.Monoid/index.js");
var Data_Ord = require("../Data.Ord/index.js");
var Data_Ordering = require("../Data.Ordering/index.js");
var Data_Show = require("../Data.Show/index.js");
var Bold = (function () {
    function Bold() {

    };
    Bold.value = new Bold();
    return Bold;
})();
var Dim = (function () {
    function Dim() {

    };
    Dim.value = new Dim();
    return Dim;
})();
var Italic = (function () {
    function Italic() {

    };
    Italic.value = new Italic();
    return Italic;
})();
var Underline = (function () {
    function Underline() {

    };
    Underline.value = new Underline();
    return Underline;
})();
var Inverse = (function () {
    function Inverse() {

    };
    Inverse.value = new Inverse();
    return Inverse;
})();
var Strikethrough = (function () {
    function Strikethrough() {

    };
    Strikethrough.value = new Strikethrough();
    return Strikethrough;
})();
var ToEnd = (function () {
    function ToEnd() {

    };
    ToEnd.value = new ToEnd();
    return ToEnd;
})();
var FromBeginning = (function () {
    function FromBeginning() {

    };
    FromBeginning.value = new FromBeginning();
    return FromBeginning;
})();
var Entire = (function () {
    function Entire() {

    };
    Entire.value = new Entire();
    return Entire;
})();
var Black = (function () {
    function Black() {

    };
    Black.value = new Black();
    return Black;
})();
var Red = (function () {
    function Red() {

    };
    Red.value = new Red();
    return Red;
})();
var Green = (function () {
    function Green() {

    };
    Green.value = new Green();
    return Green;
})();
var Yellow = (function () {
    function Yellow() {

    };
    Yellow.value = new Yellow();
    return Yellow;
})();
var Blue = (function () {
    function Blue() {

    };
    Blue.value = new Blue();
    return Blue;
})();
var Magenta = (function () {
    function Magenta() {

    };
    Magenta.value = new Magenta();
    return Magenta;
})();
var Cyan = (function () {
    function Cyan() {

    };
    Cyan.value = new Cyan();
    return Cyan;
})();
var White = (function () {
    function White() {

    };
    White.value = new White();
    return White;
})();
var BrightBlack = (function () {
    function BrightBlack() {

    };
    BrightBlack.value = new BrightBlack();
    return BrightBlack;
})();
var BrightRed = (function () {
    function BrightRed() {

    };
    BrightRed.value = new BrightRed();
    return BrightRed;
})();
var BrightGreen = (function () {
    function BrightGreen() {

    };
    BrightGreen.value = new BrightGreen();
    return BrightGreen;
})();
var BrightYellow = (function () {
    function BrightYellow() {

    };
    BrightYellow.value = new BrightYellow();
    return BrightYellow;
})();
var BrightBlue = (function () {
    function BrightBlue() {

    };
    BrightBlue.value = new BrightBlue();
    return BrightBlue;
})();
var BrightMagenta = (function () {
    function BrightMagenta() {

    };
    BrightMagenta.value = new BrightMagenta();
    return BrightMagenta;
})();
var BrightCyan = (function () {
    function BrightCyan() {

    };
    BrightCyan.value = new BrightCyan();
    return BrightCyan;
})();
var BrightWhite = (function () {
    function BrightWhite() {

    };
    BrightWhite.value = new BrightWhite();
    return BrightWhite;
})();
var Reset = (function () {
    function Reset() {

    };
    Reset.value = new Reset();
    return Reset;
})();
var PMode = (function () {
    function PMode(value0) {
        this.value0 = value0;
    };
    PMode.create = function (value0) {
        return new PMode(value0);
    };
    return PMode;
})();
var PForeground = (function () {
    function PForeground(value0) {
        this.value0 = value0;
    };
    PForeground.create = function (value0) {
        return new PForeground(value0);
    };
    return PForeground;
})();
var PBackground = (function () {
    function PBackground(value0) {
        this.value0 = value0;
    };
    PBackground.create = function (value0) {
        return new PBackground(value0);
    };
    return PBackground;
})();
var Up = (function () {
    function Up(value0) {
        this.value0 = value0;
    };
    Up.create = function (value0) {
        return new Up(value0);
    };
    return Up;
})();
var Down = (function () {
    function Down(value0) {
        this.value0 = value0;
    };
    Down.create = function (value0) {
        return new Down(value0);
    };
    return Down;
})();
var Forward = (function () {
    function Forward(value0) {
        this.value0 = value0;
    };
    Forward.create = function (value0) {
        return new Forward(value0);
    };
    return Forward;
})();
var Back = (function () {
    function Back(value0) {
        this.value0 = value0;
    };
    Back.create = function (value0) {
        return new Back(value0);
    };
    return Back;
})();
var NextLine = (function () {
    function NextLine(value0) {
        this.value0 = value0;
    };
    NextLine.create = function (value0) {
        return new NextLine(value0);
    };
    return NextLine;
})();
var PreviousLine = (function () {
    function PreviousLine(value0) {
        this.value0 = value0;
    };
    PreviousLine.create = function (value0) {
        return new PreviousLine(value0);
    };
    return PreviousLine;
})();
var HorizontalAbsolute = (function () {
    function HorizontalAbsolute(value0) {
        this.value0 = value0;
    };
    HorizontalAbsolute.create = function (value0) {
        return new HorizontalAbsolute(value0);
    };
    return HorizontalAbsolute;
})();
var Position = (function () {
    function Position(value0, value1) {
        this.value0 = value0;
        this.value1 = value1;
    };
    Position.create = function (value0) {
        return function (value1) {
            return new Position(value0, value1);
        };
    };
    return Position;
})();
var EraseData = (function () {
    function EraseData(value0) {
        this.value0 = value0;
    };
    EraseData.create = function (value0) {
        return new EraseData(value0);
    };
    return EraseData;
})();
var EraseLine = (function () {
    function EraseLine(value0) {
        this.value0 = value0;
    };
    EraseLine.create = function (value0) {
        return new EraseLine(value0);
    };
    return EraseLine;
})();
var ScrollUp = (function () {
    function ScrollUp(value0) {
        this.value0 = value0;
    };
    ScrollUp.create = function (value0) {
        return new ScrollUp(value0);
    };
    return ScrollUp;
})();
var ScrollDown = (function () {
    function ScrollDown(value0) {
        this.value0 = value0;
    };
    ScrollDown.create = function (value0) {
        return new ScrollDown(value0);
    };
    return ScrollDown;
})();
var Graphics = (function () {
    function Graphics(value0) {
        this.value0 = value0;
    };
    Graphics.create = function (value0) {
        return new Graphics(value0);
    };
    return Graphics;
})();
var SavePosition = (function () {
    function SavePosition() {

    };
    SavePosition.value = new SavePosition();
    return SavePosition;
})();
var RestorePosition = (function () {
    function RestorePosition() {

    };
    RestorePosition.value = new RestorePosition();
    return RestorePosition;
})();
var QueryPosition = (function () {
    function QueryPosition() {

    };
    QueryPosition.value = new QueryPosition();
    return QueryPosition;
})();
var HideCursor = (function () {
    function HideCursor() {

    };
    HideCursor.value = new HideCursor();
    return HideCursor;
})();
var ShowCursor = (function () {
    function ShowCursor() {

    };
    ShowCursor.value = new ShowCursor();
    return ShowCursor;
})();
var prefix = "\x1b[";
var eraseParamToString = function (ep) {
    if (ep instanceof ToEnd) {
        return "0";
    };
    if (ep instanceof FromBeginning) {
        return "1";
    };
    if (ep instanceof Entire) {
        return "2";
    };
    throw new Error("Failed pattern match at Ansi.Codes (line 86, column 3 - line 89, column 25): " + [ ep.constructor.name ]);
};
var eqRenderingMode = new Data_Eq.Eq(function (x) {
    return function (y) {
        if (x instanceof Bold && y instanceof Bold) {
            return true;
        };
        if (x instanceof Dim && y instanceof Dim) {
            return true;
        };
        if (x instanceof Italic && y instanceof Italic) {
            return true;
        };
        if (x instanceof Underline && y instanceof Underline) {
            return true;
        };
        if (x instanceof Inverse && y instanceof Inverse) {
            return true;
        };
        if (x instanceof Strikethrough && y instanceof Strikethrough) {
            return true;
        };
        return false;
    };
});
var ordRenderingMode = new Data_Ord.Ord(function () {
    return eqRenderingMode;
}, function (x) {
    return function (y) {
        if (x instanceof Bold && y instanceof Bold) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Bold) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Bold) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Dim && y instanceof Dim) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Dim) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Dim) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Italic && y instanceof Italic) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Italic) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Italic) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Underline && y instanceof Underline) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Underline) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Underline) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Inverse && y instanceof Inverse) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Inverse) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Inverse) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Strikethrough && y instanceof Strikethrough) {
            return Data_Ordering.EQ.value;
        };
        throw new Error("Failed pattern match at Ansi.Codes (line 119, column 1 - line 119, column 54): " + [ x.constructor.name, y.constructor.name ]);
    };
});
var eqEraseParam = new Data_Eq.Eq(function (x) {
    return function (y) {
        if (x instanceof ToEnd && y instanceof ToEnd) {
            return true;
        };
        if (x instanceof FromBeginning && y instanceof FromBeginning) {
            return true;
        };
        if (x instanceof Entire && y instanceof Entire) {
            return true;
        };
        return false;
    };
});
var ordEraseParam = new Data_Ord.Ord(function () {
    return eqEraseParam;
}, function (x) {
    return function (y) {
        if (x instanceof ToEnd && y instanceof ToEnd) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof ToEnd) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof ToEnd) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof FromBeginning && y instanceof FromBeginning) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof FromBeginning) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof FromBeginning) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Entire && y instanceof Entire) {
            return Data_Ordering.EQ.value;
        };
        throw new Error("Failed pattern match at Ansi.Codes (line 82, column 1 - line 82, column 48): " + [ x.constructor.name, y.constructor.name ]);
    };
});
var eqColor = new Data_Eq.Eq(function (x) {
    return function (y) {
        if (x instanceof Black && y instanceof Black) {
            return true;
        };
        if (x instanceof Red && y instanceof Red) {
            return true;
        };
        if (x instanceof Green && y instanceof Green) {
            return true;
        };
        if (x instanceof Yellow && y instanceof Yellow) {
            return true;
        };
        if (x instanceof Blue && y instanceof Blue) {
            return true;
        };
        if (x instanceof Magenta && y instanceof Magenta) {
            return true;
        };
        if (x instanceof Cyan && y instanceof Cyan) {
            return true;
        };
        if (x instanceof White && y instanceof White) {
            return true;
        };
        if (x instanceof BrightBlack && y instanceof BrightBlack) {
            return true;
        };
        if (x instanceof BrightRed && y instanceof BrightRed) {
            return true;
        };
        if (x instanceof BrightGreen && y instanceof BrightGreen) {
            return true;
        };
        if (x instanceof BrightYellow && y instanceof BrightYellow) {
            return true;
        };
        if (x instanceof BrightBlue && y instanceof BrightBlue) {
            return true;
        };
        if (x instanceof BrightMagenta && y instanceof BrightMagenta) {
            return true;
        };
        if (x instanceof BrightCyan && y instanceof BrightCyan) {
            return true;
        };
        if (x instanceof BrightWhite && y instanceof BrightWhite) {
            return true;
        };
        return false;
    };
});
var eqGraphicsParam = new Data_Eq.Eq(function (x) {
    return function (y) {
        if (x instanceof Reset && y instanceof Reset) {
            return true;
        };
        if (x instanceof PMode && y instanceof PMode) {
            return Data_Eq.eq(eqRenderingMode)(x.value0)(y.value0);
        };
        if (x instanceof PForeground && y instanceof PForeground) {
            return Data_Eq.eq(eqColor)(x.value0)(y.value0);
        };
        if (x instanceof PBackground && y instanceof PBackground) {
            return Data_Eq.eq(eqColor)(x.value0)(y.value0);
        };
        return false;
    };
});
var eqEscapeCode = new Data_Eq.Eq(function (x) {
    return function (y) {
        if (x instanceof Up && y instanceof Up) {
            return x.value0 === y.value0;
        };
        if (x instanceof Down && y instanceof Down) {
            return x.value0 === y.value0;
        };
        if (x instanceof Forward && y instanceof Forward) {
            return x.value0 === y.value0;
        };
        if (x instanceof Back && y instanceof Back) {
            return x.value0 === y.value0;
        };
        if (x instanceof NextLine && y instanceof NextLine) {
            return x.value0 === y.value0;
        };
        if (x instanceof PreviousLine && y instanceof PreviousLine) {
            return x.value0 === y.value0;
        };
        if (x instanceof HorizontalAbsolute && y instanceof HorizontalAbsolute) {
            return x.value0 === y.value0;
        };
        if (x instanceof Position && y instanceof Position) {
            return x.value0 === y.value0 && x.value1 === y.value1;
        };
        if (x instanceof EraseData && y instanceof EraseData) {
            return Data_Eq.eq(eqEraseParam)(x.value0)(y.value0);
        };
        if (x instanceof EraseLine && y instanceof EraseLine) {
            return Data_Eq.eq(eqEraseParam)(x.value0)(y.value0);
        };
        if (x instanceof ScrollUp && y instanceof ScrollUp) {
            return x.value0 === y.value0;
        };
        if (x instanceof ScrollDown && y instanceof ScrollDown) {
            return x.value0 === y.value0;
        };
        if (x instanceof Graphics && y instanceof Graphics) {
            return Data_Eq.eq(Data_List_Types.eqNonEmptyList(eqGraphicsParam))(x.value0)(y.value0);
        };
        if (x instanceof SavePosition && y instanceof SavePosition) {
            return true;
        };
        if (x instanceof RestorePosition && y instanceof RestorePosition) {
            return true;
        };
        if (x instanceof QueryPosition && y instanceof QueryPosition) {
            return true;
        };
        if (x instanceof HideCursor && y instanceof HideCursor) {
            return true;
        };
        if (x instanceof ShowCursor && y instanceof ShowCursor) {
            return true;
        };
        return false;
    };
});
var ordColor = new Data_Ord.Ord(function () {
    return eqColor;
}, function (x) {
    return function (y) {
        if (x instanceof Black && y instanceof Black) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Black) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Black) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Red && y instanceof Red) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Red) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Red) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Green && y instanceof Green) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Green) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Green) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Yellow && y instanceof Yellow) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Yellow) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Yellow) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Blue && y instanceof Blue) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Blue) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Blue) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Magenta && y instanceof Magenta) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Magenta) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Magenta) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Cyan && y instanceof Cyan) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Cyan) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Cyan) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof White && y instanceof White) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof White) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof White) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof BrightBlack && y instanceof BrightBlack) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof BrightBlack) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof BrightBlack) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof BrightRed && y instanceof BrightRed) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof BrightRed) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof BrightRed) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof BrightGreen && y instanceof BrightGreen) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof BrightGreen) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof BrightGreen) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof BrightYellow && y instanceof BrightYellow) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof BrightYellow) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof BrightYellow) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof BrightBlue && y instanceof BrightBlue) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof BrightBlue) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof BrightBlue) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof BrightMagenta && y instanceof BrightMagenta) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof BrightMagenta) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof BrightMagenta) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof BrightCyan && y instanceof BrightCyan) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof BrightCyan) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof BrightCyan) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof BrightWhite && y instanceof BrightWhite) {
            return Data_Ordering.EQ.value;
        };
        throw new Error("Failed pattern match at Ansi.Codes (line 151, column 1 - line 151, column 38): " + [ x.constructor.name, y.constructor.name ]);
    };
});
var ordGraphicsParam = new Data_Ord.Ord(function () {
    return eqGraphicsParam;
}, function (x) {
    return function (y) {
        if (x instanceof Reset && y instanceof Reset) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof Reset) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Reset) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof PMode && y instanceof PMode) {
            return Data_Ord.compare(ordRenderingMode)(x.value0)(y.value0);
        };
        if (x instanceof PMode) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof PMode) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof PForeground && y instanceof PForeground) {
            return Data_Ord.compare(ordColor)(x.value0)(y.value0);
        };
        if (x instanceof PForeground) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof PForeground) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof PBackground && y instanceof PBackground) {
            return Data_Ord.compare(ordColor)(x.value0)(y.value0);
        };
        throw new Error("Failed pattern match at Ansi.Codes (line 100, column 1 - line 100, column 54): " + [ x.constructor.name, y.constructor.name ]);
    };
});
var ordEscapeCode = new Data_Ord.Ord(function () {
    return eqEscapeCode;
}, function (x) {
    return function (y) {
        if (x instanceof Up && y instanceof Up) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof Up) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Up) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Down && y instanceof Down) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof Down) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Down) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Forward && y instanceof Forward) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof Forward) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Forward) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Back && y instanceof Back) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof Back) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Back) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof NextLine && y instanceof NextLine) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof NextLine) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof NextLine) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof PreviousLine && y instanceof PreviousLine) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof PreviousLine) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof PreviousLine) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof HorizontalAbsolute && y instanceof HorizontalAbsolute) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof HorizontalAbsolute) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof HorizontalAbsolute) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Position && y instanceof Position) {
            var v = Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
            if (v instanceof Data_Ordering.LT) {
                return Data_Ordering.LT.value;
            };
            if (v instanceof Data_Ordering.GT) {
                return Data_Ordering.GT.value;
            };
            return Data_Ord.compare(Data_Ord.ordInt)(x.value1)(y.value1);
        };
        if (x instanceof Position) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Position) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof EraseData && y instanceof EraseData) {
            return Data_Ord.compare(ordEraseParam)(x.value0)(y.value0);
        };
        if (x instanceof EraseData) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof EraseData) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof EraseLine && y instanceof EraseLine) {
            return Data_Ord.compare(ordEraseParam)(x.value0)(y.value0);
        };
        if (x instanceof EraseLine) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof EraseLine) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof ScrollUp && y instanceof ScrollUp) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof ScrollUp) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof ScrollUp) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof ScrollDown && y instanceof ScrollDown) {
            return Data_Ord.compare(Data_Ord.ordInt)(x.value0)(y.value0);
        };
        if (x instanceof ScrollDown) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof ScrollDown) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof Graphics && y instanceof Graphics) {
            return Data_Ord.compare(Data_List_Types.ordNonEmptyList(ordGraphicsParam))(x.value0)(y.value0);
        };
        if (x instanceof Graphics) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof Graphics) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof SavePosition && y instanceof SavePosition) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof SavePosition) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof SavePosition) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof RestorePosition && y instanceof RestorePosition) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof RestorePosition) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof RestorePosition) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof QueryPosition && y instanceof QueryPosition) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof QueryPosition) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof QueryPosition) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof HideCursor && y instanceof HideCursor) {
            return Data_Ordering.EQ.value;
        };
        if (x instanceof HideCursor) {
            return Data_Ordering.LT.value;
        };
        if (y instanceof HideCursor) {
            return Data_Ordering.GT.value;
        };
        if (x instanceof ShowCursor && y instanceof ShowCursor) {
            return Data_Ordering.EQ.value;
        };
        throw new Error("Failed pattern match at Ansi.Codes (line 40, column 1 - line 40, column 48): " + [ x.constructor.name, y.constructor.name ]);
    };
});
var colorSuffix = "m";
var colorCode = function (c) {
    if (c instanceof Black) {
        return 30;
    };
    if (c instanceof Red) {
        return 31;
    };
    if (c instanceof Green) {
        return 32;
    };
    if (c instanceof Yellow) {
        return 33;
    };
    if (c instanceof Blue) {
        return 34;
    };
    if (c instanceof Magenta) {
        return 35;
    };
    if (c instanceof Cyan) {
        return 36;
    };
    if (c instanceof White) {
        return 37;
    };
    if (c instanceof BrightBlack) {
        return 90;
    };
    if (c instanceof BrightRed) {
        return 91;
    };
    if (c instanceof BrightGreen) {
        return 92;
    };
    if (c instanceof BrightYellow) {
        return 93;
    };
    if (c instanceof BrightBlue) {
        return 94;
    };
    if (c instanceof BrightMagenta) {
        return 95;
    };
    if (c instanceof BrightCyan) {
        return 96;
    };
    if (c instanceof BrightWhite) {
        return 97;
    };
    throw new Error("Failed pattern match at Ansi.Codes (line 155, column 3 - line 171, column 22): " + [ c.constructor.name ]);
};
var codeForRenderingMode = function (m) {
    if (m instanceof Bold) {
        return 1;
    };
    if (m instanceof Dim) {
        return 2;
    };
    if (m instanceof Italic) {
        return 3;
    };
    if (m instanceof Underline) {
        return 4;
    };
    if (m instanceof Inverse) {
        return 7;
    };
    if (m instanceof Strikethrough) {
        return 9;
    };
    throw new Error("Failed pattern match at Ansi.Codes (line 123, column 3 - line 129, column 23): " + [ m.constructor.name ]);
};
var graphicsParamToString = function (gp) {
    if (gp instanceof Reset) {
        return "0";
    };
    if (gp instanceof PMode) {
        return Data_Show.show(Data_Show.showInt)(codeForRenderingMode(gp.value0));
    };
    if (gp instanceof PForeground) {
        return Data_Show.show(Data_Show.showInt)(colorCode(gp.value0));
    };
    if (gp instanceof PBackground) {
        return Data_Show.show(Data_Show.showInt)(colorCode(gp.value0) + 10 | 0);
    };
    throw new Error("Failed pattern match at Ansi.Codes (line 104, column 3 - line 108, column 45): " + [ gp.constructor.name ]);
};
var escapeCodeToString = (function () {
    var go = function (c) {
        if (c instanceof Up) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "A";
        };
        if (c instanceof Down) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "B";
        };
        if (c instanceof Forward) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "C";
        };
        if (c instanceof Back) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "D";
        };
        if (c instanceof NextLine) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "E";
        };
        if (c instanceof PreviousLine) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "F";
        };
        if (c instanceof HorizontalAbsolute) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "G";
        };
        if (c instanceof Position) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + (";" + (Data_Show.show(Data_Show.showInt)(c.value1) + "H"));
        };
        if (c instanceof EraseData) {
            return eraseParamToString(c.value0) + "J";
        };
        if (c instanceof EraseLine) {
            return eraseParamToString(c.value0) + "K";
        };
        if (c instanceof ScrollUp) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "S";
        };
        if (c instanceof ScrollDown) {
            return Data_Show.show(Data_Show.showInt)(c.value0) + "T";
        };
        if (c instanceof Graphics) {
            return Data_Foldable.intercalate(Data_List_Types.foldableNonEmptyList)(Data_Monoid.monoidString)(";")(Data_Functor.map(Data_List_Types.functorNonEmptyList)(graphicsParamToString)(c.value0)) + colorSuffix;
        };
        if (c instanceof SavePosition) {
            return "s";
        };
        if (c instanceof RestorePosition) {
            return "u";
        };
        if (c instanceof QueryPosition) {
            return "6n";
        };
        if (c instanceof HideCursor) {
            return "?25l";
        };
        if (c instanceof ShowCursor) {
            return "?25h";
        };
        throw new Error("Failed pattern match at Ansi.Codes (line 47, column 5 - line 65, column 37): " + [ c.constructor.name ]);
    };
    return function ($234) {
        return (function (v) {
            return prefix + v;
        })(go($234));
    };
})();
module.exports = {
    prefix: prefix,
    colorSuffix: colorSuffix,
    Up: Up,
    Down: Down,
    Forward: Forward,
    Back: Back,
    NextLine: NextLine,
    PreviousLine: PreviousLine,
    HorizontalAbsolute: HorizontalAbsolute,
    Position: Position,
    EraseData: EraseData,
    EraseLine: EraseLine,
    ScrollUp: ScrollUp,
    ScrollDown: ScrollDown,
    Graphics: Graphics,
    SavePosition: SavePosition,
    RestorePosition: RestorePosition,
    QueryPosition: QueryPosition,
    HideCursor: HideCursor,
    ShowCursor: ShowCursor,
    escapeCodeToString: escapeCodeToString,
    ToEnd: ToEnd,
    FromBeginning: FromBeginning,
    Entire: Entire,
    eraseParamToString: eraseParamToString,
    Reset: Reset,
    PMode: PMode,
    PForeground: PForeground,
    PBackground: PBackground,
    graphicsParamToString: graphicsParamToString,
    Bold: Bold,
    Dim: Dim,
    Italic: Italic,
    Underline: Underline,
    Inverse: Inverse,
    Strikethrough: Strikethrough,
    codeForRenderingMode: codeForRenderingMode,
    Black: Black,
    Red: Red,
    Green: Green,
    Yellow: Yellow,
    Blue: Blue,
    Magenta: Magenta,
    Cyan: Cyan,
    White: White,
    BrightBlack: BrightBlack,
    BrightRed: BrightRed,
    BrightGreen: BrightGreen,
    BrightYellow: BrightYellow,
    BrightBlue: BrightBlue,
    BrightMagenta: BrightMagenta,
    BrightCyan: BrightCyan,
    BrightWhite: BrightWhite,
    colorCode: colorCode,
    eqEscapeCode: eqEscapeCode,
    ordEscapeCode: ordEscapeCode,
    eqEraseParam: eqEraseParam,
    ordEraseParam: ordEraseParam,
    eqGraphicsParam: eqGraphicsParam,
    ordGraphicsParam: ordGraphicsParam,
    eqRenderingMode: eqRenderingMode,
    ordRenderingMode: ordRenderingMode,
    eqColor: eqColor,
    ordColor: ordColor
};