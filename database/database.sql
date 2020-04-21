/**
  Auteurs:  Adrien Barth, Nair Alic
  Date:     07.04.2020
  Projet:   Teaching-HEIGVD-IOT-2020-Project-Air-Quality

  Cr�ation de la base de donn�es et insertion de valeurs de test.
 */

DROP DATABASE IF EXISTS iot2020;
CREATE DATABASE iot2020;
USE iot2020;

CREATE TABLE devices
(
	EUI			varchar(100) not null unique primary key,
    name		varchar(100) not null,
    location	varchar(100) null,
    is_enabled 	tinyint(1) default 1 not null
);

CREATE TABLE sensors
(
    id				int not null,
    sensorName		varchar(100) not null,
    unit			varchar(20) not null,
    fk_device_EUI 	varchar(100) not null,
    constraint sensors_devices_EUI_fk
        foreign key (fk_device_EUI) references devices (EUI),
    PRIMARY KEY (id, fk_device_EUI)
);

CREATE TABLE sensorValues
(
    id				int auto_increment primary key,
	date			datetime not null,
    payload			varchar(20) not null,
    fk_sensor_id 	int not null,
    constraint messages_sensors_id_fk
        foreign key (fk_sensor_id) references sensors (id)
);

INSERT INTO devices VALUES ("0004A30B0024D376", "airquality", "Lausanne", 1);
INSERT INTO devices VALUES ("0004A30B00215E8C", "environment-2", "Vevey", 1);

INSERT INTO sensors VALUES (1, "Pression", "hPA", "0004A30B0024D376");
INSERT INTO sensors VALUES (2, "Température", "Celsius", "0004A30B0024D376");
INSERT INTO sensors VALUES (3, "Humidité", "rh", "0004A30B0024D376");
INSERT INTO sensors VALUES (4, "Résistance", "Ohms", "0004A30B0024D376");

INSERT INTO sensors VALUES (1, "TCOV", "ppb", "0004A30B00215E8C");
INSERT INTO sensors VALUES (2, "CO2", "ppm", "0004A30B00215E8C");