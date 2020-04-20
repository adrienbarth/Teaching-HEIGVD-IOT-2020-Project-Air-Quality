<?php
require_once "./Classes/Device.php";
require_once "./Classes/Sensor.php";
require_once "./Classes/SensorValue.php";

$DeviceDAO = new Device();
$SensorDAO = new Sensor();
$SensorValueDAO = new SensorValue();

$devices = $DeviceDAO->getDevices();

?>

<!doctype html>
<html>
<head>
    <title>IOT2020</title>
    <link rel="stylesheet" href="/Styles/bootstrap.min.css">
    <link rel="stylesheet" href="/Styles/sticky-footer-navbar.css">
</head>
<body>
    <header>
        <!-- Fixed navbar -->
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
            <a class="navbar-brand" href="/Messages/List">IOT2020</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav mr-auto">
                    <?php
                        foreach ($devices as $device) {
                        echo '<li class="nav-item"><a class="nav-link" href="/Devices/'.$device->EUI.'">'.$device->name.'</a></li>';
                        }
                    ?>
                </ul>
            </div>
        </nav>
    </header>
    <form id="head_new_message" action="/Messages/New" method="post">
    </form>
    <form id="head_new_user" action="/Users/New" method="post">
    </form>
    <form id="head_change_password" action="/Users/Edit" method="post">
    </form>
    <form id="head_logoff" action="/Users/Logoff" method="post">
    </form>
    <!-- Begin page content -->
    <main role="main" class="container">
        <div class="container" role="main">
    <?php
        foreach ($devices as $device) {
            $sensors = $SensorDAO->getSensors($device->EUI);

            foreach ($sensors as $sensor) {
                $sensorValues = $SensorValueDAO->getSensorValues($sensor->id);

                foreach ($sensorValues as $sensorValue) {
                    echo $device->EUI.' '.$device->name.' '.$device->location.' '.$sensor->name.' '.$sensorValue->date.' '.$sensorValue->payload.'<br/>';
                }
            }
        }
    ?>
            </div>
    </main>
</body>
</html>