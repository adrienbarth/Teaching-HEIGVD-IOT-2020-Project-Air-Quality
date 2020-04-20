<?php

require_once "Database.php";

class Sensor
{
    private $PDO;

    public function __construct() {
        $this->PDO = new Database();
    }

    public function getSensors($deviceEUI) {
        return $this->PDO->select(
            "SELECT * FROM sensors WHERE fk_device_EUI = :EUI",
            array(
                array('EUI', $deviceEUI, PDO::PARAM_STR)
            )
        );
    }
}

