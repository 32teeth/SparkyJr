/*
** @method setEEPROM
** @param address {int} 0-254
** @param color {long}
** @description set eeprom address with color
*/
void setEEPROM(int address, long color)
{
  int block = address*4;
  EEPROM.writeLong(block, color);
}

/*
** @method getColorEEPROM
** @param address {int} 0-254
** @description get color from eeprom address
*/
int* getColorEEPROM(int address)
{
  int block = address*4;
  long color = EEPROM.readLong(block);
  return getRGB(color);
}

/*
** @method getLongEEPROM
** @param address {int} 0-254
** @description get color from eeprom address
*/
long getLongEEPROM(int address)
{
  int block = address*4;
  return EEPROM.readLong(block);
}

/*
** @method randomEEPROM
** @description assign random colors to address
*/
void randomEEPROM()
{
  for(int n = 0; n < addressMax; n+=4)
  {
    EEPROM.writeLong(n, colors[random(0,13)]);
    delay(10);
  }  
}

/*
** @method printEEPROM
** @description print out all EEPROM address
*/
void printEEPROM()
{
  for(int n = 0; n < addressMax; n+=4)
  {
    Serial.print("reading address:");
    Serial.print(n/4);
    Serial.print("\tlong:");
    Serial.println(EEPROM.readLong(n));
  }  
}

/*
** @method eraseEEPROM
** @description print out all EEPROM address
*/
void eraseEEPROM()
{
  for(int n = 0; n < addressMax; n+=4)
  {
    EEPROM.writeLong(n, empty);
    delay(10);
  }  
}

