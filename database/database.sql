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
	EUI				varchar(100) not null unique primary key,
    name			varchar(100) not null,
    location		varchar(100) null,
    is_enabled 		tinyint(1) default 1 not null
);

CREATE TABLE data_types
(
	ID				int not null unique primary key,
	name			varchar(50) not null,
	bytes			int not null,
	signed			tinyint(1) not null,
	precision		float not null,
	unit			varchar(10) not null
);

CREATE TABLE sensor_values
(
	ID				int auto_increment primary key,
	date			datetime not null,
	value			varchar(100) not null,
    fk_device_EUI 	varchar(100) not null,
	fk_data_type_ID int not null,
    constraint sensor_values_to_devices_fk
        foreign key (fk_device_EUI) references devices (EUI),
    constraint sensor_values_to_data_types_fk
        foreign key (fk_data_type_ID) references data_types (ID)
);

INSERT INTO devices VALUES ("0004A30B0024D376", "airquality", "Lausanne", 1);
INSERT INTO devices VALUES ("0004A30B00215E8C", "environment-2", "Vevey", 1);

INSERT INTO data_types VALUES (3303, "Temperature", 2, 1, 0.1, "°C");
INSERT INTO data_types VALUES (3304, "RH", 1, 0, 0.5, "%");
INSERT INTO data_types VALUES (3315, "Pressure", 2, 0, 0.1, "hPa");
INSERT INTO data_types VALUES (3325, "Concentration", 2, 0, 1, "ppm");

INSERT INTO sensors VALUES (0, "Pression", "hPA", "0004A30B0024D376");
INSERT INTO sensors VALUES (0, "Température", "Celsius", "0004A30B0024D376");
INSERT INTO sensors VALUES (0, "Humidité", "rh", "0004A30B0024D376");
/* INSERT INTO sensors VALUES (0, "Résistance", "Ohms", "0004A30B0024D376"); */

INSERT INTO sensors VALUES (0, "TVOC", "ppb", "0004A30B00215E8C");
/* INSERT INTO sensors VALUES (0, "CO2", "ppm", "0004A30B00215E8C"); */