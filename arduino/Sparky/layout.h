/*
** @desc this file is used to set modes for gameplay styles
*/


/*
** @desc madcatz buttons and colors
*/
PROGMEM int MADCATZ[8] = {0,0,1,1,0,0,1,1};
PROGMEM int MADCATZ_COLORS[8][3] =  {{0,0,255}, {255,255,0}, {0,0,0}, {0,0,0}, {0,255,0}, {255,0,0}, {0,0,0}, {0,0,0}};

/*
** @method madcatz
** @desc set lights according to madcatz layout
** @desc top row (blue, yellow)
** @desc bottom row (green, red)
*/
void madcatz()
{
  /*
  ** @desc if NO driver
  */
  #ifndef DRIVER
    for(int n = 0; n < count; n++)
    {
      /*
      ** @desc ANODE adjustment
      */      
      #ifdef ANODE
        for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255-MADCATZ_COLORS[n][c]);}
      #else
        for(int c = 0; c < 3; c++){analogWrite(pwm[c], MADCATZ_COLORS[n][c]);}
      #endif
      if(MADCATZ[n] == 0)
      {
        digitalWrite(outputs[n], HIGH);
        delayMicroseconds(500);
        digitalWrite(outputs[n], LOW);
      }
    }        
  /*
  ** @desc if NO driver
  ** @note order is R B G
  */
  #else
    for(int n = 0; n < count; n++)
    {
      neo.setPixelColor(n, 0, 0, 0);
      if(MADCATZ[n] == 0){neo.setPixelColor(n, MADCATZ_COLORS[n][0], MADCATZ_COLORS[n][2], MADCATZ_COLORS[n][1]);}
    }
    neo.show();
    delayMicroseconds(1000);
  #endif    
}


/*
** @desc hori buttons and colors
*/
PROGMEM int HORI[8] = {0,0,0,1,0,1,1,1};
PROGMEM int HORI_COLORS[8][3] =  {{255,0,0}, {0,0,255}, {255,255,0}, {0,0,0}, {0,255,0}, {0,0,0}, {0,0,0}, {0,0,0}};

/*
** @method hori
** @desc set lights according to hori layout
** @desc top row (red, blue, yellow)
** @desc bottom row (green)
*/
void hori()
{
  /*
  ** @desc if NO driver
  */
  #ifndef DRIVER
    for(int n = 0; n < count; n++)
    {
      /*
      ** @desc ANODE adjustment
      */
      #ifdef ANODE
        for(int c = 0; c < 3; c++){analogWrite(pwm[c], 255-HORI_COLORS[n][c]);}
      #else
        for(int c = 0; c < 3; c++){analogWrite(pwm[c], HORI_COLORS[n][c]);}
      #endif        
      if(HORI[n] == 0)
      {
        digitalWrite(outputs[n], HIGH);
        delayMicroseconds(500);
        digitalWrite(outputs[n], LOW);
      }
    }        
  /*
  ** @desc if NO driver
  ** @note order is R B G
  */
  #else
    for(int n = 0; n < count; n++)
    {
      neo.setPixelColor(n, 0, 0, 0);
      if(HORI[n] == 0){neo.setPixelColor(n, HORI_COLORS[n][0], HORI_COLORS[n][2], HORI_COLORS[n][1]);}
    }
    neo.show();
    delayMicroseconds(1000);
  #endif
}
