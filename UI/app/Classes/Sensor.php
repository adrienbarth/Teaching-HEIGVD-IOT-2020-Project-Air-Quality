<?php

require_once "Database.php";

class Sensor
{
    private $PDO;

    public function __construct() {
        $this->PDO = new Database();
    }

    public function getSensors($device_id) {
        return $this->PDO->select(
            "SELECT * FROM data_types WHERE fk_device_EUI = :EUI",
            array(
                array('EUI', $deviceEUI, PDO::PARAM_STR)
            )
        );
    }
}

