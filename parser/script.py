import time
import ttn
import base64
import mysql.connector
from mysql.connector import Error

app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

handler = ttn.HandlerClient(app_id, access_key)

def writeToDB(sensor_id, value):
    try:
        connection = mysql.connector.connect(host='air-quality-db', database='iot2020', user='root', password='d04kdzepq33kadf3qp314rm3o')
        cursor = connection.cursor()
        query = "INSERT INTO iot2020.sensorValues(date, payload, fk_sensor_id) VALUES (NOW(), %s, %s)"
        recordTuple = (value, sensor_id)
        cursor.execute(query, recordTuple)
        connection.commit()
        print("Record inserted successfully into sensorValues table")

    except mysql.connector.Error as error:
        print("Failed to insert into MySQL table {}".format(error))

    finally:
        if (connection.is_connected()):
            cursor.close()
            connection.close()
            print("MySQL connection is closed")

def uplink_callback(msg, client):
	print("Received uplink from ", msg.dev_id)
	value = str(int(str(base64.b64decode(msg.payload_raw).hex()),16))
	sensor_id = msg.port
	writeToDB(sensor_id, value)

# using mqtt client
mqtt_client = handler.data()
mqtt_client.set_uplink_callback(uplink_callback)
while True:
	mqtt_client.connect()

	time.sleep(60)

mqtt_client.close()

