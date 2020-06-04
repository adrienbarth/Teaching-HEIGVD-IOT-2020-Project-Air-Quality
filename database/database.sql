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
	device_id   varchar(255) not null unique primary key,
    device_eui  varchar(255) not null,
    location    varchar(255) null
);

CREATE TABLE data_types
(
	xml_id			      	int not null unique primary key,
	name                    varchar(255) not null,
	data_bytes              int not null,
    data_signed             tinyint(1) not null,
	data_resolution_per_bit float not null,
	unit			        varchar(10) null,
	event_api_host          varchar(255) null,
	event_api_port          int null,
	event_api_path          varchar(255) null,
    downlink_device_id      varchar(255) null,
    constraint data_types_to_devices_fk
        foreign key (downlink_device_id) references devices (device_id)
);

CREATE TABLE sensor_values
(
	ID				int auto_increment primary key,
	date			datetime not null,
	value			varchar(255) not null,
    fk_device_id 	varchar(255) not null,
	fk_data_type_xml_id int not null,
    constraint sensor_values_to_devices_fk
        foreign key (fk_device_id) references devices (device_id),
    constraint sensor_values_to_data_types_fk
        foreign key (fk_data_type_xml_id) references data_types (xml_id)
);

INSERT INTO devices VALUES ("airquality", "Analyse de l'air", 1);
INSERT INTO devices VALUES ("environment-2", "Analyse de l'environnement", 1);
INSERT INTO devices VALUES ("blovis-environment-click", "unknown", 1);

INSERT INTO data_types VALUES (3302, "Presence", 1, 0, 1, "", "", null, "", null);
INSERT INTO data_types VALUES (3303, "Temperature", 2, 1, 0.1, "°C", "", null, "", null);
INSERT INTO data_types VALUES (3304, "RH", 1, 0, 0.5, "%", "", null, "", null);
INSERT INTO data_types VALUES (3315, "Pressure", 2, 0, 0.1, "hPa", "10.7.0.9", 6060, "/event", "blovis-environment-click");
INSERT INTO data_types VALUES (3324, "Loudness", 2, 0, 0.1, "mV", "", null, "", "environment-2");
INSERT INTO data_types VALUES (3325, "Concentration", 2, 0, 1, "ppm", "10.7.0.10", 7070, "/event", "air-quality");
INSERT INTO data_types VALUES (3336, "Location", 6, 1, 0.0001, "°", "", null, "", "airquality");
INSERT INTO data_types VALUES (3341, "RFID tag ID", 4, 0, 1, "", "", null, "", null);

INSERT INTO sensor_values VALUES (0, now(), "25.5", "airquality", 3303);