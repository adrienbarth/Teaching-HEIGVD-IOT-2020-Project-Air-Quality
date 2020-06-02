import mysql.connector
import ttn
import argparse

from .datatype import DataType
from mysql.connector import Error
from flask import request, jsonify
from app import app

app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

# Argument parsing
'''
parser = argparse.ArgumentParser(description='Teaching-HEIGVD-IOT-2020-Project-Air-Quality@PARSER')
parser.add_argument("--host",     help="Database host")
parser.add_argument("--schema",   help="Database schema")
parser.add_argument("--user",     help="Database username")
parser.add_argument("--password", help="Datapase user password")
args, _ = parser.parse_args()
'''
datatypes = {}

@app.route('/event', methods=['POST'])
def event_handler():
    '''
    Handler for route /event.
    '''
    req_json = request.get_json()

    try:
        # Checking payload format
        if 'data_type' not in req_json:
            raise ValueError("Missing data_type key in JSON.")

        if 'data' not in req_json:
            raise ValueError("Missing data key in JSON.")

        data_type = req_json['data_type']
        data = req_json['data']

        print("[DEBUG] Event for datatype '" + data_type + "' received.")

        # Checking if we are intersted with that datatype
        for dt in datatypes.values():
            if dt.name == data_type and dt.downlink_device_id:
                send_downlink(dt.downlink_device_id, req_json)
        
    except ValueError as error:
        print("[WARNING] Event ignored due to unrecognized JSON format: " + str(req_json))
        return str(error)

    return "Event received."

def send_downlink(device_id, msg):
    '''
    Send a downlink to a device.
    '''
    handler = ttn.HandlerClient(app_id, access_key)
    mqtt_client = handler.data()
    mqtt_client.connect()
    mqtt_client.send(dev_id=device_id,  pay=msg, port=1, conf=True, sched="replace")
    mqtt_client.close()
    print("[DEBUG] Downlink has been sent to device '" + device_id + "'")

datatypes = DataType.get_all("127.0.0.1", "iot2020", "root", "T2sF8fxIK7ctLS0kR1gT")