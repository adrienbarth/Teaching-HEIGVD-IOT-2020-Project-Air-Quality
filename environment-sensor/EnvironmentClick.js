/* IOT 2020 - Projet 1 - Environment Sensor - Alic Nair - (Groupe Adrien) */

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

/* Function to wait, I got some bugs like "invalid parameters" so I put this */
function wait(ms){
   var start = new Date().getTime();
   var end = start;
   while(end < start + ms) {
     end = new Date().getTime();
  }
}

/* Initialize RN2483 card to connect with TTN */
sendToRn2483("mac set appeui 70B3D57ED002C231");
wait(2000);
sendToRn2483("mac set appkey A752A3065ABB40EDF0056A4D5E6B879E"); // A752A3065ABB40EDF0056A4D5E6B879E or 4AEFFAD7292CE4284319DC9CF452AC95
wait(2000);
sendToRn2483("mac join otaa");
wait(2000);

/* Initialize I2C pins and upload module BME680.js */
var i2c = new I2C();
i2c.setup({sda:C9, scl:A8});
var bme = require("BME680").connectI2C(i2c, {addr:0x77});

/* Function which gets data every 5 sec from sensor and print them in the following form
   To stop this function tap clearInterval(); in console.
{
  "new": true,                          // is this a new measurement?
  "temperature": 26.76,                 // degrees in °C (Celsius)
  "pressure": 936.92,                   // hPa
  "humidity": 22.97,                    // % rH
  "gas_resistance": 18452.13            // Ohms
 }
*/
var data = "";
var hex = "";

setInterval(function() {
  data = bme.get_sensor_data();
  console.log(JSON.stringify(data,null,2));
  bme.perform_measurement();

  var temp = parseInt(JSON.stringify(data.temperature));
  var pressure = parseInt(JSON.stringify(data.pressure));
  var humidity = parseInt(JSON.stringify(data.humidity));
  var gas = parseInt(JSON.stringify(data.gas_resistance));

  // Send to TTN (the 00 are only here to delimit the data)
  sendToRn2483("mac tx uncnf 10 " + temp.toString(16) + "00" + pressure.toString(16) + "00" + humidity.toString(16) + "00" + gas.toString(16));

}, 5000);

/* This instruction is needed to save the script in the MCU flash memory */
save();
