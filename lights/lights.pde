// Lets light some lights
//
//
int ledAnalogOne[] = {3, 5, 6}; //the three pins of the first analog LED 3 = redPin, 5 = greenPin, 6 = bluePin
//These pins must be PWM
int ledAnalogTwo[] = {9, 10, 11}; //the three pins of the second analog LED 9 = redPin, 10 = greenPin, 11 = bluePin

//Defined Colors (different RGB (red, green, blue) values for colors
//(to add your own ie. fuscia experiment and then add to the list)
const byte RED[] = {255, 0, 0};
const byte ORANGE[] = {83, 4, 0};
const byte YELLOW[] = {255, 255, 0};
const byte GREEN[] = {0, 255, 0};
const byte BLUE[] = {0, 0, 255};
const byte INDIGO[] = {4, 0, 19};
const byte VIOLET[] = {23, 0, 22};
const byte CYAN[] = {0, 255, 255};
const byte MAGENTA[] = {255, 0, 255};
const byte WHITE[] = {255, 255, 255};
const byte BLACK[] = {0, 0, 0};
const byte PINK[] = {158, 4, 79};
 
//---eof---RGBL-Analog Preamble
// Extern my functions so they are available
extern void setColor(int* led, byte* color);
extern void setColor(int* led, const byte* color);

void setup(){
  for(int i = 0; i < 3; i++){
    pinMode(ledAnalogOne[i], OUTPUT);
    //Set the three LED pins as outputs
    pinMode(ledAnalogTwo[i], OUTPUT);
    //Set the three LED pins as outputs
  }
  setColor(ledAnalogOne, BLACK);
  //Turn off led 1
  setColor(ledAnalogTwo, BLACK);
  //Turn off led 2
}

void loop() {
     setColor(ledAnalogOne, RED);
     delay(1000);
     setColor(ledAnalogOne, GREEN);
     delay(1000);
     setColor(ledAnalogOne, BLUE);
     delay(1000);
     setColor(ledAnalogOne, BLACK);
     delay(500);
} 

/* Sets the color of the LED to any RGB Value
led - (int array of three values defining the LEDs pins (led[0] = redPin, led[1] = greenPin, led[2] = bluePin))
color - (byte array of three values defing an RGB color to display (color[0] = new Red value, color[1] = new Green value, color[2] = new Red value*/
void setColor(int* led, byte* color){
  for(int i = 0; i < 3; i++){
    //iterate through each of the three pins (red green blue)
    analogWrite(led[i], 255 - color[i]);
  //set the analog output value of each pin to the input value (ie led[0] (red pin) to 255- color[0] (red input color)
  //we use 255 - the value because our RGB LED is common anode, this means a color is full on when we output analogWrite(pin, 0)
  //and off when we output analogWrite(pin, 255).
  }
}

/* A version of setColor that takes a predefined color
(neccesary to allow const int pre-defined colors */
void setColor(int* led, const byte* color){
  byte tempByte[] = {color[0], color[1], color[2]};
  setColor(led, tempByte);
}
