import mysql.connector

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