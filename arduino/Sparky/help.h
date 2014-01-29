/*
** @method help
** @desc typing help into the serial monitor starts the serial and prints the command list below
*/

void help()
{
  Serial.print(F(" Sparky\n"));
  Serial.print(F("------------------------------------------------------\n"));
  
  Serial.print(F("\nEEPROM\n"));
  Serial.print(F("\n@command erase\n"));  
  Serial.print(F(" @desc clears out all EEPROM data\n"));
  Serial.print(F(" @example erase\n"));

  Serial.print(F("\n@command print\n"));  
  Serial.print(F(" @desc prints out all EEPROM data\n"));
  Serial.print(F(" @example print\n"));  
  
  Serial.print(F("\n@command set\n"));  
  Serial.print(F(" @desc set a specific EEPROM address block value\n"));
  Serial.print(F(" @param address {int} color {long}\n")); 
  Serial.print(F(" @example set 127 12345\n")); 
  
  Serial.print(F("\n@command get\n"));  
  Serial.print(F(" @desc get a specific EEPROM address block value\n"));
  Serial.print(F(" @param address {int}\n")); 
  Serial.print(F(" @example get 127\n"));  
  
  Serial.print(F("\ninput\n"));  
  Serial.print(F("\n@command press\n"));  
  Serial.print(F(" @desc convert int to binary to represent buttons pressed (this will only show white)\n"));
  Serial.print(F(" @param states {int}\n")); 
  Serial.print(F(" @example press 127\n"));

  Serial.print(F("\n@command display\n"));  
  Serial.print(F(" @desc convert int to binary to represent buttons pressed (this will show the stored color(\n"));
  Serial.print(F(" @param states {int}\n")); 
  Serial.print(F(" @example display 127\n"));  
 
  Serial.print(F("\ngeneral\n")); 
  Serial.print(F("\n@command reset\n"));  
  Serial.print(F(" @desc resets the chip*\n"));
  Serial.print(F(" @example reset\n"));
  Serial.print(F(" @note *please note you will have to close and reopen the serial monitor. this command is only really usefull for 32u4 based chips\n"));  

  Serial.print(F("\n@command exit\n"));  
  Serial.print(F(" @desc exits configurator mode\n"));
  Serial.print(F(" @example exit\n"));

  Serial.print(F("\n@command help\n"));  
  Serial.print(F(" @desc display this list again\n"));
  Serial.print(F(" @example help\n"));  
}
