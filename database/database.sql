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
	EUI				varchar(255) not null unique primary key,
    name			varchar(255) not null,
    location		varchar(255) null,
    is_enabled 		tinyint(1) default 1 not null
);

CREATE TABLE data_types
(
	ID				int not null unique primary key,
	name			varchar(255) not null,
	bytes			int not null,
	signed			tinyint(1) not null,
	accuracy		float not null,
	unit			varchar(10) null,
	event_url       varchar(255) null,
    fk_device_EUI  varchar(255) null,
    constraint data_types_to_devices_fk
        foreign key (fk_device_EUI) references devices (EUI)
);

CREATE TABLE sensor_values
(
	ID				int auto_increment primary key,
	date			datetime not null,
	value			varchar(255) not null,
    fk_device_EUI 	varchar(255) not null,
	fk_data_type_ID int not null,
    constraint sensor_values_to_devices_fk
        foreign key (fk_device_EUI) references devices (EUI),
    constraint sensor_values_to_data_types_fk
        foreign key (fk_data_type_ID) references data_types (ID)
);

INSERT INTO devices VALUES ("airquality", "Analyse de l'air", "Lausanne", 1);
INSERT INTO devices VALUES ("environment-2", "Analyse de l'environnement", "Vevey", 1);
INSERT INTO devices VALUES ("blovis-environment-click", "unknown", "Yverdon", 1);

INSERT INTO data_types VALUES (3302, "Presence", 1, 0, 1, "", "", null);
INSERT INTO data_types VALUES (3303, "Temperature", 2, 1, 0.1, "°C", "", null);
INSERT INTO data_types VALUES (3304, "RH", 1, 0, 0.5, "%", "", null);
INSERT INTO data_types VALUES (3315, "Pressure", 2, 0, 0.1, "hPa", "http://localhost:5000/event", "blovis-environment-click");
INSERT INTO data_types VALUES (3324, "Loudness", 2, 0, 0.1, "mV", "", "environment-2");
INSERT INTO data_types VALUES (3325, "Concentration", 2, 0, 1, "ppm", "http://localhost:5000/event", "blovis-environment-click");
INSERT INTO data_types VALUES (3336, "Location", 6, 1, 0.0001, "°", "", "airquality");
INSERT INTO data_types VALUES (3341, "RFID tag ID", 4, 0, 1, "", "", null);

INSERT INTO sensor_values VALUES (0, now(), "25.5", "airquality", 3303);