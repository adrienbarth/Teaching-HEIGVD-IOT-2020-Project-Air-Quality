/* IOT 2020 - Projet 2 - Environment Sensor - Alic Nair - (Groupe Adrien) */

/* RN2483 must be plugged in slot #2 !!! */

/* See https://download.mikroe.com/documents/starter-boards/clicker-2/stm32f4/clicker2-stm32-manual-v100.pdf
for board full schematic and pins assignment */

var serialRxData = "";

/* Serial port initialisation (the "/25*8" is a work-around because of bad
internal clock initialisation) */
Serial3.setup(57600/25*8, { tx:D8, rx:D9 });

/* RN2483 reset function - calling this function should print something
like "RN2483 1.0.4 Oct 12 2017 14:59:25" */
function resetRn2483(){
  pinMode(E13, "output");
  digitalWrite(E13, 1);
  digitalPulse(E13, 0, 200);
}

/* Function to wait, I got some bugs when sendind command like "invalid parameters" so I put this to correct.. */
function wait(ms){
   var start = new Date().getTime();
   var end = start;
   while(end < start + ms) {
     end = new Date().getTime();
  }
}

/* Initialize RN2483 card to connect with TTN */
function initRN2483(appeui, appkey) {
  sendToRn2483("mac set appeui " + appeui);
  wait(1000);
  sendToRn2483("mac set appkey " + appkey); 
  wait(1000);
  sendToRn2483("mac join otaa");
  wait(5000);
}

/* This is the callback called when character appears on the serial port */
Serial3.on('data', function(data) {
  serialRxData = serialRxData + data;
  if(serialRxData.indexOf("\r\n") != -1) {
    console.log(serialRxData);
    serialRxData = "";
  }
});

/* Send a string to RN2483 with the syntax "sendToRn2483("COMMAND_TO_SEND")".
The <CR><LF> characters are automatically added by the Serial3.println() function
See https://ww1.microchip.com/downloads/en/DeviceDoc/40001784B.pdf for full
command reference */
function sendToRn2483(string) {
  console.log("Command sent: "+ string);
  Serial3.println(string);
}

/* The onInit() function is called at board reset */
function onInit() {
  console.log("========== Program started ==========\r\n");
  resetRn2483();
}

/* Wait some seconds after reset because card need to initialize */
setTimeout(function () {
  console.log("========== Connecting to TTN ==========\r\n");
  initRN2483("70B3D57ED002C231", "A752A3065ABB40EDF0056A4D5E6B879E");
}, 2000);

/* Initialize I2C pins and upload module BME680.js */
var i2c = new I2C();
i2c.setup({sda:C9, scl:A8});
var bme = require("BME680").connectI2C(i2c, {addr:0x77});

/* Function which gets data every 5 mins from sensor and print them in the following form
   To stop this function tap clearInterval(); in console.
{
  "new": true,                          // is this a new measurement?
  "temperature": 26.76,                 // degrees in °C (Celsius)
  "pressure": 936.92,                   // hPa
  "humidity": 22.97,                    // % rH
  "gas_resistance": 18452.13            // Ohms
 }
*/
setInterval(function() {
  var data = "";
  data = bme.get_sensor_data();
  console.log(JSON.stringify(data,null,2));
  bme.perform_measurement();

  var temp = parseInt(parseFloat(JSON.stringify(data.temperature)) * 10);
  var tempStr = "";
  if((temp & 0x8000) > 0) // if not zéro temparture is negative
  {
    temp = temp + 0x10000;
    tempStr = temp.toString(16);
  }
  tempStr = temp.toString(16);
  if(tempStr.length  == 1) {tempStr = "000" + tempStr;} else if(tempStr.length == 2) {tempStr = "00" + tempStr;} else {tempStr = "0" + tempStr;}

  // In case we have small numbers, we add a zero in front to have 1 byte
  var humidity = parseInt(parseFloat(JSON.stringify(data.humidity) * 2));
  var humidityStr = humidity.toString(16);
  if(humidityStr.length != 2) {humidityStr = "0" + humidityStr;}

  // Pressure
  var pressure = parseInt(parseFloat(JSON.stringify(data.pressure) * 10));

  // Send data to TTN using LwM2M Objects ID like seen in course
  sendToRn2483("mac tx uncnf 1 0ce7" + tempStr + "0ce8" + humidityStr + "0cf3" + pressure.toString(16));

}, 300000); // 300000 ms = 5 min

/* This instruction is needed to save the script in the MCU flash memory */
save();
