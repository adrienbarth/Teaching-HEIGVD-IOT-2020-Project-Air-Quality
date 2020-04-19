/**
  Auteurs:  Adrien Barth, Nair Alic
  Date:     07.04.2020
  Projet:   Teaching-HEIGVD-IOT-2020-Project-Air-Quality

  Création de la base de données et insertion de valeurs de test.
 */

DROP DATABASE IF EXISTS iot_air_quality;
CREATE DATABASE iot_air_quality;
USE iot_air_quality;

CREATE TABLE devices
(
	EUI			varchar(100) not null unique primary key,
    name		varchar(100) not null,
    location	varchar(100) null,
    is_enabled 	tinyint(1) default 1 not null
);

CREATE TABLE sensors
(
    id				int auto_increment primary key,
    name			varchar(100) not null,
    fk_device_EUI 	varchar(100) not null,
    constraint sensors_devices_EUI_fk
        foreign key (fk_device_EUI) references devices (EUI)
);

CREATE TABLE values
(
    id				int auto_increment primary key,
	date			datetime not null,
    payload			float not null,
    fk_sensor_id 	int not null,
    constraint values_sensors_id_fk
        foreign key (fk_sensor_id) references sensors (id)
);