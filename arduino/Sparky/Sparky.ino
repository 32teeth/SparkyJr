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

#ifdef NEO
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
  #ifdef NEO
    neo.begin();
    neo.setBrightness(64);
    neo.show();
  #endif
  
  /*
  ** @desc Timer adjustments
  */  
  TCCR1B = TCCR1B & 0b11111000 | 0x01; 
  #if !defined(LEO) && !defined(SPECIALK)
    TCCR2B = TCCR2B & 0b11111000 | 0x01;
  #endif

  /*
  ** @desc EEPROM Allocations 
  */
  #if !defined(LEO) && !defined(SPECIALK)
    EEPROM.setMemPool(1024 , EEPROMSizeUno);  
  #else
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

  ///*
  displayIO(240, 16711680);
  displayIO(112, 16322304);
  displayIO(48, 16417024);
  displayIO(16, 4849408);

  if(digitalRead(pgm_read_byte(&inputs[4])) == 0)
  {
    displayIO(255, 16777215);
    configurator = true;
  }
  
  if(digitalRead(pgm_read_byte(&inputs[5])) == 0)
  {
    displayIO(255, 16777215);    
    MADCATZ_LAYOUT = true;
  }
 
  if(digitalRead(pgm_read_byte(&inputs[6])) == 0)
  {
    displayIO(255, 16777215);    
    HORI_LAYOUT = true;
  }  

  if(digitalRead(pgm_read_byte(&inputs[7])) == 0)
  {
    displayIO(255, 16777215);    
    OFFMODE = true;
  }    
  
  delay(1000);
  for(int n = 0; n < count; n++)
  {
    #ifndef NEO      
      digitalWrite(pgm_read_byte(&outputs[n]), LOW);
    #else
      neo.setPixelColor(n, 0, 0, 0);
    #endif        
  }    
  #ifdef NEO
    neo.show();
  #endif  
  //*/

  configurator = true;
  //MADCATZ_LAYOUT = true;
  //HORI_LAYOUT = true;
}

/*
** @method loop
** @desc main arduino loop
*/
void loop()
{
  if(!OFFMODE)
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
}
