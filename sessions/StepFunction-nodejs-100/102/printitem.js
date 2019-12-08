'use strict';

module.exports.handler = (event, context, callback) => {

  console.log(JSON.stringify(event));
  console.log(JSON.stringify(context));

  var result = {
    ID : event.id,
    Name : event.name,
    Quantity : event.quantity
  };
  callback(null, "Processing Item " + result.ID + " " + result.Name + " " + result.Quantity);

};