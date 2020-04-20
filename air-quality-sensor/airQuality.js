/* RN2483 must be plugged in slot #2 !!! */

/* See https://download.mikroe.com/documents/starter-boards/clicker-2/stm32f4/clicker2-stm32-manual-v100.pdf
for board full schematic and pins assignment */

var serialRxData = "";
var i2c = null;

/* Serial port initialisation (the "/25*8" is a work-around because of bad
internal clock initialisation) */
Serial3.setup(57600/25*8, { tx:D8, rx:D9 });

// Calcule du CRC
function computeCrc(dataArray, arrayLengthInByte) {
    var generator = 0x31;
    var crc = 0xFF;

    for(var i = 0; i < arrayLengthInByte; i++) {
        crc ^= dataArray[i];

        for (var j = 0; j < 8; j++) {
            if ((crc & 0x80) !== 0) {
                crc = ((crc << 1) ^ generator);
            }
            else {
                crc <<= 1;
            }
        }
    }
    return crc & 0x000000FF;
}

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
  setTimeout(function(){
    ttnConnection();
    setTimeout(function(){
      initComponent();
      setTimeout(function(){
        sendData();
      },1000);
    },1000);
  },1000);
}

// Permet d'effectuer la connexion à The Things Network
function ttnConnection(){
  //Initialisation de la connexion avec TTN
  sendToRn2483("mac set appeui 70B3D57ED002C231");
  setTimeout(function(){
    sendToRn2483("mac set appkey DBA0D74F286BE8805FAA72ECCCF24EBC");
    setTimeout(function(){
      sendToRn2483("mac join otaa");
    }, 200);
  }, 200);  
}

// Initialisation du capteur
function initComponent(){
  i2c = new I2C();
  i2c.setup({sda:C9,scl:A8});
  
  //SoftReset
  i2c.writeTo(0x00, 0x06);

  //Init 
  setTimeout(function(){
    i2c.writeTo(0x58, [0x20, 0x03]);
  },100);
}

// Envoie des données à TTN
function sendData(){
  //Récupération des données
  setInterval(function(){
    i2c.writeTo(0x58, [0x20, 0x08]);
    setTimeout(function(){
      var baseline = i2c.readFrom(0x58, 6);
      console.log(baseline);
      sendToRn2483("mac tx uncnf 100 " + baseline[1].toString(16) + baseline[4].toString(16));
    },12);
  }, 100);
}


/* This instruction is needed to save the script in the MCU flash memory */
save();
