'use strict';

module.exports.hello = async (event, context) => {
  // return {
  //   statusCode: 200,
  //   body: JSON.stringify({
  //     message: 'Go Serverless v2.0! Your function executed successfully!',
  //     input: event,
  //   }),
  // };

  return {
    statusCode: 200,
    headers: {
      "x-custom-header": "My Header Value"
    },
    body: JSON.stringify({ "message": "Hello World!" })
  };



  // Use this code if you don't use the http event with the LAMBDA-PROXY integration
  // return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
