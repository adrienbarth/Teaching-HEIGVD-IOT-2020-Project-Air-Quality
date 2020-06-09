import mysql.connector
import base64
import re
import ttn

from mysql.connector import Error
from flask import request, jsonify, Flask

app = Flask(__name__)

app_id = "groupe-adrien"
access_key = "ttn-account-v2.yxmXtnn1KRl6VrkLoHSEF0_6kBsjBBLsP8QopR-q6Vo"

db_host = "air-quality-db"
db_schema = "iot2020"
db_user = "root"
db_password = "T2sF8fxIK7ctLS0kR1gT"

datatypes = {}

class DataType:
    """ Represent an IOT data type """

    def __init__(self, xml_id, name, data_bytes, data_signed, data_resolution_per_bit, unit, event_api_host, event_api_port, event_api_path, downlink_device_id):
        self.xml_id = xml_id
        self.name = name
        self.data_bytes = data_bytes
        self.data_signed = data_signed
        self.data_resolution_per_bit = data_resolution_per_bit
        self.unit = unit
        self.event_api_host = event_api_host
        self.event_api_port = event_api_port
        self.event_api_path = event_api_path
        self.downlink_device_id = downlink_device_id

    def __str__(self):
        return "<%s: name=\"%s\", unit=\"%s\", event_api=\"%s\">" % (self.xml_id, self.name, self.unit, self.get_event_url())
        

    def get_event_url(self):
        if not self.event_api_host:
            return None
            
        return "http://" + str(self.event_api_host) + ":" + str(self.event_api_port) + str(self.event_api_path)

    @staticmethod
    def get_all(host, database, user, password):
        '''

        '''

        # DB request
        try:
            connection = mysql.connector.connect(host=host, database=database, user=user, password=password)
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM data_types")
            columns = cursor.description
            results = [{columns[index][0]:column for index, column in enumerate(value)} for value in cursor.fetchall()]
        except mysql.connector.Error as err:
            print("[ERROR] Something went wrong: {}".format(err))
            raise
        finally:
            if connection.is_connected():
                cursor.close()
                connection.close()
        
        # Parsing DB results
        datatypes = {}
        for x in results:
            datatype = DataType(
                x['xml_id'],
                x['name'],
                x['data_bytes'],
                x['data_signed'],
                x['data_resolution_per_bit'],
                x['unit'],
                x['event_api_host'],
                x['event_api_port'],
                x['event_api_path'],
                x['downlink_device_id'])
            datatypes.update( { x['xml_id'] : datatype })

        return datatypes

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
                payload = None

                if dt.xml_id == 3336:
                    latitude = None
                    longitude = None

                    for x in data:
                        if 'latitude' in x:
                            latitude = x['latitude']
                        if 'longitude' in x:
                            longitude = x['longitude']

                    lat = int(float(convert_coord_str(latitude, latitude[-1:])) / dt.data_resolution_per_bit)
                    lon = int(float(convert_coord_str(longitude, longitude[-1:])) / dt.data_resolution_per_bit)
                    payload = str(format(dt.xml_id, '04x')) + str(hex2(lat)) + str(hex2(lon))

                if dt.xml_id == 3324 and 'voltage' in data[0]:
                    voltage = int(float(data[0]["voltage"]) / dt.data_resolution_per_bit)
                    payload = str(format(dt.xml_id, '04x')) + str(format(voltage, '04x'))

                if payload:
                    send_downlink(dt.downlink_device_id, payload)
        
    except ValueError as error:
        print("[WARNING] Event ignored due to unrecognized JSON format: " + str(req_json))
        return str(error)

    return "Event received."

def hex2(n):
    return "%s"%("000000%x"%(n&0xffffff))[-6:]

def convert_coord_str(coord, dir):
    dms = re.findall(r"[-+]?\d*\.\d+|\d+", coord)
    decimal = float(dms[0]) + float(float(dms[1])/60.0) + float(float(dms[2])/3600.0)
    if dir == 'W' or dir == 'S':
        decimal = -1.0 * decimal
    return decimal

def send_downlink(device_id, msg):
    '''
    Send a downlink to a device.
    '''
    handler = ttn.HandlerClient(app_id, access_key)
    mqtt_client = handler.data()
    mqtt_client.connect()
    mqtt_client.send(dev_id=device_id,  pay=msg, port=1, conf=False, sched="replace")
    mqtt_client.close()
    print("[DEBUG] Downlink " + str(msg) + " has been sent to device '" + device_id + "'")

datatypes = DataType.get_all(db_host, db_schema, db_user, db_password)