'use strict';

module.exports.handler = (event, context, callback) => {

  function CustomError(message) {
    this.name = 'CustomError';
    this.message = message;
  }
  CustomError.prototype = new Error();

  var min = 1;
  var max = 100;    
  var randomNumber = Math.floor(Math.random() * (max - min + 1)) + min;

  console.log("generatedRandom : " + randomNumber);

  if (randomNumber < 51) {
    callback(new CustomError('bad stuff happened...'));
  }
  if (randomNumber < 91) {
    callback(new Error('something went wrong'));
  }
  callback(null, "Super Happy Success");

};