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

    public function getAllSensorValues() {
        $query = "SELECT * FROM sensorValues
                    INNER JOIN sensors s on sensorValues.fk_sensor_id = s.id
                    INNER JOIN devices d on s.fk_device_EUI = d.EUI
                    ORDER BY date DESC";

        return $this->PDO->select($query);
    }
}

