import time
import ttn
import base64
import mysql.connector
from mysql.connector import Error

app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

handler = ttn.HandlerClient(app_id, access_key)

'''
Temp            3303 = 0CE7 = 2 bytes
RH              3304 = 0CE8 = 1 bytes
Pressure        3315 = 0CF3 = 2 bytes
Concentration   3325 = 0CFD = 2 bytes

0CE712340CE8430CF354320CFDED23

'''

data_types = {}

DATA_TYPES = {3303 : {'bytes': 2, 'signed': True,  'precision': 0.1, 'unit': '°C'},
              3304 : {'bytes': 1, 'signed': False, 'precision': 0.5, 'unit': '%'},
              3315 : {'bytes': 2, 'signed': False, 'precision': 0.1, 'unit': 'hPa'},
              3325 : {'bytes': 2, 'signed': False, 'precision': 1,   'unit': 'ppm'}}

def parse_payload(payload):
    '''
    Parse a payload
    :param payload: the payload to parse in hexadecimal
    :return: A map of key-value with the data
    '''
    data = {}

    while payload:
        # Extract the data type
        data_type = int(payload[:4], 16)
        payload = payload[4:]

        # Verifying if we know this data type
        if data_type not in DATA_TYPES:
            raise ValueError("Wrong data type received, unable to parse the payload...")
        DATA_TYPE_SPEC = DATA_TYPES[data_type]

        # Extract the value and convert it
        value = int(payload[:DATA_TYPE_SPEC['bytes'] * 2], 16)
        payload = payload[DATA_TYPE_SPEC['bytes'] * 2:]
        value = value * DATA_TYPE_SPEC['precision']

        # Add the value to the dataset
        data.update( {data_type : value} )

    return data


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
    print(msg)
    payload_hexa = base64.b64decode(msg.payload_raw).hex()

    try:
        data = parse_payload(payload_hexa)
        print(data)
        #write_to_database(data, device_serial)
    except ValueError as error:
        print(error)

    #value = int(str(base64.b64decode(msg.payload_raw).hex()),16)
    print(value)
    sensor_id = msg.port
    writeToDB(sensor_id, value)

def main():
    print("Teaching-HEIGVD-IOT-2020-Project-Air-Quality@PARSER")

    # Fetching data types from db..

    #

if __name__ == "__main__":
    main()


# using mqtt client
mqtt_client = handler.data()
mqtt_client.set_uplink_callback(uplink_callback)
while True:
    mqtt_client.connect()

    time.sleep(60)

mqtt_client.close()
