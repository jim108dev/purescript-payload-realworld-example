// Generated by purs version 0.13.8
"use strict";
var Control_Applicative = require("../Control.Applicative/index.js");
var Control_Apply = require("../Control.Apply/index.js");
var Control_Semigroupoid = require("../Control.Semigroupoid/index.js");
var Data_Bifoldable = require("../Data.Bifoldable/index.js");
var Data_Bifunctor = require("../Data.Bifunctor/index.js");
var Data_Bitraversable = require("../Data.Bitraversable/index.js");
var Data_Eq = require("../Data.Eq/index.js");
var Data_Foldable = require("../Data.Foldable/index.js");
var Data_FoldableWithIndex = require("../Data.FoldableWithIndex/index.js");
var Data_Functor = require("../Data.Functor/index.js");
var Data_Functor_Contravariant = require("../Data.Functor.Contravariant/index.js");
var Data_Functor_Invariant = require("../Data.Functor.Invariant/index.js");
var Data_FunctorWithIndex = require("../Data.FunctorWithIndex/index.js");
var Data_Monoid = require("../Data.Monoid/index.js");
var Data_Newtype = require("../Data.Newtype/index.js");
var Data_Ord = require("../Data.Ord/index.js");
var Data_Semigroup = require("../Data.Semigroup/index.js");
var Data_Show = require("../Data.Show/index.js");
var Data_Traversable = require("../Data.Traversable/index.js");
var Data_TraversableWithIndex = require("../Data.TraversableWithIndex/index.js");
var Const = function (x) {
    return x;
};
var showConst = function (dictShow) {
    return new Data_Show.Show(function (v) {
        return "(Const " + (Data_Show.show(dictShow)(v) + ")");
    });
};
var semiringConst = function (dictSemiring) {
    return dictSemiring;
};
var semigroupoidConst = new Control_Semigroupoid.Semigroupoid(function (v) {
    return function (v1) {
        return v1;
    };
});
var semigroupConst = function (dictSemigroup) {
    return dictSemigroup;
};
var ringConst = function (dictRing) {
    return dictRing;
};
var ordConst = function (dictOrd) {
    return dictOrd;
};
var newtypeConst = new Data_Newtype.Newtype(function (n) {
    return n;
}, Const);
var monoidConst = function (dictMonoid) {
    return dictMonoid;
};
var heytingAlgebraConst = function (dictHeytingAlgebra) {
    return dictHeytingAlgebra;
};
var functorConst = new Data_Functor.Functor(function (f) {
    return function (m) {
        return m;
    };
});
var functorWithIndexConst = new Data_FunctorWithIndex.FunctorWithIndex(function () {
    return functorConst;
}, function (v) {
    return function (v1) {
        return v1;
    };
});
var invariantConst = new Data_Functor_Invariant.Invariant(Data_Functor_Invariant.imapF(functorConst));
var foldableConst = new Data_Foldable.Foldable(function (dictMonoid) {
    return function (v) {
        return function (v1) {
            return Data_Monoid.mempty(dictMonoid);
        };
    };
}, function (v) {
    return function (z) {
        return function (v1) {
            return z;
        };
    };
}, function (v) {
    return function (z) {
        return function (v1) {
            return z;
        };
    };
});
var foldableWithIndexConst = new Data_FoldableWithIndex.FoldableWithIndex(function () {
    return foldableConst;
}, function (dictMonoid) {
    return function (v) {
        return function (v1) {
            return Data_Monoid.mempty(dictMonoid);
        };
    };
}, function (v) {
    return function (z) {
        return function (v1) {
            return z;
        };
    };
}, function (v) {
    return function (z) {
        return function (v1) {
            return z;
        };
    };
});
var traversableConst = new Data_Traversable.Traversable(function () {
    return foldableConst;
}, function () {
    return functorConst;
}, function (dictApplicative) {
    return function (v) {
        return Control_Applicative.pure(dictApplicative)(v);
    };
}, function (dictApplicative) {
    return function (v) {
        return function (v1) {
            return Control_Applicative.pure(dictApplicative)(v1);
        };
    };
});
var traversableWithIndexConst = new Data_TraversableWithIndex.TraversableWithIndex(function () {
    return foldableWithIndexConst;
}, function () {
    return functorWithIndexConst;
}, function () {
    return traversableConst;
}, function (dictApplicative) {
    return function (v) {
        return function (v1) {
            return Control_Applicative.pure(dictApplicative)(v1);
        };
    };
});
var euclideanRingConst = function (dictEuclideanRing) {
    return dictEuclideanRing;
};
var eqConst = function (dictEq) {
    return dictEq;
};
var eq1Const = function (dictEq) {
    return new Data_Eq.Eq1(function (dictEq1) {
        return Data_Eq.eq(eqConst(dictEq));
    });
};
var ord1Const = function (dictOrd) {
    return new Data_Ord.Ord1(function () {
        return eq1Const(dictOrd.Eq0());
    }, function (dictOrd1) {
        return Data_Ord.compare(ordConst(dictOrd));
    });
};
var contravariantConst = new Data_Functor_Contravariant.Contravariant(function (v) {
    return function (v1) {
        return v1;
    };
});
var commutativeRingConst = function (dictCommutativeRing) {
    return dictCommutativeRing;
};
var boundedConst = function (dictBounded) {
    return dictBounded;
};
var booleanAlgebraConst = function (dictBooleanAlgebra) {
    return dictBooleanAlgebra;
};
var bifunctorConst = new Data_Bifunctor.Bifunctor(function (f) {
    return function (v) {
        return function (v1) {
            return f(v1);
        };
    };
});
var bifoldableConst = new Data_Bifoldable.Bifoldable(function (dictMonoid) {
    return function (f) {
        return function (v) {
            return function (v1) {
                return f(v1);
            };
        };
    };
}, function (f) {
    return function (v) {
        return function (z) {
            return function (v1) {
                return f(z)(v1);
            };
        };
    };
}, function (f) {
    return function (v) {
        return function (z) {
            return function (v1) {
                return f(v1)(z);
            };
        };
    };
});
var bitraversableConst = new Data_Bitraversable.Bitraversable(function () {
    return bifoldableConst;
}, function () {
    return bifunctorConst;
}, function (dictApplicative) {
    return function (v) {
        return Data_Functor.map((dictApplicative.Apply0()).Functor0())(Const)(v);
    };
}, function (dictApplicative) {
    return function (f) {
        return function (v) {
            return function (v1) {
                return Data_Functor.map((dictApplicative.Apply0()).Functor0())(Const)(f(v1));
            };
        };
    };
});
var applyConst = function (dictSemigroup) {
    return new Control_Apply.Apply(function () {
        return functorConst;
    }, function (v) {
        return function (v1) {
            return Data_Semigroup.append(dictSemigroup)(v)(v1);
        };
    });
};
var applicativeConst = function (dictMonoid) {
    return new Control_Applicative.Applicative(function () {
        return applyConst(dictMonoid.Semigroup0());
    }, function (v) {
        return Data_Monoid.mempty(dictMonoid);
    });
};
module.exports = {
    Const: Const,
    newtypeConst: newtypeConst,
    eqConst: eqConst,
    eq1Const: eq1Const,
    ordConst: ordConst,
    ord1Const: ord1Const,
    boundedConst: boundedConst,
    showConst: showConst,
    semigroupoidConst: semigroupoidConst,
    semigroupConst: semigroupConst,
    monoidConst: monoidConst,
    semiringConst: semiringConst,
    ringConst: ringConst,
    euclideanRingConst: euclideanRingConst,
    commutativeRingConst: commutativeRingConst,
    heytingAlgebraConst: heytingAlgebraConst,
    booleanAlgebraConst: booleanAlgebraConst,
    functorConst: functorConst,
    bifunctorConst: bifunctorConst,
    functorWithIndexConst: functorWithIndexConst,
    invariantConst: invariantConst,
    contravariantConst: contravariantConst,
    applyConst: applyConst,
    applicativeConst: applicativeConst,
    foldableConst: foldableConst,
    foldableWithIndexConst: foldableWithIndexConst,
    bifoldableConst: bifoldableConst,
    traversableConst: traversableConst,
    traversableWithIndexConst: traversableWithIndexConst,
    bitraversableConst: bitraversableConst
};