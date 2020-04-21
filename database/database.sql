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
    id				int auto_increment primary key,
    sensorName		varchar(100) not null,
    unit			varchar(20) not null,
    fk_device_EUI 	varchar(100) not null,
    constraint sensors_devices_EUI_fk
        foreign key (fk_device_EUI) references devices (EUI)
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

INSERT INTO sensors VALUES (0, "Pression", "hPA", "0004A30B00215E8C");
INSERT INTO sensors VALUES (0, "Température", "Celsius", "0004A30B00215E8C");
INSERT INTO sensors VALUES (0, "Humidité", "rh", "0004A30B00215E8C");
INSERT INTO sensors VALUES (0, "Résistance", "Ohms", "0004A30B00215E8C");

INSERT INTO sensors VALUES (0, "TCOV", "ppb", "0004A30B0024A34D");
INSERT INTO sensors VALUES (0, "CO2", "ppm", "0004A30B0024A34D");

insert into sensorValues (id, date, payload, fk_sensor_id) values (1, '2020-01-23 16:26:49', 860, '#129', 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (2, '2019-09-21 03:55:30', 831, '#423', 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (3, '2019-06-03 15:27:41', 260, '#791', 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (4, '2019-12-03 07:07:17', 422, '#65e', 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (5, '2019-07-12 16:05:56', -233, '#2be', 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (6, '2019-11-05 22:26:49', -756, '#97c', 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (7, '2020-01-25 20:21:47', 568, '#488', 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (8, '2019-07-22 23:24:25', 35, '#dd0', 9);