'use strict';


/**
 * List of all devices
 *
 * returns List
 **/
exports.findDevices = function() {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = [ {
  "EUI" : "EUI",
  "name" : "name",
  "location" : "location"
}, {
  "EUI" : "EUI",
  "name" : "name",
  "location" : "location"
} ];
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

