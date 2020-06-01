from flask import Flask, request, jsonify
import mysql.connector
from mysql.connector import Error
import ttn

app = Flask(__name__)
app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

# MySQL
db_host =     'air-quality-db'
db_schema =   'iot2020'
db_user =     'root'
db_password = 'T2sF8fxIK7ctLS0kR1gT'

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
        for dt in datatypes:
            if datatypes[dt]['name'] == data_type and datatypes[dt]['device_EUI']:
                send_downlink(datatypes[dt]['device_EUI'], req_json)
        
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

def fetch_datatypes():
    '''
    Fetch datatypes from the database and return a dictionary of data types.
    '''
    try:
        mysql_con = mysql.connector.connect(host=db_host, database=db_schema, user=db_user, password=db_password)
        cursor = mysql_con.cursor()
        cursor.execute("SELECT * FROM data_types")
        results = cursor.fetchall()
    except mysql.connector.Error as error:
        print("Failed to insert into MySQL table {}".format(error))
    finally:
        if mysql_con.is_connected():
            cursor.close()
            mysql_con.close()
    
    data = {}
    for x in results:
        print("[DEBUG] Datatype found: " + str(x))
        data.update( {x[0] : {'name' : x[1], 'bytes' : x[2], 'signed' : x[3], 'accuracy' : x[4], 'unit' : x[5], 'event_url': x[6], 'device_EUI': x[7]}})

    return data

datatypes = fetch_datatypes()