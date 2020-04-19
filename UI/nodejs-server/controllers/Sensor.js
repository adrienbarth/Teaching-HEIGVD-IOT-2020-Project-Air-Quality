'use strict';

var utils = require('../utils/writer.js');
var Sensor = require('../service/SensorService');

module.exports.findSensorsByDeviceEUI = function findSensorsByDeviceEUI (req, res, next) {
  var deviceEUI = req.swagger.params['deviceEUI'].value;
  Sensor.findSensorsByDeviceEUI(deviceEUI)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
