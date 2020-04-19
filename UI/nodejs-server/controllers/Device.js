'use strict';

var utils = require('../utils/writer.js');
var Device = require('../service/DeviceService');

module.exports.findDevices = function findDevices (req, res, next) {
  Device.findDevices()
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
