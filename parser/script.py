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
  print(msg)
  print(str(base64.b64decode(msg.payload_raw).decode("utf-8")))

  writeToDB(msg)

def writeToDB(msg):
 	connection = mysql.connector.connect(host='localhost',
                                         database='mydb',
                                         user='user',
                                         password='password')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select *")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

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
mqtt_client.connect()
time.sleep(60)
mqtt_client.close()


# connect to DB

