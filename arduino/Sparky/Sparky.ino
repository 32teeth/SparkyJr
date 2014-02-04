/*
** @author Eugene Andruszczenko
** @version 0.1
** @date December 3rd, 2013
** @desc SparkyFive 
*/

/*
** @desc include setup
** @desc change your settings in this file
*/
#include "setup.h"

#ifdef DRIVER
  #include <Adafruit_NeoPixel.h>
  Adafruit_NeoPixel neo = Adafruit_NeoPixel(8, data, NEO_RGB + NEO_KHZ800);
#endif

/*
** @desc include utility
*/
#include "utility.h"

/*
** @desc include colors
*/
#include "colors.h"

/*
** @desc include eeprom files
*/
#include <EEPROMex.h>
#include "eeprom.h";

#include "io.h"

/*
** @desc layouts
*/
#include "layout.h"

/*
** @desc include programming and help files
*/
#include "help.h";
#include "programming.h";

/*
** @method setup
** @desc main arduino setup
*/
void setup()
{
  /*
  ** @desc start
  */  
  #ifdef DRIVER
    neo.begin();
    neo.setBrightness(64);
    neo.show();
  #endif
  
  /*
  ** @desc Timer adjustments
  */  
  TCCR1B = TCCR1B & 0b11111000 | 0x01; 
  #ifdef UNO || #ifdef RAZER || #ifdef DRIVER
    TCCR2B = TCCR2B & 0b11111000 | 0x01;
  #endif

  /*
  ** @desc EEPROM Allocations 
  */
  #ifdef UNO || #ifdef RAZER || #ifdef DRIVER
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
  ** @desc run intro
  */
  //#define INTRO
  #ifdef INTRO
    introIO();
  #endif
  
  configurator = true;
}

/*
** @method loop
** @desc main arduino loop
*/
void loop()
{
  if(configurator){programming();}
  else
  {
    if(!MADCATZ_LAYOUT && !HORI_LAYOUT)
    {
      watchIO();
      now = millis();
    }
    else
    {
      if(MADCATZ_LAYOUT){madcatz();}
      if(HORI_LAYOUT){hori();}
    }
  }
}
