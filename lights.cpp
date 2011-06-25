#include <stdint.h>
#include "WProgram.h"

namespace arduino {
    namespace lights {
                static const byte RED[] = {255, 0, 0};
                static const byte ORANGE[] = {83, 4, 0};
                static const byte YELLOW[] = {255, 255, 0};
                static const byte GREEN[] = {0, 255, 0};
                static const byte BLUE[] = {0, 0, 255};
                static const byte INDIGO[] = {4, 0, 19};
                static const byte VIOLET[] = {23, 0, 22};
                static const byte CYAN[] = {0, 255, 255};
                static const byte MAGENTA[] = {255, 0, 255};
                static const byte WHITE[] = {255, 255, 255};
                static const byte BLACK[] = {0, 0, 0};
                static const byte PINK[] = {158, 4, 79};
        class TriColour {
            public:
            //Defined colours (different RGB (red, green, blue) values for colours
            //(to add your own ie. fuscia experiment and then add to the list)

                TriColour(const byte* led_pins ) 
                    {
                        byte _led_pins[] = { led_pins[0], led_pins[1], led_pins[2] };
                    }

                /* Sets the colour of the LED to any RGB Value
                colour - (byte array of three values defing an RGB colour to display (colour[0] = new Red value, colour[1] = new Green value, colour[2] = new Red value*/
                void setColour(byte* colour ) {
                  for(int i = 0; i < 3; i++){
                    //iterate through each of the three pins (red green blue)
                    analogWrite(_led_pins[i], 255 - colour[i]);
                    //set the analog output value of each pin to the input value (ie led[0] (red pin) to 255- colour[0] (red input colour)
                    //we use 255 - the value because our RGB LED is common anode, this means a colour is full on when we output analogWrite(pin, 0)
                    //and off when we output analogWrite(pin, 255).
                  }
                }
                /* A version of setcolour that takes a predefined colour
                (neccesary to allow const int pre-defined colours */
                void setColour(const byte* colour){
                  byte tempByte[] = {colour[0], colour[1], colour[2]};
                  setColour(tempByte);
                }
             private:
                 byte _led_pins[];
          };
     }
}


