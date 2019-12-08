'use strict';

module.exports.handler = (event, context, callback) => {

  var comment = event.Comment;

  console.log(JSON.stringify(event));
  console.log(JSON.stringify(context));

  var result = {
    token : event.token,
    memory : context.memoryLimitInMB,
    functionName : context.functionName,
    invokeId : context.invokeid
  };
  callback(null, result);

};
