import time
import ttn
import base64
import mysql.connector
from mysql.connector import Error

app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

# MySQL
db_host =     'localhost'
db_schema =   'iot2020'
db_user =     'root'
db_password = 'T2sF8fxIK7ctLS0kR1gT'

datatypes = {}

def fetch_datatypes():
    '''
    Fetch datatypes from the database and return a dictionary of data types.
    '''
    try:
        connection = mysql.connector.connect(host=db_host, database=db_schema, user=db_user, password=db_password)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM data_types")
        results = cursor.fetchall()
    except mysql.connector.Error as error:
        print("Failed to insert into MySQL table {}".format(error))
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
    
    data = {}
    for x in results:
        print("[DEBUG] Datatype found: " + str(x))
        data.update( {x[0] : {'name' : x[1], 'bytes' : x[2], 'signed' : x[3], 'accuracy' : x[4], 'unit' : x[5], 'event_url': x[6]}})

    return data

def parse_payload(payload):
    '''
    Parse a payload
    :param payload: the payload to parse in hexadecimal
    :return: A map of key-value with the data
    '''
    data = {}

    while payload:
        # Extract the datatype
        datatypeID = int(payload[:4], 16)
        payload = payload[4:]

        # Verifying if we know this datatype
        if datatypeID not in datatypes:
            raise ValueError("[WARNING] Wrong datatype received, unable to parse the payload...")
        datatype = datatypes[datatypeID]

        # Extract the value and convert it
        value = int(payload[:datatype['bytes'] * 2], 16)
        payload = payload[datatype['bytes'] * 2:]
        value = value * datatype['accuracy']

        # Add the value to the dataset
        data.update( {datatypeID : value} )

        # If needed, notify an event API
        if datatype['event_url']:
            notify_event_api(datatype, value, datatype['event_url'])

    return data

def notify_event_api(datatype, value, url):
    print("[DEBUG] Notifying " + url)
    return "todo"

def write_data_to_db(value, device_EUI, datatype_ID):
    '''

    '''
    try:
        connection = mysql.connector.connect(host=db_host, database=db_schema, user=db_user, password=db_password)
        cursor = connection.cursor()
        query = "INSERT INTO sensor_values(date, value, fk_device_EUI, fk_data_type_ID) VALUES (NOW(), %s, %s, %s)"
        recordTuple = (value, device_EUI, datatype_ID)
        cursor.execute(query, recordTuple)
        connection.commit()
        print("[DEBUG] Device " + str(device_EUI) + " reported value " + str(value) + " for datatype ID " + str(datatype_ID) + ".")

    except mysql.connector.Error as error:
        print("[ERROR] Failed to insert into MySQL table {}".format(error))

    finally:
        if (connection.is_connected()):
            cursor.close()
            connection.close()

def uplink_callback(msg, client):
    '''

    '''
    payload_hexa = base64.b64decode(msg.payload_raw).hex()

    try:
        data = parse_payload(payload_hexa)
        for key in data:
            write_data_to_db(data[key], msg.hardware_serial, key)
    except ValueError as error:
        print(error)

        
    print("[INFO] Uplink from device EUI " + str(msg.hardware_serial) + " successfully recorded in the database.")



#main
print("**** Teaching-HEIGVD-IOT-2020-Project-Air-Quality@PARSER ****")

datatypes = fetch_datatypes()
print("[INFO] Datatypes successfully fetched from the database.")

handler = ttn.HandlerClient(app_id, access_key)
mqtt_client = handler.data()
mqtt_client.set_uplink_callback(uplink_callback)
print("[INFO] Successfully connected to The Things Network API.")

print("[INFO] Waiting for uplinks...")
while True:
    mqtt_client.connect()
    time.sleep(60)

mqtt_client.close()