'use strict';


/**
 * Find sensors by device's EUI
 *
 * deviceEUI String EUI of device
 * returns List
 **/
exports.findSensorsByDeviceEUI = function(deviceEUI) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = [ {
  "name" : "name",
  "id" : 0,
  "device" : {
    "EUI" : "EUI",
    "name" : "name",
    "location" : "location"
  }
}, {
  "name" : "name",
  "id" : 0,
  "device" : {
    "EUI" : "EUI",
    "name" : "name",
    "location" : "location"
  }
} ];
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

