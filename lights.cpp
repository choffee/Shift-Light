#include <stdint.h>
#include "WProgram.h"
#include "lights.h"

using namespace Arduino::Lights;

Arduino::Lights::TriColour::TriColour(const byte led_pins[3] ) 
    {
        d_led_pins[0] =  led_pins[0];
        d_led_pins[1] =  led_pins[1];
        d_led_pins[2] =  led_pins[2];
    }

                /* Sets the colour of the LED to any RGB Value
                colour - (byte array of three values defing an RGB colour to display (colour[0] = new Red value, colour[1] = new Green value, colour[2] = new Red value*/
void Arduino::Lights::TriColour::setColour(byte* colour ) {
  for(int i = 0; i < 3; i++){
    //iterate through each of the three pins (red green blue)
    analogWrite(d_led_pins[i], 255 - colour[i]);
    //set the analog output value of each pin to the input value (ie led[0] (red pin) to 255- colour[0] (red input colour)
    //we use 255 - the value because our RGB LED is common anode, this means a colour is full on when we output analogWrite(pin, 0)
    //and off when we output analogWrite(pin, 255).
  }
}
                /* A version of setcolour that takes a predefined colour
                (neccesary to allow const int pre-defined colours */
void Arduino::Lights::TriColour::setColour(const byte* colour){
  byte tempByte[] = {colour[0], colour[1], colour[2]};
  setColour(tempByte);
}


