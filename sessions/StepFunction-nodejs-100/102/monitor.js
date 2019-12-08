'use strict';

module.exports.handler = (event, context, callback) => {

  console.log(JSON.stringify(event));
  console.log(JSON.stringify(context));

  callback(null, event.Detail);

};
