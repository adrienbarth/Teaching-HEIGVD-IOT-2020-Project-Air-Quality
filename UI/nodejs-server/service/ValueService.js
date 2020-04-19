'use strict';


/**
 * Find sensor's latest value
 *
 * sensorID Integer ID of sensor
 * returns Object
 **/
exports.findLastValueBySensorID = function(sensorID) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = "";
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}


/**
 * Find sensor's values
 *
 * sensorID Integer ID of sensor
 * returns List
 **/
exports.findValuesBySensorID = function(sensorID) {
  return new Promise(function(resolve, reject) {
    var examples = {};
    examples['application/json'] = [ {
  "date" : "date",
  "payload" : 6.02745618307040320615897144307382404804229736328125,
  "sensor" : {
    "name" : "name",
    "id" : 0,
    "device" : {
      "EUI" : "EUI",
      "name" : "name",
      "location" : "location"
    }
  },
  "id" : 0
}, {
  "date" : "date",
  "payload" : 6.02745618307040320615897144307382404804229736328125,
  "sensor" : {
    "name" : "name",
    "id" : 0,
    "device" : {
      "EUI" : "EUI",
      "name" : "name",
      "location" : "location"
    }
  },
  "id" : 0
} ];
    if (Object.keys(examples).length > 0) {
      resolve(examples[Object.keys(examples)[0]]);
    } else {
      resolve();
    }
  });
}

