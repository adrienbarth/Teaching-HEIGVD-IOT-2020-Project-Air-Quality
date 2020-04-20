<?php

require_once "Database.php";

class Device
{
    private $PDO;

    public function __construct() {
        $this->PDO = new Database();
    }

    public function getDevices() {
        $query = "SELECT * FROM devices";
        return $this->PDO->select($query);
    }
}

