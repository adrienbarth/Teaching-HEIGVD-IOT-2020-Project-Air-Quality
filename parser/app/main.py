import time
import argparse
import ttn
import base64
import socket
import requests
import mysql.connector

from datatype import DataType
from mysql.connector import Error
from requests.exceptions import HTTPError

# TTN access
app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

# Argument parsing
parser = argparse.ArgumentParser(description='Teaching-HEIGVD-IOT-2020-Project-Air-Quality@PARSER')
parser.add_argument("--host",     help="Database host")
parser.add_argument("--schema",   help="Database schema")
parser.add_argument("--user",     help="Database username")
parser.add_argument("--password", help="Datapase user password")
args = parser.parse_args()

datatypes = {}

def parse_payload(payload):
    '''
    Parse a payload.
    :param payload: the payload to parse in hexadecimal
    :return: A map of key-value with the data
    '''
    data = {}

    while payload:
        # Extract the datatype
        xml_id = int(payload[:4], 16)
        payload = payload[4:]

        # Verifying if we know this datatype
        if xml_id not in datatypes:
            raise ValueError("[WARNING] Invalid payload format...")
        dt = datatypes[xml_id]

        # Extract the value and convert it
        value = int(payload[:dt.data_bytes * 2], 16)
        payload = payload[dt.data_bytes * 2:]
        value = value * dt.data_resolution_per_bit

        # Add the value to the dataset
        data.update({dt.xml_id :{
            "value": value,
            "datatype": dt
        }})
    return data

def notify_event_api(datatype, value):
    '''
    Notify the event API if present.
    '''
    if not datatype.event_api_host:
        return

    try:
        url = datatype.get_event_url()
        headers = {'Accept' : 'application/json', 'Content-Type' : 'application/json'}
        json = '{ "data_type" : "' + str(datatype.name) + '", "data" : [{ "' + str(datatype.name) + '": "' + str(value) + '"}]}'
        requests.post(url, data=json, headers=headers)
    except HTTPError as http_err:
        print(f'[ERROR] HTTP error occurred: {http_err}')  # Python 3.6
    except Exception as err:
        print(f'[ERROR] Other error occurred: {err}')  # Python 3.6
    else:
        print("[DEBUG] API " + url + " has been notified")

def write_value_to_db(datatype, dev_id, value):
    '''
    Write value to the database.
    '''
    try:
        connection = mysql.connector.connect(host=args.host, database=args.schema, user=args.user, password=args.password)
        cursor = connection.cursor()
        query = "INSERT INTO sensor_values(date, value, fk_device_id, fk_data_type_xml_id) VALUES (NOW(), %s, %s, %s)"
        recordTuple = (value, dev_id, datatype.xml_id)
        cursor.execute(query, recordTuple)
        connection.commit()
        print("[DEBUG] Device " + str(dev_id) + " reported value " + str(value) + " for datatype ID " + str(datatype.xml_id) + ".")

    except mysql.connector.Error as error:
        print("[ERROR] Failed to insert into MySQL table {}".format(error))

    finally:
        if (connection.is_connected()):
            cursor.close()
            connection.close()

def uplink_callback(msg, client):
    '''
    MQTT uplink callback
    '''
    payload_hexa = base64.b64decode(msg.payload_raw).hex()
    try:
        data = parse_payload(payload_hexa)
        for i in data.values():
            write_value_to_db(i['datatype'], msg.dev_id, i['value'])
            notify_event_api(i['datatype'], i['value'])

        print("[INFO] Uplink from device EUI " + str(msg.hardware_serial) + " successfully recorded in the database.")
    except ValueError as error:
        print(error)

#main
print("**** Teaching-HEIGVD-IOT-2020-Project-Air-Quality@PARSER ****")

# Fetching data types
datatypes = DataType.get_all(args.host, args.schema, args.user, args.password)
for dt in datatypes.values():
    print("[DEBUG] Datatype found: " + str(dt))
print(" [INFO] Datatypes successfully fetched from the database.")

# Connection to TTN
handler = ttn.HandlerClient(app_id, access_key)
mqtt_client = handler.data()
mqtt_client.set_uplink_callback(uplink_callback)
print(" [INFO] Successfully connected to TTN API.")

# Waiting for uplinks
while True:
    mqtt_client.connect()
    time.sleep(60)
mqtt_client.close()