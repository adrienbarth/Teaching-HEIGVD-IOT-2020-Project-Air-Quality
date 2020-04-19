'use strict';

var utils = require('../utils/writer.js');
var Value = require('../service/ValueService');

module.exports.findLastValueBySensorID = function findLastValueBySensorID (req, res, next) {
  var sensorID = req.swagger.params['sensorID'].value;
  Value.findLastValueBySensorID(sensorID)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};

module.exports.findValuesBySensorID = function findValuesBySensorID (req, res, next) {
  var sensorID = req.swagger.params['sensorID'].value;
  Value.findValuesBySensorID(sensorID)
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
