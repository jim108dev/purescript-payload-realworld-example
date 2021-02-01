// Generated by purs version 0.13.8
"use strict";
var Control_Alt = require("../Control.Alt/index.js");
var Control_Alternative = require("../Control.Alternative/index.js");
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Apply = require("../Control.Apply/index.js");
var Control_Bind = require("../Control.Bind/index.js");
var Control_Monad = require("../Control.Monad/index.js");
var Control_Monad_Error_Class = require("../Control.Monad.Error.Class/index.js");
var Control_Monad_Except_Trans = require("../Control.Monad.Except.Trans/index.js");
var Control_Monad_Trans_Class = require("../Control.Monad.Trans.Class/index.js");
var Control_MonadPlus = require("../Control.MonadPlus/index.js");
var Control_MonadZero = require("../Control.MonadZero/index.js");
var Control_Plus = require("../Control.Plus/index.js");
var Data_Either = require("../Data.Either/index.js");
var Data_Function = require("../Data.Function/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_Monoid = require("../Data.Monoid/index.js");
var Data_Semigroup = require("../Data.Semigroup/index.js");
var Effect_Class = require("../Effect.Class/index.js");
var ExceptRT = function (x) {
    return x;
};
var EitherR = function (x) {
    return x;
};
var succeedT = function (dictMonad) {
    return function (r) {
        return Control_Applicative.pure(Control_Monad_Except_Trans.applicativeExceptT(dictMonad))(r);
    };
};
var succeed = function (r) {
    return Control_Applicative.pure(Data_Either.applicativeEither)(r);
};
var runExceptRT = function (v) {
    return v;
};
var runEitherR = function (v) {
    return v;
};
var monadTrans = new Control_Monad_Trans_Class.MonadTrans(function (dictMonad) {
    return function ($56) {
        return ExceptRT(Control_Monad_Except_Trans.ExceptT((function (v) {
            return Data_Functor.map(((dictMonad.Bind1()).Apply0()).Functor0())(Data_Either.Left.create)(v);
        })($56)));
    };
});
var flipEither = function (e) {
    if (e instanceof Data_Either.Left) {
        return new Data_Either.Right(e.value0);
    };
    if (e instanceof Data_Either.Right) {
        return new Data_Either.Left(e.value0);
    };
    throw new Error("Failed pattern match at Data.EitherR (line 126, column 16 - line 128, column 22): " + [ e.constructor.name ]);
};
var flipET = function (dictMonad) {
    var $57 = Control_Monad.liftM1(dictMonad)(flipEither);
    return function ($58) {
        return Control_Monad_Except_Trans.ExceptT($57(Control_Monad_Except_Trans.runExceptT($58)));
    };
};
var monadExceptRT = function (dictMonad) {
    return new Control_Monad.Monad(function () {
        return applicativeExceptRT(dictMonad);
    }, function () {
        return bindExceptRT(dictMonad);
    });
};
var functorExceptRT = function (dictMonad) {
    return new Data_Functor.Functor(Control_Monad.liftM1(monadExceptRT(dictMonad)));
};
var bindExceptRT = function (dictMonad) {
    return new Control_Bind.Bind(function () {
        return applyExceptRT(dictMonad);
    }, function (m) {
        return function (f) {
            return ExceptRT(Control_Monad_Except_Trans.ExceptT(Control_Bind.bind(dictMonad.Bind1())(Control_Monad_Except_Trans.runExceptT(runExceptRT(m)))(function (e) {
                if (e instanceof Data_Either.Left) {
                    return Control_Monad_Except_Trans.runExceptT(runExceptRT(f(e.value0)));
                };
                if (e instanceof Data_Either.Right) {
                    return Control_Applicative.pure(dictMonad.Applicative0())(new Data_Either.Right(e.value0));
                };
                throw new Error("Failed pattern match at Data.EitherR (line 148, column 5 - line 150, column 32): " + [ e.constructor.name ]);
            })));
        };
    });
};
var applyExceptRT = function (dictMonad) {
    return new Control_Apply.Apply(function () {
        return functorExceptRT(dictMonad);
    }, Control_Monad.ap(monadExceptRT(dictMonad)));
};
var applicativeExceptRT = function (dictMonad) {
    return new Control_Applicative.Applicative(function () {
        return applyExceptRT(dictMonad);
    }, function (e) {
        return Control_Monad_Error_Class.throwError(Control_Monad_Except_Trans.monadThrowExceptT(dictMonad))(e);
    });
};
var fmapLT = function (dictMonad) {
    return function (f) {
        var $59 = Control_Monad.liftM1(monadExceptRT(dictMonad))(f);
        return function ($60) {
            return runExceptRT($59(ExceptRT($60)));
        };
    };
};
var monadEffExceptRT = function (dictMonadEffect) {
    return new Effect_Class.MonadEffect(function () {
        return monadExceptRT(dictMonadEffect.Monad0());
    }, (function () {
        var $61 = Control_Monad_Trans_Class.lift(monadTrans)(dictMonadEffect.Monad0());
        var $62 = Effect_Class.liftEffect(dictMonadEffect);
        return function ($63) {
            return $61($62($63));
        };
    })());
};
var monadEitherR = new Control_Monad.Monad(function () {
    return applicativeEitherR;
}, function () {
    return bindEitherR;
});
var functorEitherR = new Data_Functor.Functor(Control_Monad.liftM1(monadEitherR));
var bindEitherR = new Control_Bind.Bind(function () {
    return applyEitherR;
}, function (v) {
    return function (f) {
        if (v instanceof Data_Either.Left) {
            return f(v.value0);
        };
        if (v instanceof Data_Either.Right) {
            return new Data_Either.Right(v.value0);
        };
        throw new Error("Failed pattern match at Data.EitherR (line 83, column 5 - line 85, column 35): " + [ v.constructor.name ]);
    };
});
var applyEitherR = new Control_Apply.Apply(function () {
    return functorEitherR;
}, Control_Monad.ap(monadEitherR));
var applicativeEitherR = new Control_Applicative.Applicative(function () {
    return applyEitherR;
}, function (e) {
    return new Data_Either.Left(e);
});
var catchEither = function (e) {
    return function (f) {
        return runEitherR(Control_Bind.bind(bindEitherR)(e)(function ($64) {
            return EitherR(f($64));
        }));
    };
};
var handleEither = Data_Function.flip(catchEither);
var fmapL = function (f) {
    return function (e) {
        return runEitherR(Data_Functor.map(functorEitherR)(f)(e));
    };
};
var throwEither = function (e) {
    return runEitherR(Control_Applicative.pure(applicativeEitherR)(e));
};
var altExceptRT = function (dictMonoid) {
    return function (dictMonad) {
        return new Control_Alt.Alt(function () {
            return functorExceptRT(dictMonad);
        }, function (e1) {
            return function (e2) {
                return ExceptRT(Control_Monad_Except_Trans.ExceptT(Control_Bind.bind(dictMonad.Bind1())(Control_Monad_Except_Trans.runExceptT(runExceptRT(e1)))(function (e1$prime) {
                    if (e1$prime instanceof Data_Either.Left) {
                        return Control_Applicative.pure(dictMonad.Applicative0())(e1$prime);
                    };
                    if (e1$prime instanceof Data_Either.Right) {
                        return Control_Bind.bind(dictMonad.Bind1())(Control_Monad_Except_Trans.runExceptT(runExceptRT(e2)))(function (e2$prime) {
                            if (e2$prime instanceof Data_Either.Left) {
                                return Control_Applicative.pure(dictMonad.Applicative0())(e2$prime);
                            };
                            if (e2$prime instanceof Data_Either.Right) {
                                return Control_Applicative.pure(dictMonad.Applicative0())(new Data_Either.Right(Data_Semigroup.append(dictMonoid.Semigroup0())(e1$prime.value0)(e2$prime.value0)));
                            };
                            throw new Error("Failed pattern match at Data.EitherR (line 161, column 9 - line 163, column 46): " + [ e2$prime.constructor.name ]);
                        });
                    };
                    throw new Error("Failed pattern match at Data.EitherR (line 157, column 5 - line 163, column 46): " + [ e1$prime.constructor.name ]);
                })));
            };
        });
    };
};
var plusExceptRT = function (dictMonoid) {
    return function (dictMonad) {
        return new Control_Plus.Plus(function () {
            return altExceptRT(dictMonoid)(dictMonad);
        }, ExceptRT(Control_Applicative.pure(Control_Monad_Except_Trans.applicativeExceptT(dictMonad))(Data_Monoid.mempty(dictMonoid))));
    };
};
var alternativeExceptRT = function (dictMonoid) {
    return function (dictMonad) {
        return new Control_Alternative.Alternative(function () {
            return applicativeExceptRT(dictMonad);
        }, function () {
            return plusExceptRT(dictMonoid)(dictMonad);
        });
    };
};
var monadZeroExceptRT = function (dictMonoid) {
    return function (dictMonad) {
        return new Control_MonadZero.MonadZero(function () {
            return alternativeExceptRT(dictMonoid)(dictMonad);
        }, function () {
            return monadExceptRT(dictMonad);
        });
    };
};
var monadPlusExceptRT = function (dictMonoid) {
    return function (dictMonad) {
        return new Control_MonadPlus.MonadPlus(function () {
            return monadZeroExceptRT(dictMonoid)(dictMonad);
        });
    };
};
var altEitherR = function (dictMonoid) {
    return new Control_Alt.Alt(function () {
        return functorEitherR;
    }, function (v) {
        return function (v1) {
            if (v instanceof Data_Either.Left) {
                return v;
            };
            if (v1 instanceof Data_Either.Left) {
                return v1;
            };
            if (v instanceof Data_Either.Right && v1 instanceof Data_Either.Right) {
                return new Data_Either.Right(Data_Semigroup.append(dictMonoid.Semigroup0())(v.value0)(v1.value0));
            };
            throw new Error("Failed pattern match at Data.EitherR (line 89, column 1 - line 93, column 31): " + [ v.constructor.name, v1.constructor.name ]);
        };
    });
};
var plusEitherR = function (dictMonoid) {
    return new Control_Plus.Plus(function () {
        return altEitherR(dictMonoid);
    }, new Data_Either.Right(Data_Monoid.mempty(dictMonoid)));
};
var alternativeEitherR = function (dictMonoid) {
    return new Control_Alternative.Alternative(function () {
        return applicativeEitherR;
    }, function () {
        return plusEitherR(dictMonoid);
    });
};
var monadZeroEitherR = function (dictMonoid) {
    return new Control_MonadZero.MonadZero(function () {
        return alternativeEitherR(dictMonoid);
    }, function () {
        return monadEitherR;
    });
};
var monadPlusEitherR = function (dictMonoid) {
    return new Control_MonadPlus.MonadPlus(function () {
        return monadZeroEitherR(dictMonoid);
    });
};
module.exports = {
    EitherR: EitherR,
    runEitherR: runEitherR,
    succeed: succeed,
    throwEither: throwEither,
    catchEither: catchEither,
    handleEither: handleEither,
    fmapL: fmapL,
    flipEither: flipEither,
    ExceptRT: ExceptRT,
    runExceptRT: runExceptRT,
    succeedT: succeedT,
    fmapLT: fmapLT,
    flipET: flipET,
    functorEitherR: functorEitherR,
    applyEitherR: applyEitherR,
    applicativeEitherR: applicativeEitherR,
    bindEitherR: bindEitherR,
    monadEitherR: monadEitherR,
    altEitherR: altEitherR,
    plusEitherR: plusEitherR,
    alternativeEitherR: alternativeEitherR,
    monadZeroEitherR: monadZeroEitherR,
    monadPlusEitherR: monadPlusEitherR,
    functorExceptRT: functorExceptRT,
    applyExceptRT: applyExceptRT,
    applicativeExceptRT: applicativeExceptRT,
    bindExceptRT: bindExceptRT,
    monadExceptRT: monadExceptRT,
    altExceptRT: altExceptRT,
    plusExceptRT: plusExceptRT,
    alternativeExceptRT: alternativeExceptRT,
    monadZeroExceptRT: monadZeroExceptRT,
    monadPlusExceptRT: monadPlusExceptRT,
    monadTrans: monadTrans,
    monadEffExceptRT: monadEffExceptRT
};