import time
import ttn
import base64
import mysql.connector
from mysql.connector import Error

app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

handler = ttn.HandlerClient(app_id, access_key)

def writeToDB(msg, value):
	date, hour = msg.metadata.time.split('T')
	hour = hour.split('.')[0]
	sqlDate = date + " " + str(hour)

	if msg.dev_id == "airquality":
		temp, pressure, humidity, uv = value.split('00')
		
		temp = int(temp,16)			#°C id 6
		pressure = int(pressure,16) #hPA id 5
		humidity = int(humidity,16) #%rh id 7
		uv = int(uv,16)			#ohms id 8

		statements = 'INSERT INTO iot2020.sensorValues(date, payload, fk_sensor_id) VALUES (NOW(), "' + str(pressure) + '", 1);'
		statements += 'INSERT INTO iot2020.sensorValues(date, payload, fk_sensor_id) VALUES (NOW(), "' + str(temp) + '", 2);'
		statements += 'INSERT INTO iot2020.sensorValues(date, payload, fk_sensor_id) VALUES (NOW(), "' + str(humidity) + '", 3);'
		statements += 'INSERT INTO iot2020.sensorValues(date, payload, fk_sensor_id) VALUES (NOW(), "' + str(uv) + '", 4);'

	elif msg.dev_id == "environment-2":
		tvoc = value[:2]		#ppb id 10
		coo = value[2:]			#ppm id 9

		statements = 'INSERT INTO iot2020.sensorValues(date, payload, unite, fk_sensor_id) VALUES (NOW(), "' + str(tvoc) + '", 5);'
		statements += 'INSERT INTO iot2020.sensorValues(date, payload, unite, fk_sensor_id) VALUES (NOW(), "' + str(coo) + '", 6);'

	print(statements)
	
	try:
		connection = mysql.connector.connect(
			host='air-quality-db',
			database='iot2020',
			user='root',
			password='d04kdzepq33kadf3qp314rm3o')


		connection.is_connected()
		db_Info = connection.get_server_info()
		print("Connected to MySQL Server version ", db_Info)
		cursor = connection.cursor()
		for statement in statements.split(';'):
			if len(statement) > 0:
				cursor.execute(statement + ';')
		connection.commit()
		print(cursor.rowcount, "record inserted successfully into table")
		record = cursor.fetchone()


	except Error as e:
		print("Error while connecting to MySQL", e)
	finally:
		if (connection.is_connected()):
			cursor.close()
			connection.close()
			print("MySQL connection is closed")

def uplink_callback(msg, client):
	print("Received uplink from ", msg.dev_id)
	value = str(base64.b64decode(msg.payload_raw).hex())
	print(value)
	writeToDB(msg, value)

# using mqtt client
mqtt_client = handler.data()
mqtt_client.set_uplink_callback(uplink_callback)
while True:
	mqtt_client.connect()

	time.sleep(60)

mqtt_client.close()

