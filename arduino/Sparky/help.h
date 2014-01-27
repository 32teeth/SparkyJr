/*
** @method help
** @description typing help into the serial monitor starts the serial and prints the command list below
*/

void help()
{
  Serial.print("------------------------------------------------------\n");   
  Serial.print(" SparkyFive\n");
  Serial.print("------------------------------------------------------\n");   
  Serial.print(" EEPROM serial commands");
  Serial.print("\n @command erase\n");  
  Serial.print(" @description clears out all EEPROM data\n");
  Serial.print(" @example erase\n");

  Serial.print("\n @command print\n");  
  Serial.print(" @description prints out all EEPROM data\n");
  Serial.print(" @example print\n");  
  

  Serial.print("\n @command set\n");  
  Serial.print(" @description set a specific EEPROM address block value\n");
  Serial.print(" @param address {int} color {long}\n"); 
  Serial.print(" @example set 127 12345\n"); 
  

  Serial.print("\n @command get\n");  
  Serial.print(" @description get a specific EEPROM address block value\n");
  Serial.print(" @param address {int}\n"); 
  Serial.print(" @example get 127\n");  
  

  Serial.print("\n @command press\n");  
  Serial.print(" @description convert int to binary to represent buttons pressed\n");
  Serial.print(" @param states {int}\n"); 
  Serial.print(" @example press 127\n");
 
  Serial.print("\n @command reset\n");  
  Serial.print(" @description resets the chip*\n");
  Serial.print(" @example reset\n");
  Serial.print(" @note *please note you will have to close and reopen the serial monitor. this command is only really usefull for 32u4 based chips\n");  
  
  Serial.print("\n @command help\n");  
  Serial.print(" @description display this list again\n");
  Serial.print(" @example help\n");  
}
