/*
** @description this file includes everything to do with buttons and button manipulation
*/

/*
** @description declare button variables
*/
#ifdef RAZER
  PROGMEM const int inputs[] = {0,15,1,18,19,14,16,17};
  PROGMEM const int outputs[] = {6,7,8,12,2,3,4,5};
  PROGMEM const int pwm[] = {9,10,11};
#endif

#ifdef UNO
  PROGMEM const int inputs[] = {0,1,2,3,4,5,6,7};
  PROGMEM const int outputs[] = {18,17,16,15,14,13,12,8};
  PROGMEM const int pwm[] = {9,10,11};
#endif

#ifdef LEO
  PROGMEM const int inputs[] = {3,2,0,1,4,12,6,8};
  PROGMEM const int outputs[] = {23,22,21,20,19,18,13,5};
  PROGMEM const int pwm[] = {9,10,11};
#endif

PROGMEM int count = 8;



/*
** @method pins
** @description light up RGB values accoring to input states
*/
void setIO()
{
  for(int n = 0; n < count; n++)
  {
    /*RGB pins*/
    if(n < 3)
    {
      pinMode(pwm[n], OUTPUT);
      analogWrite(pwm[n], 0);
    }
    
    /*input and common pins*/
    pinMode(inputs[n], INPUT); 
    pinMode(outputs[n], OUTPUT);
    
    /*turn off all common*/
    digitalWrite(inputs[n], HIGH);    
    digitalWrite(outputs[n], OFF);  
  }
}

/*
** @method pins
** @description light up RGB values accoring to input states
*/
void readIO()
{
  address = 0;
  for(int n = 0; n < count; n++)
  {
    stored[n] = states[n];
    states[n] = 0;
  }
  
  for(int n = 0; n < count; n++)
  {
    states[n] = digitalRead(inputs[n]);
    address |= states[n] == 0 ? 1 << n : 0 << n;
  }
  for(int n = 0; n < count; n++){
    if(states[n] != stored[n])
    {     
      changed = now + duration; //millis() + duration;
      break;
    }
  }

  state = getBin(address);
}

/*
** @method outputIO
** @description light up RGB values accoring to input states
*/
void outputIO()
{
  /*
  ** @description if the changed timestamp is greater than current timestamp fade in the lights, 
  ** otherwise, light them up as necessary
  **
  */  
  
  color = getLongEEPROM(address);
  xrgb = getRGB(color);
  setRGB(xrgb);

  
  boolean fader = true;

  if(changed > now)
  {   
    if(fader)
    {
      for(int c = 0; c < 3; c++)
      {
        float percent = (changed-now)/duration;
        out[c] = (int)(prgb[c] * percent);        
        //in[c] = (int)(rgb[c] * (1-percent)) + out[c];
        in[c] = (int)(rgb[c] * (1-percent));        
      }

      for(int n = 0; n < count; n++){digitalWrite(outputs[n], OFF);}

      //for(int n = 0; n < count; n++){states[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}      
      for(int c = 0; c < 3; c++)
      {
          analogWrite(pwm[c], 255 - in[c]);
      }
      
      for(int n = 0; n < count; n++){stored[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}      
      for(int c = 0; c < 3; c++)
      {
          //analogWrite(pwm[c], 255 - out[c]);
      }     
    }
    else
    {
      for(int n = 0; n < count; n++){states[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}
      for(int c = 0; c < 3; c++)
      {
        float percent = 1 - (changed-now)/duration;
        int delta = 0;
        if(percent > 0)
        {  
          delta = (int)(rgb[c] * percent);
          analogWrite(pwm[c], 255 - delta);
        }
      }
    }
  }
  else
  {
    for(int n = 0; n < count; n++){states[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}
    for(int c = 0; c < 3; c++)
    {
      analogWrite(pwm[c], 255 - rgb[c]);
    }  
  }
  
}

/*
** @method watchIO
** @description watch and delegate all IO
*/
void watchIO()
{
  readIO();
  outputIO();
}

/*
** @method displayIO
** @description watch and delegate all IO
*/
void displayIO(int address)
{
  color = getLongEEPROM(address);
  xrgb = getRGB(color);
  setRGB(xrgb);
  String incoming = getBin(address);
  
  for(int n = 0; n < count; n++)
  {
    char pin = incoming[n];
    pin == '0' ? digitalWrite(outputs[n], OFF) : digitalWrite(outputs[n], ON);
  }
  
  for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255 - rgb[c]);} 
}

/*
** @method displayIO
** @description watch and delegate all IO
*/
void displayIO(int address, long color)
{
  xrgb = getRGB(color);
  setRGB(xrgb);
  String incoming = getBin(address);
  
  for(int n = 0; n < count; n++)
  {
    char pin = incoming[n];
    pin == '0' ? digitalWrite(outputs[n], OFF) : digitalWrite(outputs[n], ON);
  }
  
  for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255 - rgb[c]);} 
}

/*
** @method demoIO
** @description watch and delegate all IO
*/
void demoIO()
{
  for(int n = 0; n < 255; n++)
  {
    address = n;
    state = getBin(address);
    for(int n = 0; n < count; n++)
    {
      state.charAt(n) == '0' ? digitalWrite(inputs[n], OFF) : digitalWrite(inputs[n], ON);
    }

    color = getLongEEPROM(address);
    xrgb = getRGB(color);
    setRGB(xrgb);
    for(int c = 0; c < 3; c++){analogWrite(pwm[c], rgb[c]);}
  }
  
  address = 0;
  //outputIO();
}
