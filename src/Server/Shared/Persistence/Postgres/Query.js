
var pg = require('pg');

exports.ffiQuery = function (postProcessor) {
  return function (queryStr) {
    return function (params) {
      return function (client) {
        return function (error, success) {
          client.query(queryStr, params, function (err, result) {
            if (err) {
              var pgError = postProcessor.nullableLeft(err);
              if (pgError) {
                return success(pgError);
              } else {
                return error(err);
              }
            }
            success(postProcessor.right(result.rows));
          });
          return function (cancelError, onCancelerError, onCancelerSuccess) {
            onCancelerSuccess();
          };
        };
      };
    };
  };
}

exports.ffiQuery_ = function (postProcessor) {
  return function (queryStr) {
    return function (client) {
      return function (error, success) {
        client.query(queryStr, function (err, result) {
          if (err) {
            var pgError = postProcessor.nullableLeft(err);
            if (pgError) {
              return success(pgError);
            } else {
              return error(err);
            }
          }
          success(postProcessor.right(result.rows));
        });
        return function (cancelError, onCancelerError, onCancelerSuccess) {
          onCancelerSuccess();
        };
      };
    };
  };
}

exports.ffiSQLState = function (error) {
  return error.code || null;
};

exports.ffiErrorDetail = function (error) {
  return {
    severity: error.severity || '',
    code: error.code || '',
    message: error.message || '',
    detail: error.detail || '',
    hint: error.hint || '',
    position: error.position || '',
    internalPosition: error.internalPosition || '',
    internalQuery: error.internalQuery || '',
    where_: error.where || '',
    schema: error.schema || '',
    table: error.table || '',
    column: error.column || '',
    dataType: error.dataType || '',
    constraint: error.constraint || '',
    file: error.file || '',
    line: error.line || '',
    routine: error.routine || ''
  };
};
