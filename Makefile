# ----------
BOARD = atmega328
PORT = /dev/ttyUSB0
#INC_DIRS = ../common
INC_DIRS = CmdMessenger streaming Base64
#LIB_DIRS = ../libraries/Task ../../libraries/VirtualWire
LIB_DIRS = CmdMessenger streaming Base64
# ----------
#
# Where:
#   BOARD    : Arduino board type, from $(ARD_HOME)/hardware/boards.txt
#   PORT     : USB port
#   INC_DIRS : List pf directories containing header files
#   LIB_DIRS : List of directories containing library source
#
# Before using this Makefile you can adjust the following macros to suit
# your environment, either by editing this file directly or by defining them in
# the Makefile that includes this one, in which case they will override the
# definitions below:
#   ARD_REV      : arduino software revision, e.g. 0017, 0018
ARD_REV = 0022
ARD_HOME = /usr/share/arduino/
ARD_BIN = /usr/bin/
#   ARD_HOME     : installation directory of the Arduino software.
#   ARD_BIN      : location of compiler binaries
#   AVRDUDE      : location of avrdude executable
#   AVRDUDE_CONF : location of avrdude configuration file
#   PROGRAMMER   : avrdude programmer type
#   MON_SPEED    : serial monitor speed
#   EXTRA_FLAGS  : any extra flags that should be passed to the compilers
#

include Makefile.master
