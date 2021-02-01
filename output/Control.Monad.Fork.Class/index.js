// Generated by purs version 0.13.8
"use strict";
var Control_Monad_Reader_Trans = require("../Control.Monad.Reader.Trans/index.js");
var Control_Monad_Trans_Class = require("../Control.Monad.Trans.Class/index.js");
var Effect_Aff = require("../Effect.Aff/index.js");
var Completed = (function () {
    function Completed(value0) {
        this.value0 = value0;
    };
    Completed.create = function (value0) {
        return new Completed(value0);
    };
    return Completed;
})();
var Failed = (function () {
    function Failed(value0) {
        this.value0 = value0;
    };
    Failed.create = function (value0) {
        return new Failed(value0);
    };
    return Failed;
})();
var Killed = (function () {
    function Killed(value0) {
        this.value0 = value0;
    };
    Killed.create = function (value0) {
        return new Killed(value0);
    };
    return Killed;
})();
var MonadFork = function (Functor1, Monad0, fork, join, suspend) {
    this.Functor1 = Functor1;
    this.Monad0 = Monad0;
    this.fork = fork;
    this.join = join;
    this.suspend = suspend;
};
var MonadKill = function (MonadFork0, MonadThrow1, kill) {
    this.MonadFork0 = MonadFork0;
    this.MonadThrow1 = MonadThrow1;
    this.kill = kill;
};
var MonadBracket = function (MonadError1, MonadKill0, bracket, never, uninterruptible) {
    this.MonadError1 = MonadError1;
    this.MonadKill0 = MonadKill0;
    this.bracket = bracket;
    this.never = never;
    this.uninterruptible = uninterruptible;
};
var uninterruptible = function (dict) {
    return dict.uninterruptible;
};
var suspend = function (dict) {
    return dict.suspend;
};
var never = function (dict) {
    return dict.never;
};
var monadForkAff = new MonadFork(function () {
    return Effect_Aff.functorFiber;
}, function () {
    return Effect_Aff.monadAff;
}, Effect_Aff.forkAff, Effect_Aff.joinFiber, Effect_Aff.suspendAff);
var monadKillAff = new MonadKill(function () {
    return monadForkAff;
}, function () {
    return Effect_Aff.monadThrowAff;
}, Effect_Aff.killFiber);
var monadBracketAff = new MonadBracket(function () {
    return Effect_Aff.monadErrorAff;
}, function () {
    return monadKillAff;
}, function (acquire) {
    return function (release) {
        return function (run) {
            return Effect_Aff.generalBracket(acquire)({
                completed: function ($11) {
                    return release(Completed.create($11));
                },
                failed: function ($12) {
                    return release(Failed.create($12));
                },
                killed: function ($13) {
                    return release(Killed.create($13));
                }
            })(run);
        };
    };
}, Effect_Aff.never, Effect_Aff.invincible);
var kill = function (dict) {
    return dict.kill;
};
var join = function (dict) {
    return dict.join;
};
var fork = function (dict) {
    return dict.fork;
};
var monadForkReaderT = function (dictMonadFork) {
    return new MonadFork(dictMonadFork.Functor1, function () {
        return Control_Monad_Reader_Trans.monadReaderT(dictMonadFork.Monad0());
    }, function (v) {
        var $14 = fork(dictMonadFork);
        return function ($15) {
            return $14(v($15));
        };
    }, (function () {
        var $16 = Control_Monad_Trans_Class.lift(Control_Monad_Reader_Trans.monadTransReaderT)(dictMonadFork.Monad0());
        var $17 = join(dictMonadFork);
        return function ($18) {
            return $16($17($18));
        };
    })(), function (v) {
        var $19 = suspend(dictMonadFork);
        return function ($20) {
            return $19(v($20));
        };
    });
};
var monadKillReaderT = function (dictMonadKill) {
    return new MonadKill(function () {
        return monadForkReaderT(dictMonadKill.MonadFork0());
    }, function () {
        return Control_Monad_Reader_Trans.monadThrowReaderT(dictMonadKill.MonadThrow1());
    }, function (e) {
        var $21 = Control_Monad_Trans_Class.lift(Control_Monad_Reader_Trans.monadTransReaderT)((dictMonadKill.MonadThrow1()).Monad0());
        var $22 = kill(dictMonadKill)(e);
        return function ($23) {
            return $21($22($23));
        };
    });
};
var bracket = function (dict) {
    return dict.bracket;
};
var monadBracketReaderT = function (dictMonadBracket) {
    return new MonadBracket(function () {
        return Control_Monad_Reader_Trans.monadErrorReaderT(dictMonadBracket.MonadError1());
    }, function () {
        return monadKillReaderT(dictMonadBracket.MonadKill0());
    }, function (v) {
        return function (release) {
            return function (run) {
                return function (r) {
                    return bracket(dictMonadBracket)(v(r))(function (c) {
                        return function (a) {
                            return Control_Monad_Reader_Trans.runReaderT(release(c)(a))(r);
                        };
                    })(function (a) {
                        return Control_Monad_Reader_Trans.runReaderT(run(a))(r);
                    });
                };
            };
        };
    }, Control_Monad_Trans_Class.lift(Control_Monad_Reader_Trans.monadTransReaderT)(((dictMonadBracket.MonadError1()).MonadThrow0()).Monad0())(never(dictMonadBracket)), function (k) {
        return function (r) {
            return uninterruptible(dictMonadBracket)(Control_Monad_Reader_Trans.runReaderT(k)(r));
        };
    });
};
module.exports = {
    bracket: bracket,
    fork: fork,
    join: join,
    kill: kill,
    never: never,
    suspend: suspend,
    uninterruptible: uninterruptible,
    MonadFork: MonadFork,
    MonadKill: MonadKill,
    Completed: Completed,
    Failed: Failed,
    Killed: Killed,
    MonadBracket: MonadBracket,
    monadForkAff: monadForkAff,
    monadForkReaderT: monadForkReaderT,
    monadKillAff: monadKillAff,
    monadKillReaderT: monadKillReaderT,
    monadBracketAff: monadBracketAff,
    monadBracketReaderT: monadBracketReaderT
};
