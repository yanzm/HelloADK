#include <Wire.h>

#include <Max3421e.h>
#include <Usb.h>
#include <AndroidAccessory.h>

#define  LED       24

AndroidAccessory acc("uPhyca",
		     "HelloADK",
		     "DemoKit Arduino Board",
		     "1.0",
		     "http://www.android.com",
		     "0000000012345678");

void setup();
void loop();

void init_leds()
{
    // 24 の DIGITAL を LED 用の出力にする
    pinMode(LED, OUTPUT);
}

void setup()
{
    Serial.begin(115200);
    Serial.print("\r\nStart");

    init_leds();

    acc.powerOn();
}

void loop()
{
    byte msg[2];
    byte led;

    if (acc.isConnected()) {
        int len = acc.read(msg, sizeof(msg), 1);

        if (len > 0) {
            if (msg[0] == 0x1) {
                if(msg[1] == 0x1) {
                    digitalWrite(LED, HIGH);
                    msg[0] = 0x1;
                    msg[1] = 0x1;
                    acc.write(msg, 2);
                }
                else {
                    digitalWrite(LED, LOW);
                    msg[0] = 0x1;
                    msg[1] = 0x2;
                    acc.write(msg, 2);
                }
            }
        }
    } 
    else {
        digitalWrite(LED, LOW);
    }

    delay(10);
}


