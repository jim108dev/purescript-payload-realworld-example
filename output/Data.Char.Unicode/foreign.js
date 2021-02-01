exports.withCharCode = function(f) {
    return function (c) {
        return String.fromCharCode(f(c.charCodeAt()));
    }
}
