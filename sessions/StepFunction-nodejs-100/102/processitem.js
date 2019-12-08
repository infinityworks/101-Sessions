'use strict';

module.exports.handler = (event, context, callback) => {

  console.log(JSON.stringify(event));
  console.log(JSON.stringify(context));

  var result = {
    ID : event.item.id,
    Name : event.item.name,
    Quantity : event.item.quantity
  };
  callback(null, "Processing Item " + event.platform + " " + event.ordernumber + " " + result.ID + " " + result.Name + " " + result.Quantity);

};