/*
** @author Eugene Andruszczenko
** @version 0.1
** @date December 3rd, 2013
** @desc SparkyFive 
*/

/*
** @define (LEO|UNO|JOY|RAZER)
** @desc LEO = Arduino Leonardo
** @desc SPARKY = SparkyJrFTDI
** @desc UNO = Arduino UNO
** @desc JOY = Arduino Joystick Shield
** @desc RAZER = Razer Atrox Arcade Stick
*/
#define RAZER

/*
** @desc include utility
*/
int* xrgb;
int rgb[] = {0,0,0};
int prgb[] = {0,0,0};
int in[] = {0,0,0};
int out[] = {0,0,0};

#include "utility.h"

/*
** @desc include colors
*/
#include "colors.h"

/*
** @desc assign color values
*/
long int color;
long int colors[14] = {RED, ORANGE, YELLOW, GREEN, LIME, TEAL, AQUA, TURQUOISE, NAVY, BLUE, INDIGO, PURPLE, PINK, WHITE};

/*
** @desc assign eeprom values
*/
long int empty = 4294967295;
int addressLong;
int addressMax = 1016;
/*
** @desc include eeprom files
*/
#include <EEPROMex.h>
#include "eeprom.h";

/*
** @desc configurator mode
*/
boolean configurator = false;

/*
** @desc command
*/
String command;

/*
** @desc IO
*/
int address;
int states[] = {0,0,0,0,0,0,0,0};
int stored[] = {0,0,0,0,0,0,0,0};
String state;
float duration = 250;
float now = millis();
float changed = now;

#define CATHODE
//#define ANODE
#ifdef CATHODE
  int ON = HIGH;
  int OFF = LOW;
#endif
#ifdef ANODE
  int ON = LOW;
  int OFF = HIGH;
#endif

#include "io.h"

/*
** @desc layouts
*/
#include "layout.h"
boolean MADCATZ_LAYOUT = false;
boolean HORI_LAYOUT = false;

/*
** @desc include programming and help files
*/
#include "help.h";
#include "programming.h";

/*
** @desc uncomment to run Serial Monitor
*/
//#define SERIAL

/*
** @method setup
** @desc main arduino setup
*/
void setup()
{
  /*
  ** @desc Timer adjustments
  */  
  TCCR1B = TCCR1B & 0b11111000 | 0x01; 
  #ifdef UNO
    TCCR2B = TCCR2B & 0b11111000 | 0x01;
  #endif
  #ifdef RAZER
    TCCR2B = TCCR2B & 0b11111000 | 0x01;
  #endif   

  /*
  ** @description EEPROM Allocations 
  */
  #ifdef UNO
    EEPROM.setMemPool(1024 , EEPROMSizeUno);  
  #endif
  #ifdef RAZER
    EEPROM.setMemPool(1024 , EEPROMSizeUno);  
  #endif  
  #ifdef LEO
    EEPROM.setMemPool(1024 , EEPROMSizeATmega32u4);
  #endif 
  EEPROM.setMaxAllowedWrites(1024);
  addressLong = EEPROM.getAddress(sizeof(long));
  
  delay(1000);
  if(getLongEEPROM(0) == empty){randomEEPROM();}
  
  /*
  ** @desc set io functionality
  */  
  setIO();
  
  /*
  ** 
  */
  #ifdef SERIAL
    Serial.begin(115200);
    while (!Serial) {
      ; // wait for serial port to connect. Needed for Leonardo only
    }  
  #endif  
  
  demoIO();
  
  /*
  ** @desc set configurator to true to test programming mode
  */
  configurator = false;
  MADCATZ_LAYOUT = false;
  HORI_LAYOUT = false;  
}

void loop()
{
  if(configurator)
  {
    programming();
  }
  else
  {
    if(!MADCATZ_LAYOUT && !HORI_LAYOUT)
    {
      watchIO();
      now = millis();
    }
    else
    {
      if(MADCATZ_LAYOUT)
      {
        madcatz();
      }
      if(HORI_LAYOUT)
      {
        hori();
      }
    }
  }
}
