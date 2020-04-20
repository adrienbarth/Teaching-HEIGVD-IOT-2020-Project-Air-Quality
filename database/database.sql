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
    payload			float not null,
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

insert into sensorValues (id, date, payload, fk_sensor_id) values (1, '2019-05-23 04:16:46', 2036, 4);
insert into sensorValues (id, date, payload, fk_sensor_id) values (2, '2019-07-29 08:27:21', -48, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (3, '2019-08-31 07:39:45', 4614, 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (4, '2020-04-09 02:43:22', 1662, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (5, '2019-08-21 13:03:30', 2705, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (6, '2019-07-28 01:11:01', 2301, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (7, '2019-11-25 19:23:47', 98, 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (8, '2019-05-30 06:40:59', 8013, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (9, '2020-03-07 08:05:37', 3635, 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (10, '2020-03-14 07:38:16', 6888, 4);
insert into sensorValues (id, date, payload, fk_sensor_id) values (11, '2019-12-08 11:46:54', 3102, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (12, '2020-01-29 08:33:35', 6309, 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (13, '2020-02-21 19:00:07', 8547, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (14, '2020-03-17 16:53:03', 5844, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (15, '2019-12-17 18:02:00', 1158, 5);
insert into sensorValues (id, date, payload, fk_sensor_id) values (16, '2019-09-16 20:21:56', 3953, 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (17, '2019-05-29 11:50:04', 2307, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (18, '2020-04-03 15:12:56', 7226, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (19, '2019-09-14 07:34:47', -80, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (20, '2019-12-31 00:14:23', 4721, 4);
insert into sensorValues (id, date, payload, fk_sensor_id) values (21, '2019-05-06 13:51:20', 9888, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (22, '2019-05-18 10:19:34', 5857, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (23, '2019-10-14 06:57:52', 9884, 5);
insert into sensorValues (id, date, payload, fk_sensor_id) values (24, '2019-10-28 00:18:16', 530, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (25, '2019-10-17 21:58:29', 9819, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (26, '2019-05-02 20:57:31', 7774, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (27, '2020-01-14 21:57:04', 5229, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (28, '2019-05-24 13:02:00', 110, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (29, '2019-05-05 03:57:38', 4294, 5);
insert into sensorValues (id, date, payload, fk_sensor_id) values (30, '2020-02-06 04:49:58', 9558, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (31, '2019-12-01 00:19:20', 2142, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (32, '2020-01-08 23:01:37', 1138, 4);
insert into sensorValues (id, date, payload, fk_sensor_id) values (33, '2019-06-26 05:48:04', 7531, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (34, '2019-12-28 12:58:45', 1855, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (35, '2019-11-12 04:17:29', 5445, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (36, '2020-02-19 01:30:49', 7107, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (37, '2020-03-12 16:02:34', 1426, 5);
insert into sensorValues (id, date, payload, fk_sensor_id) values (38, '2019-08-24 06:24:12', 8577, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (39, '2019-08-19 04:22:29', 8818, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (40, '2019-07-09 12:20:39', 7990, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (41, '2019-10-20 06:15:46', 9564, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (42, '2019-06-25 17:41:00', 6259, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (43, '2019-06-26 01:33:22', 5877, 4);
insert into sensorValues (id, date, payload, fk_sensor_id) values (44, '2020-02-27 03:33:41', 5158, 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (45, '2019-07-12 23:16:56', 3045, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (46, '2019-08-12 19:43:38', 9187, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (47, '2019-08-16 17:59:25', 9116, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (48, '2019-10-18 18:39:25', 3538, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (49, '2020-03-12 20:36:44', 7519, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (50, '2019-11-10 15:10:03', 741, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (51, '2020-02-09 09:02:59', 8024, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (52, '2019-09-08 12:00:56', 462, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (53, '2019-09-15 08:10:18', 6184, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (54, '2019-08-15 19:19:51', 3925, 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (55, '2019-07-01 16:16:49', 3523, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (56, '2020-03-17 09:46:32', 7568, 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (57, '2020-03-05 20:17:23', 1746, 5);
insert into sensorValues (id, date, payload, fk_sensor_id) values (58, '2019-09-04 17:35:46', 5923, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (59, '2019-09-02 05:28:32', 5131, 5);
insert into sensorValues (id, date, payload, fk_sensor_id) values (60, '2020-02-06 18:39:50', 6224, 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (61, '2019-06-23 05:11:56', -55, 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (62, '2020-01-28 21:38:10', 8595, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (63, '2019-06-08 04:48:10', 5261, 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (64, '2019-05-31 22:15:40', 6924, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (65, '2019-10-14 03:09:26', 7924, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (66, '2020-02-27 07:49:59', 4908, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (67, '2019-12-30 22:19:39', 294, 4);
insert into sensorValues (id, date, payload, fk_sensor_id) values (68, '2019-09-01 10:51:24', 1179, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (69, '2020-02-12 15:50:18', 7081, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (70, '2019-10-07 00:55:07', 1769, 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (71, '2019-07-01 08:59:25', 3001, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (72, '2019-12-18 05:25:39', 5196, 5);
insert into sensorValues (id, date, payload, fk_sensor_id) values (73, '2019-11-02 02:48:24', 1109, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (74, '2019-08-19 20:09:40', 9998, 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (75, '2019-12-08 16:27:13', 6421, 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (76, '2020-04-02 13:08:10', 3309, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (77, '2019-12-20 04:11:49', 7908, 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (78, '2019-11-10 16:59:05', 8077, 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (79, '2020-03-17 00:17:29', 3539, 1);
insert into sensorValues (id, date, payload, fk_sensor_id) values (80, '2020-03-08 00:54:24', 3995, 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (81, '2020-01-01 03:58:36', 9492, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (82, '2019-09-26 01:11:28', 2539, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (83, '2019-11-24 05:48:15', 4528, 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (84, '2019-05-12 21:21:44', 2461, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (85, '2020-02-09 05:29:01', 6238, 3);
insert into sensorValues (id, date, payload, fk_sensor_id) values (86, '2019-06-06 01:43:17', 5312, 6);
insert into sensorValues (id, date, payload, fk_sensor_id) values (87, '2019-10-14 14:09:59', 3614, 5);
insert into sensorValues (id, date, payload, fk_sensor_id) values (88, '2020-01-26 14:47:34', 6854, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (89, '2019-11-05 19:31:14', 8773, 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (90, '2020-02-21 08:13:50', 8952, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (91, '2020-03-30 07:32:13', 3208, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (92, '2019-07-11 00:25:31', 8320, 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (93, '2020-03-31 22:41:52', 5334, 7);
insert into sensorValues (id, date, payload, fk_sensor_id) values (94, '2019-09-07 00:42:48', 8479, 10);
insert into sensorValues (id, date, payload, fk_sensor_id) values (95, '2019-05-06 06:55:28', 2076, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (96, '2019-11-29 19:27:04', 8604, 9);
insert into sensorValues (id, date, payload, fk_sensor_id) values (97, '2019-10-26 17:27:00', 307, 2);
insert into sensorValues (id, date, payload, fk_sensor_id) values (98, '2020-01-17 10:53:16', 9251, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (99, '2020-01-08 16:35:37', 9093, 8);
insert into sensorValues (id, date, payload, fk_sensor_id) values (100, '2020-04-07 14:23:52', 414, 7);

