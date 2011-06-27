#include <stdint.h>
#include "WProgram.h"

namespace Arduino {
    namespace Lights {
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
                TriColour(const byte led_pins[3] ) ;

                void setColour(byte* colour );
                void setColour(const byte* colour);
             private:
                 byte d_led_pins[];
          };
     }
}


