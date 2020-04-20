<?php

require_once "Database.php";

class SensorValue
{
    private $PDO;

    public function __construct() {
        $this->PDO = new Database();
    }

    public function getSensorValues($sensorID) {
        return $this->PDO->select(
            "SELECT * FROM sensorValues WHERE fk_sensor_id = :id",
            array(
                array('id', $sensorID, PDO::PARAM_INT)
            )
        );
    }
}

