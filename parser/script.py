import time
import ttn
import base64
import mysql.connector
from mysql.connector import Error

app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

handler = ttn.HandlerClient(app_id, access_key)

def uplink_callback(msg, client):
	print("Received uplink from ", msg.dev_id)
	value = str(base64.b64decode(msg.payload_raw).hex())
	print(value)
	writeToDB(msg, value)

def writeToDB(msg, value):
	
	date, hour = msg.metadata.time.split('T')
	hour = hour.split('.')[0]
	sqlDate = date + " " + str(hour)
	
	if msg.dev_id == "environment-2":
		temp, pressure, humidity, uv = value.split('00')
		
		temp = int(temp,16)			#°C id 6
		pressure = int(pressure,16) #hPA id 5
		humidity = int(humidity,16) #%rh id 7
		uv = int(uv,16)			#ohms id 8

		statement += 'INSERT INTO iot2020.sensorValues(date, payload, unite, fk_sensor_id) VALUES ("' + sqlDate + '", ' + str(pressure) + ', "hPA", 5);\n'
		statement += 'INSERT INTO iot2020.sensorValues(date, payload, unite, fk_sensor_id) VALUES ("' + sqlDate + '", ' + str(temp) + ', "Celsius", 6);\n'
		statement += 'INSERT INTO iot2020.sensorValues(date, payload, unite, fk_sensor_id) VALUES ("' + sqlDate + '", ' + str(humidity) + ', "rh", 7);\n'
		statement += 'INSERT INTO iot2020.sensorValues(date, payload, unite, fk_sensor_id) VALUES ("' + sqlDate + '", ' + str(uv) + ', "ohms", 8);\n'


	elif msg.dev_id == "airquality":
		tvoc = value[:2]		#ppb id 10
		coo = value[2:]			#ppm id 9

		statement += 'INSERT INTO iot2020.sensorValues(date, payload, unite, fk_sensor_id) VALUES ("' + sqlDate + '", ' + str(tvoc) + ', "ppb", 10);\n'
		statement += 'INSERT INTO iot2020.sensorValues(date, payload, unite, fk_sensor_id) VALUES ("' + sqlDate + '", ' + str(coo) + ', "ppm", 9);\n'


	print(statement)
	

	try:
		connection = mysql.connector.connect(host='air-quality-db',
										 database='iot2020',
										 user='root',
										 password='d04kdzepq33kadf3qp314rm3o')


		connection.is_connected()
		db_Info = connection.get_server_info()
		print("Connected to MySQL Server version ", db_Info)
		cursor = connection.cursor()
		cursor.execute(statement)
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


# using mqtt client
mqtt_client = handler.data()
mqtt_client.set_uplink_callback(uplink_callback)
while True:
	mqtt_client.connect()

	time.sleep(60)

mqtt_client.close()

