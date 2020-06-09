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
            "SELECT * FROM sensor_values WHERE fk_data_type_xml_id = :id",
            array(
                array('id', $sensorID, PDO::PARAM_INT)
            )
        );
    }

    public function getAllSensorValues() {
        $query = "SELECT * FROM sensor_values
                    INNER JOIN data_types dt on sensor_values.fk_data_type_xml_id = dt.xml_id
                    INNER JOIN devices d on sensor_values.fk_device_id = d.device_id
                    ORDER BY date DESC";

        return $this->PDO->select($query);
    }
}

