'use strict';

module.exports.hello = async (event, context) => {


  console.log(event)

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
