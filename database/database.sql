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
    name			varchar(100) not null,
    fk_device_EUI 	varchar(100) not null,
    constraint sensors_devices_EUI_fk
        foreign key (fk_device_EUI) references devices (EUI)
);

CREATE TABLE sensorValues
(
    id				int auto_increment primary key,
	date			datetime not null,
    payload			varchar(20) not null,
    unite			varchar(20) not null,
    fk_sensor_id 	int not null,
    constraint messages_sensors_id_fk
        foreign key (fk_sensor_id) references sensors (id)
);

INSERT INTO devices VALUES ("0004A30B0024D376", "airquality", "Lausanne", 1);
INSERT INTO devices VALUES ("0004A30B00215E8C", "blovis-environment-click", "Yverdon", 1);
INSERT INTO devices VALUES ("0004A30B0024A34D", "environment-2", "Vevey", 1);

INSERT INTO sensors VALUES (0, "sensor1", "0004A30B0024D376");
INSERT INTO sensors VALUES (0, "sensor2", "0004A30B0024D376");
INSERT INTO sensors VALUES (0, "sensor3", "0004A30B0024D376");
INSERT INTO sensors VALUES (0, "sensor4", "0004A30B0024D376");

INSERT INTO sensors VALUES (0, "pressure", "0004A30B00215E8C");
INSERT INTO sensors VALUES (0, "temp", "0004A30B00215E8C");
INSERT INTO sensors VALUES (0, "humidity", "0004A30B00215E8C");
INSERT INTO sensors VALUES (0, "uv", "0004A30B00215E8C");

INSERT INTO sensors VALUES (0, "co2", "0004A30B0024A34D");
INSERT INTO sensors VALUES (0, "oooo2", "0004A30B0024A34D");

insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (1, '2020-01-23 16:26:49', 860, '#129', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (2, '2019-09-21 03:55:30', 831, '#423', 7);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (3, '2019-06-03 15:27:41', 260, '#791', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (4, '2019-12-03 07:07:17', 422, '#65e', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (5, '2019-07-12 16:05:56', -233, '#2be', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (6, '2019-11-05 22:26:49', -756, '#97c', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (7, '2020-01-25 20:21:47', 568, '#488', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (8, '2019-07-22 23:24:25', 35, '#dd0', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (9, '2019-07-24 12:40:52', 468, '#5ca', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (10, '2019-09-28 23:07:43', 243, '#bd9', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (11, '2019-05-08 07:53:33', -123, '#43a', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (12, '2019-08-09 23:52:10', -749, '#efb', 3);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (13, '2020-03-17 19:14:54', -605, '#785', 7);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (14, '2019-05-28 13:23:23', 396, '#f95', 10);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (15, '2019-09-02 06:23:28', -859, '#f79', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (16, '2020-02-01 06:06:52', 95, '#879', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (17, '2020-01-25 07:06:53', 581, '#adc', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (18, '2020-01-05 01:19:10', 505, '#91d', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (19, '2019-11-15 23:41:46', -274, '#504', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (20, '2020-04-08 20:52:51', 294, '#904', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (21, '2019-12-01 12:26:31', -787, '#e74', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (22, '2019-10-20 04:40:14', 428, '#628', 10);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (23, '2019-11-27 02:04:29', 799, '#bdb', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (24, '2019-05-15 21:08:00', -524, '#53a', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (25, '2019-05-25 10:48:24', 71, '#ede', 5);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (26, '2019-06-05 02:21:31', -799, '#35c', 5);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (27, '2020-01-17 20:11:00', 783, '#a06', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (28, '2020-04-16 20:10:55', 367, '#ccf', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (29, '2020-03-17 20:53:08', -662, '#efd', 7);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (30, '2019-08-02 02:54:22', 122, '#252', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (31, '2019-06-20 01:59:21', -173, '#7e5', 5);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (32, '2020-02-07 08:31:48', 471, '#8a5', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (33, '2019-07-29 03:15:45', 972, '#b1e', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (34, '2019-11-29 09:06:26', -72, '#9dd', 10);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (35, '2019-12-11 16:44:14', -849, '#9fa', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (36, '2019-10-17 08:12:06', 563, '#59a', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (37, '2019-06-06 18:33:23', -705, '#150', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (38, '2020-01-02 21:25:07', -157, '#8bb', 7);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (39, '2019-10-19 17:13:00', -606, '#70a', 3);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (40, '2020-04-10 09:09:05', -367, '#638', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (41, '2019-11-15 10:32:43', 540, '#ad0', 10);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (42, '2019-12-12 14:21:55', 120, '#8c5', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (43, '2020-03-19 14:21:00', -708, '#f82', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (44, '2019-11-10 05:13:34', 517, '#855', 3);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (45, '2019-10-31 15:21:14', -614, '#35d', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (46, '2019-11-10 18:12:53', 357, '#bba', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (47, '2019-05-18 20:17:26', 931, '#4c2', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (48, '2019-05-16 09:07:18', 286, '#5e5', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (49, '2019-05-26 03:56:00', -987, '#465', 7);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (50, '2019-09-26 05:59:17', 731, '#c58', 10);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (51, '2019-05-06 06:21:00', 803, '#8ae', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (52, '2019-12-03 20:34:37', 769, '#913', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (53, '2019-08-26 20:23:17', 683, '#14f', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (54, '2020-01-08 19:07:11', -701, '#5bc', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (55, '2019-10-08 03:36:31', -12, '#67e', 7);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (56, '2019-09-24 18:42:45', 552, '#984', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (57, '2020-03-23 00:49:17', -960, '#fee', 3);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (58, '2019-06-30 23:34:46', -265, '#5ba', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (59, '2020-04-08 11:44:34', -62, '#93e', 5);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (60, '2020-03-22 06:35:05', 451, '#f7b', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (61, '2019-06-17 21:51:04', 852, '#bf2', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (62, '2020-01-24 11:11:35', -614, '#26d', 3);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (63, '2019-07-25 02:18:06', -340, '#4c6', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (64, '2020-03-02 01:55:13', -25, '#584', 10);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (65, '2020-04-17 04:17:42', 388, '#819', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (66, '2019-05-15 08:55:08', 363, '#907', 5);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (67, '2019-07-01 06:32:09', 743, '#45e', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (68, '2019-07-11 08:14:21', -275, '#9ff', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (69, '2020-03-02 04:35:05', 886, '#804', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (70, '2020-01-15 20:31:17', -827, '#0f9', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (71, '2019-06-16 17:42:21', -439, '#47a', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (72, '2020-03-28 16:26:01', 544, '#28a', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (73, '2019-09-08 06:27:53', 814, '#1cf', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (74, '2019-05-23 23:14:27', 283, '#a21', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (75, '2019-12-18 17:52:32', 537, '#fe4', 3);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (76, '2019-06-21 22:05:13', 556, '#f4e', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (77, '2019-08-01 19:50:35', 436, '#f72', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (78, '2019-11-15 04:08:10', 116, '#7e0', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (79, '2020-04-16 04:27:29', -98, '#1c5', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (80, '2019-11-17 10:15:50', -689, '#f3a', 7);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (81, '2019-12-08 18:28:58', 482, '#0cc', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (82, '2019-05-28 08:09:16', -881, '#eda', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (83, '2020-02-24 08:35:22', 636, '#673', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (84, '2019-11-19 15:26:51', -553, '#def', 5);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (85, '2019-11-04 05:06:47', -193, '#6db', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (86, '2019-05-09 23:26:22', 138, '#003', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (87, '2019-06-09 20:30:34', -928, '#c8b', 6);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (88, '2019-11-27 11:49:42', -586, '#0e9', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (89, '2019-08-08 04:00:04', 946, '#eea', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (90, '2019-06-14 13:58:03', -649, '#757', 9);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (91, '2019-11-12 18:40:05', 840, '#3a6', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (92, '2019-09-11 03:47:34', -592, '#01d', 3);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (93, '2019-08-20 02:48:24', -59, '#bdc', 1);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (94, '2020-04-02 13:40:34', -191, '#1c4', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (95, '2020-03-08 03:49:31', -986, '#2f1', 2);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (96, '2019-12-20 07:22:21', -446, '#26d', 8);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (97, '2019-10-31 20:37:10', 348, '#d61', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (98, '2020-03-23 16:42:59', 16, '#ea9', 4);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (99, '2019-06-05 15:46:07', -769, '#98b', 5);
insert into sensorValues (id, date, payload, unite, fk_sensor_id) values (100, '2020-04-07 18:38:04', 255, '#3d0', 2);


