// This example demonstrates CmdMessenger's callback  & attach methods
// For Arduino Uno and Arduino Duemilanove board (may work with other)

#include <stdint.h>
// Download these into your Sketches/libraries/ folder...
using namespace std;

// CmdMessenger library available from https://github.com/dreamcat4/cmdmessenger
#include <CmdMessenger/CmdMessenger.h>

// Base64 library available from https://github.com/adamvr/arduino-base64
#include <Base64/Base64.h>

// Streaming4 library available from http://arduiniana.org/libraries/streaming/
#include <streaming/Streaming.h>

// Include my lights lib
#include <lights.h>
using namespace Arduino::Lights;

// Mustnt conflict / collide with our message payload data. Fine if we use base64 library ^^ above
char field_separator = ',';
char command_separator = ';';

// Attach a new CmdMessenger object to the default Serial port
CmdMessenger cmdMessenger = CmdMessenger(Serial, field_separator, command_separator);

// Create triColour LED to play with
byte lid[] = { 3, 5, 6};
TriColour triColour0 = TriColour(lid);


// ------------------ S E R I A L  M O N I T O R -----------------------------
// 
// Try typing these command messages in the serial monitor!
// 
// 4,hi,heh,ho!;
// 5;
// 5,dGhlIGJlYXJzIGFyZSBhbGxyaWdodA==;
// 5,dGhvc2UgbmFzdHkgY29udHJvbCA7OyBjaGFyYWN0ZXJzICws==;
// 2;
// 6;
// 
// 
// Expected output:
// 
// 1,Arduino ready;
// 1,bens cmd recieved;
// 1,hi;
// 1,heh;
// 1,ho!;
// 1,jerrys cmd recieved;
// 1,"the bears are allright" encoded in base64...;
// 1,dGhlIGJlYXJzIGFyZSBhbGxyaWdodA==;
// 1,jerrys cmd recieved;
// 1,what you send me, decoded base64...;
// 1,the bears are allright;
// 1,jerrys cmd recieved;
// 1,what you send me, decoded base64...;
// 1,those nasty control ;; characters ,,;
// 1,Arduino ready;
// 3,Unknown command;
// 


// ------------------ C M D  L I S T I N G ( T X / R X ) ---------------------

// We can define up to a default of 50 cmds total, including both directions (send + recieve)
// and including also the first 4 default command codes for the generic error handling.
// If you run out of message slots, then just increase the value of MAXCALLBACKS in CmdMessenger.h

// Commands we send from the Arduino to be received on the PC
enum
{
  kCOMM_ERROR    = 000, // Lets Arduino report serial port comm error back to the PC (only works for some comm errors)
  kACK           = 001, // Arduino acknowledges cmd was received
  kARDUINO_READY = 002, // After opening the comm port, send this cmd 02 from PC to check arduino is ready
  kERR           = 003, // Arduino reports badly formatted cmd, or cmd not recognised

  // Now we can define many more 'send' commands, coming from the arduino -> the PC, eg
  // kICE_CREAM_READY,
  // kICE_CREAM_PRICE,
  // For the above commands, we just call cmdMessenger.sendCmd() anywhere we want in our Arduino program.

  kSEND_CMDS_END, // Mustnt delete this line
};

// Define the callback methods here first to get the order right
extern void msg_callback_set_led();
extern void jerrys_base64_data();
extern void buf_to_rgb(char buffer[], byte result[3]);

// Commands we send from the PC and want to recieve on the Arduino.
// We must define a callback function in our Arduino program for each entry in the list below vv.
// They start at the address kSEND_CMDS_END defined ^^ above as 004
messengerCallbackFunction messengerCallbacks[] = 
{
  msg_callback_set_led, // 004 in this example
  jerrys_base64_data,   // 005
  NULL
};
// Its also possible (above ^^) to implement some symetric commands, when both the Arduino and
// PC / host are using each other's same command numbers. However we recommend only to do this if you
// really have the exact same messages going in both directions. Then specify the integers (with '=')


// ------------------ C A L L B A C K  M E T H O D S -------------------------

void msg_callback_set_led()
{
  // Message data is any ASCII bytes (0-255 value). But can't contain the field
  // separator, command separator chars you decide (eg ',' and ';')
  // Send <LED Number>-<Red 255><G 255><B 255> all padded.
  // eg 0-003128034
  cmdMessenger.sendCmd(kACK,"LED set cmd recieved");
  while ( cmdMessenger.available() )
  {
    char buf[350] = { '\0' };
    cmdMessenger.copyString(buf,(uint8_t) 11);
    if(buf[0])
      cmdMessenger.sendCmd(kACK, buf);
      // Here we would set the LED with this value
      if ( buf[0] == '0' )
      {
          byte newcolour[3];
          buf_to_rgb(buf, newcolour);
          triColour0.setColour(newcolour);
      }
  }
}

