/*
** @desc this file includes everything to do with buttons and button manipulation
** @desc see setup.h if you wish to create your own pin mapping
*/

/*
** @method pins
** @desc light up RGB values accoring to input states
*/
void setIO()
{
  #ifndef DRIVER
    for(int n = 0; n < count; n++)
    {
      /*RGB pins*/
      if(n < 3){pinMode(pwm[n], OUTPUT);analogWrite(pwm[n], 0);}
       
      /*Oupute pins*/       
      pinMode(outputs[n], OUTPUT);digitalWrite(outputs[n], OFF);  
    }
  #endif

  for(int n = 0; n < count; n++){pinMode(inputs[n], INPUT);digitalWrite(inputs[n], HIGH);}
}

/*
** @method pins
** @desc light up RGB values accoring to input states
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
** @desc light up RGB values accoring to input states
*/
void outputIO()
{
  /*
  ** @desc if the changed timestamp is greater than current timestamp fade in the lights, 
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

        /*
        ** @desc if NO driver and ANODE adjustment
        */
        #ifdef ANODE && #ifndef DRIVER
          out[c] = 255 - out[c];
          in[c] = 255 - in[c];
        #endif       
      }

      /*
      ** @desc if NO driver
      */
      #ifndef DRIVER
        for(int n = 0; n < count; n++){stored[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}      
        for(int c = 0; c < 3; c++){analogWrite(pwm[c], out[c]);}     

        for(int n = 0; n < count; n++){states[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}      
        for(int c = 0; c < 3; c++){analogWrite(pwm[c], in[c]);}     
      /*
      ** @desc if NO driver
      ** @note order is R B G
      */
      #else
        for(int n = 0; n < count; n++)
        {
          neo.setPixelColor(n, 0, 0, 0);
          if(stored[n] == 0){neo.setPixelColor(n, out[0], out[2], out[1]);}
          if(states[n] == 0){neo.setPixelColor(n, in[0], in[2], in[1]);}
        }
        neo.show();
        delayMicroseconds(1000);
      #endif              
    }
    else
    {
      /*
      ** @desc if NO driver
      */
      #ifndef DRIVER
        for(int n = 0; n < count; n++){states[n] == 0 ? digitalWrite(outputs[n], ON) : digitalWrite(outputs[n], OFF);}
        for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255 - rgb[c]);}
      /*
      ** @desc if NO driver
      ** @note order is R B G
      */
      #else
        for(int n = 0; n < count; n++)
        {
          neo.setPixelColor(n, 0, 0, 0);
          if(states[n] == 0){neo.setPixelColor(n, rgb[0], rgb[2], rgb[1]);}
        }
        neo.show();
        delayMicroseconds(1000);
      #endif         
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

  /*
  ** @desc if NO driver
  */
  #ifndef DRIVER
    for(int n = 0; n < count; n++)
    {
      char pin = incoming[n];
      pin == '0' ? digitalWrite(outputs[n], OFF) : digitalWrite(outputs[n], ON);
    }

    /*
    ** @desc ANODE adjustment
    */
    #ifdef ANODE
      for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255 - rgb[c]);} 
    #else
      for(int c = 0; c < 3; c++){analogWrite(pwm[c], rgb[c]);} 
    #endif  
  /*
  ** @desc if NO driver
  ** @note order is R B G
  */
  #else
    for(int n = 0; n < count; n++)
    {
      neo.setPixelColor(n, 0, 0, 0);

      char pin = incoming[n];
      if(pin == 0){neo.setPixelColor(n, rgb[0], rgb[2], rgb[1]);}
    }
    neo.show();
    delayMicroseconds(1000);
  #endif     
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

  /*
  ** @desc if NO driver
  */
  #ifndef DRIVER
    for(int n = 0; n < count; n++)
    {
      char pin = incoming[n];
      pin == '0' ? digitalWrite(outputs[n], OFF) : digitalWrite(outputs[n], ON);
    }

    /*
    ** @desc fade in
    */
    for(int n = 0; n < 250; n++)
    {
        for(int c = 0; c < 3; c++)
        {
          float percent = n/duration;
          in[c] = (int)(rgb[c] * (percent));
          #ifdef ANODE
            in[c] = 255 - (int)in[c];
          #endif            
          analogWrite(pwm[c], in[c]);
        }         
        delayMicroseconds(1000);
    }

    /*
    ** @desc fade out
    */
    for(int n = 250; n > 0; n--)
    {
        for(int c = 0; c < 3; c++)
        {
          float percent = n/duration;
          out[c] = (int)(rgb[c] * (percent));
          #ifdef ANODE
            out[c] = 255 - (int)out[c];
          #endif            
          analogWrite(pwm[c], out[c]);
        }         
        delayMicroseconds(1000);
    }           
  /*
  ** @desc if NO driver
  ** @note order is R B G
  */
  #else
    for(int n = 0; n < 250; n++)
    {
      for(int n = 0; n < count; n++)
      {
        for(int c = 0; c < 3; c++)
        {
          float percent = n/duration;
          in[c] = (int)(rgb[c] * (percent));
        }
        neo.setPixelColor(n, 0, 0, 0);
        char pin = incoming[n];
        if(pin == 0){neo.setPixelColor(n, in[0], in[2], in[1]);}
      }
      neo.show();
      delayMicroseconds(1000);      
    }  
    for(int n = 250; n > 0; n--)
    {
      for(int n = 0; n < count; n++)
      {
        for(int c = 0; c < 3; c++)
        {
          float percent = n/duration;
          out[c] = (int)(rgb[c] * (percent));
        }        
        neo.setPixelColor(n, 0, 0, 0);

        char pin = incoming[n];
        if(pin == 0){neo.setPixelColor(n, out[0], out[2], out[1]);}
      }
      neo.show();
      delayMicroseconds(1000);      
    }  
  #endif 
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
