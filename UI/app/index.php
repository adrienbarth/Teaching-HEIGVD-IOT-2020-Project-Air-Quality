<?php
require_once "./Classes/Device.php";
require_once "./Classes/Sensor.php";
require_once "./Classes/SensorValue.php";

$DeviceDAO = new Device();
$SensorDAO = new Sensor();
$SensorValueDAO = new SensorValue();

$devices = $DeviceDAO->getDevices();
$sensorValues = $SensorValueDAO->getAllSensorValues();

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
            <h1 class="mt-5">Last values</h1>
            <table class="table table-bordered">
                <thead>
                    <tr>
                    <th scope="col">EUI</th>
                    <th scope="col">Location</th>
                    <th scope="col">Sensor</th>
                    <th scope="col">Date</th>
                    <th scope="col">Value</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                        foreach ($sensorValues as $sensorValue) {
                            echo '<tr>';
                            echo '<td>'.$sensorValue->EUI.'</td>';
                            echo '<td>'.$sensorValue->location.'</td>';
                            echo '<td>'.$sensorValue->name.'</td>';
                            echo '<td>'.$sensorValue->date.'</td>';
                            echo '<td>'.$sensorValue->payload.'</td>';
                            echo '</tr>';
                        }
                    ?>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>