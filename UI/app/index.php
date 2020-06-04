<?php
require_once "./Classes/Device.php";
require_once "./Classes/Sensor.php";
require_once "./Classes/SensorValue.php";

$DeviceDAO = new Device();
$SensorValueDAO = new SensorValue();

$devices = $DeviceDAO->getDevices();
$sensorValues = $SensorValueDAO->getAllSensorValues();

?>

<!doctype html>
<html>
<head>
    <title>Teaching-HEIGVD-IOT-2020-Project-Air-Quality</title>
    <link rel="stylesheet" href="/Styles/bootstrap.min.css">
    <link rel="stylesheet" href="/Styles/sticky-footer-navbar.css">
</head>
<body>
    <header>
        <!-- Fixed navbar -->
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
            <a class="navbar-brand" href="/Messages/List">Teaching-HEIGVD-IOT-2020-Project-Air-Quality</a>

        </nav>
    </header>
    <main class="container-fluid" role="main">
        <div class="container-fluid" role="main">
            <br/>
            <br/>
            <br/>
            <table class="table table-bordered table-sm table-hover">
                <thead>
                    <tr>
                    <th scope="col">Device EUI</th>
                    <th scope="col">Device ID</th>
                    <th scope="col">Date</th>
                    <th scope="col">Data type</th>
                    <th scope="col">Value</th>
                    <th scope="col">Unit</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                        foreach ($sensorValues as $sensorValue) {
                            echo '<tr>';
                            echo '<td>'.$sensorValue->device_eui.'</td>';
                            echo '<td>'.$sensorValue->device_id.'</td>';
                            echo '<td>'.$sensorValue->date.'</td>';
                            echo '<td>'.$sensorValue->name.'</td>';
                            echo '<td>'.$sensorValue->value.'</td>';
                            echo '<td>'.$sensorValue->unit.'</td>';
                            echo '</tr>';
                        }
                    ?>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>