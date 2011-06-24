ARDUINO_DIR = /home/john/workspace/shiftkey/arduino
AVR_TOOLS_PATH = /usr/bin/
ARDUINO_ETC_PATH = /usr/share/arduino/hardware/tools/

ARDUINO_LIBS = Base64 streaming CmdMessenger


TARGET=shiftkey

MCU          = atmega328p
F_CPU        = 16000000
ARDUINO_PORT = /dev/ttyUSB*

AVRDUDE_ARD_PROGRAMMER = arduino
AVRDUDE_ARD_BAUDRATE   = 57600

include arduino/Arduino.mk
