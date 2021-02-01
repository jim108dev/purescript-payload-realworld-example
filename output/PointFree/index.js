// Generated by purs version 0.13.8
"use strict";
var composeThirdFlipped = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return function (z) {
                    return g(x)(y)(f(z));
                };
            };
        };
    };
};
var composeThird = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return function (z) {
                    return f(x)(y)(g(z));
                };
            };
        };
    };
};
var composeSecondFlipped = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return g(x)(f(y));
            };
        };
    };
};
var composeSecond = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return f(x)(g(y));
            };
        };
    };
};
var composeFourthFlipped = function (f) {
    return function (g) {
        return function (w) {
            return function (x) {
                return function (y) {
                    return function (z) {
                        return g(w)(x)(y)(f(z));
                    };
                };
            };
        };
    };
};
var composeFourth = function (f) {
    return function (g) {
        return function (w) {
            return function (x) {
                return function (y) {
                    return function (z) {
                        return f(w)(x)(y)(g(z));
                    };
                };
            };
        };
    };
};
var compose4Flipped = function (f) {
    return function (g) {
        return function (w) {
            return function (x) {
                return function (y) {
                    return function (z) {
                        return g(f(w)(x)(y)(z));
                    };
                };
            };
        };
    };
};
var compose4 = function (f) {
    return function (g) {
        return function (w) {
            return function (x) {
                return function (y) {
                    return function (z) {
                        return f(g(w)(x)(y)(z));
                    };
                };
            };
        };
    };
};
var compose3SecondFlipped = function (f) {
    return function (g) {
        return function (w) {
            return function (x) {
                return function (y) {
                    return function (z) {
                        return g(w)(f(x)(y)(z));
                    };
                };
            };
        };
    };
};
var compose3Second = function (f) {
    return function (g) {
        return function (w) {
            return function (x) {
                return function (y) {
                    return function (z) {
                        return f(w)(g(x)(y)(z));
                    };
                };
            };
        };
    };
};
var compose3Flipped = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return function (z) {
                    return g(f(x)(y)(z));
                };
            };
        };
    };
};
var compose3 = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return function (z) {
                    return f(g(x)(y)(z));
                };
            };
        };
    };
};
var compose2ThirdFlipped = function (f) {
    return function (g) {
        return function (w) {
            return function (x) {
                return function (y) {
                    return function (z) {
                        return g(w)(x)(f(y)(z));
                    };
                };
            };
        };
    };
};
var compose2Third = function (f) {
    return function (g) {
        return function (w) {
            return function (x) {
                return function (y) {
                    return function (z) {
                        return f(w)(x)(g(y)(z));
                    };
                };
            };
        };
    };
};
var compose2SecondFlipped = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return function (z) {
                    return g(x)(f(y)(z));
                };
            };
        };
    };
};
var compose2Second = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return function (z) {
                    return f(x)(g(y)(z));
                };
            };
        };
    };
};
var compose2Flipped = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return g(f(x)(y));
            };
        };
    };
};
var compose2 = function (f) {
    return function (g) {
        return function (x) {
            return function (y) {
                return f(g(x)(y));
            };
        };
    };
};
var applyThirdFlipped = function (x) {
    return function (f) {
        return function (y) {
            return function (z) {
                return f(y)(z)(x);
            };
        };
    };
};
var applyThird = function (f) {
    return function (x) {
        return function (y) {
            return function (z) {
                return f(y)(z)(x);
            };
        };
    };
};
var applySecondFlipped = function (x) {
    return function (f) {
        return function (y) {
            return f(y)(x);
        };
    };
};
var applySecond = function (f) {
    return function (x) {
        return function (y) {
            return f(y)(x);
        };
    };
};
var applyFourthFlipped = function (w) {
    return function (f) {
        return function (x) {
            return function (y) {
                return function (z) {
                    return f(x)(y)(z)(w);
                };
            };
        };
    };
};
var applyFourth = function (f) {
    return function (w) {
        return function (x) {
            return function (y) {
                return function (z) {
                    return f(x)(y)(z)(w);
                };
            };
        };
    };
};
module.exports = {
    compose2: compose2,
    compose2Flipped: compose2Flipped,
    compose3: compose3,
    compose3Flipped: compose3Flipped,
    compose4: compose4,
    compose4Flipped: compose4Flipped,
    composeSecond: composeSecond,
    composeSecondFlipped: composeSecondFlipped,
    composeThird: composeThird,
    composeThirdFlipped: composeThirdFlipped,
    composeFourth: composeFourth,
    composeFourthFlipped: composeFourthFlipped,
    compose2Second: compose2Second,
    compose2SecondFlipped: compose2SecondFlipped,
    compose2Third: compose2Third,
    compose2ThirdFlipped: compose2ThirdFlipped,
    compose3Second: compose3Second,
    compose3SecondFlipped: compose3SecondFlipped,
    applySecond: applySecond,
    applySecondFlipped: applySecondFlipped,
    applyThird: applyThird,
    applyThirdFlipped: applyThirdFlipped,
    applyFourth: applyFourth,
    applyFourthFlipped: applyFourthFlipped
};
