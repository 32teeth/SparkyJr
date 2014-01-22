/*
** @author Eugene Andruszczenko
** @version 0.1
** @date December 3rd, 2013
** @description SparkyFive 
*/

/*
** @define (LEO|UNO|JOY|RAZER)
** @description LEO = Arduino Leonardo
** @description UNO = Arduino UNO
** @description JOY = Arduino Joystick Shield
** @description RAZER = Razer Atrox Arcade Stick
*/
#define RAZER

/*
** @description include utility
*/
#include "utility.h"

/*
** @description include colors
*/
#include "colors.h"

/*
** @description assign color values
*/
long int color;
long int colors[14] = {RED, ORANGE, YELLOW, GREEN, LIME, TEAL, AQUA, TURQUOISE, NAVY, BLUE, INDIGO, PURPLE, PINK, WHITE};
int* rgb;
int* fade;

/*
** @description assign eeprom values
*/
long int empty = 4294967295;
int addressLong;
int addressMax = 1016;
/*
** @description include eeprom files
*/
#include <EEPROMex.h>
#include "eeprom.h";

/*
** @description configurator mode
*/
boolean configurator = false;

/*
** @description command
*/
String command;

/*
** @description IO
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
** @description include programming and help files
*/
#include "help.h";
#include "programming.h";

/*
** @description uncomment to run Serial Monitor
*/
//#define SERIAL

/*
** @method setup
** @description main arduino setup
*/
void setup()
{
  /*
  ** @description Timer adjustments
  */  
  TCCR1B = TCCR1B & 0b11111000 | 0x01; 
  #ifdef UNO || #ifdef RAZER
    TCCR2B = TCCR2B & 0b11111000 | 0x01;
  #endif  
 
  /*
  ** @description EEPROM Allocations 
  */
  #ifdef UNO || #ifdef RAZER
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
  ** @description set io functionality
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
  
  //demoIO();
  
  /*
  ** @description set configurator to true to test programming mode
  */
  configurator = true;
}

void loop()
{
  if(configurator)
  {
    programming();
  }
  else
  {
    watchIO();
    now = millis();
  }
}
