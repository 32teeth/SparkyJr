/*
** @desc this file includes everything to do with buttons and button manipulation
** @desc see setup.h if you wish to create your own pin mapping
*/


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
      changed = now + duration;
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

      for(int n = 0; n < count; n++){stored[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}      
      for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255 - out[c]);}     

      for(int n = 0; n < count; n++){states[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}      
      for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255 - in[c]);}      
    }
    else
    {
      for(int n = 0; n < count; n++){states[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}
      for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255 - rgb[c]);}
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

  for(int n = 0; n < 250; n++)
  {
      for(int c = 0; c < 3; c++)
      {
        float percent = n/duration;
        in[c] = (int)(rgb[c] * (percent));
        analogWrite(pwm[c], 255-(int)in[c]);
      }         
      delayMicroseconds(750);
  }
  
  for(int n = 0; n < 250; n++)
  {
      for(int c = 0; c < 3; c++)
      {
        float percent = n/duration;
        out[c] = (int)(rgb[c] * (1-percent));
        analogWrite(pwm[c], 255-(int)out[c]);
      }         
      delayMicroseconds(750);
  }
}

/*
** @method introIO
** @description watch and delegate all IO
*/
void introIO()
{
  for(int n = 0; n < 10; n++)
  {
    address = random(255);
    state = getBin(address);
    color = getLongEEPROM(address);
    displayIO(address, color);
  }
  displayIO(255, 16777215);
}