void buf_to_rgb(char buffer[], byte result[3]) 
{
  // Given the buffer in the format 0-RRRGGGBBB
  // Return an RGB byte array
  char num[4] = "000";
  num[0] = buffer[2];
  num[1] = buffer[3];
  num[2] = buffer[4];
  // red
  result[0] = atoi(num);
  num[0] = buffer[6];
  num[1] = buffer[7];
  num[2] = buffer[8];
  // green
  result[1] = atoi(num);
  num[0] = buffer[0];
  num[1] = buffer[10];
  num[2] = buffer[11];
  // blue
  result[2] = atoi(num);
}

void jerrys_base64_data()
{
  // To avoid conflicts with the control characters and any newline characters
  // Message length increases about 30%-40%

  // Afer base64_decode(), we just parse the buffer and unpack it into your
  // target / desination data type eg bitmask, float, double, whatever.
  boolean data_msg_printed = false;
  cmdMessenger.sendCmd(kACK,"jerrys cmd recieved");

  // base64 decode
  while ( cmdMessenger.available() )
  {
    if(!data_msg_printed)
    {
      cmdMessenger.sendCmd(kACK, "what you send me, decoded base64...");
      data_msg_printed = true;
    }
    char buf[350] = { '\0' };
    cmdMessenger.copyString(buf,(uint8_t) 350);
    if(buf[0])
    {
      char decode_buf[350] = { '\0' };
      base64_decode(decode_buf, buf, 350);
      cmdMessenger.sendCmd(kACK, decode_buf);
    }
  }

  // base64 encode
  if(!data_msg_printed)
  {
    cmdMessenger.sendCmd(kACK, "\"the bears are allright\" encoded in base64...");
    char base64_msg[350] = { '\0' };
    base64_encode(base64_msg, "the bears are allright", 22);
    cmdMessenger.sendCmd(kACK, base64_msg);
  }
}

// ------------------ D E F A U L T  C A L L B A C K S -----------------------

void arduino_ready()
{
  // In response to ping. We just send a throw-away Acknowledgement to say "im alive"
  cmdMessenger.sendCmd(kACK,"Arduino ready");
}

void unknownCmd()
{
  // Default response for unknown commands and corrupt messages
  cmdMessenger.sendCmd(kERR,"Unknown command");
}

// ------------------ E N D  C A L L B A C K  M E T H O D S ------------------



// ------------------ S E T U P ----------------------------------------------

void attach_callbacks(messengerCallbackFunction* callbacks)
{
  int i = 0;
  int offset = kSEND_CMDS_END;
  while(callbacks[i])
  {
    cmdMessenger.attach(offset+i, callbacks[i]);
    i++;
  }
}

void setup() 
{
  // Listen on serial connection for messages from the pc
  Serial.begin(57600);  // Arduino Duemilanove, FTDI Serial
  // Serial.begin(115200); // Arduino Uno, Mega, with AT8u2 USB

  // cmdMessenger.discard_LF_CR(); // Useful if your terminal appends CR/LF, and you wish to remove them
  cmdMessenger.print_LF_CR();   // Make output more readable whilst debugging in Arduino Serial Monitor
  
  // Attach default / generic callback methods
  cmdMessenger.attach(kARDUINO_READY, arduino_ready);
  cmdMessenger.attach(unknownCmd);

  // Attach my application's user-defined callback methods
  attach_callbacks(messengerCallbacks);

  arduino_ready();

  // blink
  pinMode(13, OUTPUT);
}


// ------------------ M A I N ( ) --------------------------------------------

// Timeout handling
unsigned long timeoutInterval = 2000; // 2 seconds
unsigned long previousMillis = 0;
int counter = 0;

void timeout()
{
  // blink
  if (counter % 2)
    digitalWrite(13, HIGH);
  else
    digitalWrite(13, LOW);
  counter ++;
}  

void loop() 
{
  // Process incoming serial data, if any
  cmdMessenger.feedinSerialData();

  // handle timeout function, if any
  if (  millis() - previousMillis > timeoutInterval )
  {
    timeout();
    previousMillis = millis();
  }

  // Loop.
}

