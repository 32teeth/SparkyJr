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
  #ifndef NEO
    for(int n = 0; n < count; n++)
    {
      digitalWrite(pgm_read_byte(&outputs[n]), LOW);      
      /*
      ** @desc ANODE adjustment
      */      
      #ifdef ANODE
        for(int c = 0; c < 3; c++){analogWrite(pgm_read_byte(&pwm[c]), 255-pgm_read_byte(&MADCATZ_COLORS[n][c]));}
      #else
        for(int c = 0; c < 3; c++){analogWrite(pgm_read_byte(&pwm[c]), pgm_read_byte(&MADCATZ_COLORS[n][c]));}
      #endif
      if(pgm_read_byte(&MADCATZ[n]) == 0)
      {
        digitalWrite(pgm_read_byte(&outputs[n]), HIGH);
        delayMicroseconds(500);
        digitalWrite(pgm_read_byte(&outputs[n]), LOW);
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
      if(pgm_read_byte(&MADCATZ[n]) == 0){neo.setPixelColor(n, pgm_read_byte(&MADCATZ_COLORS[n][0]), pgm_read_byte(&MADCATZ_COLORS[n][2]), pgm_read_byte(&MADCATZ_COLORS[n][1]));}
    }
    neo.show();
    delayMicroseconds(2500);
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
  #ifndef NEO
    for(int n = 0; n < count; n++)
    {
      /*
      ** @desc ANODE adjustment
      */
      digitalWrite(pgm_read_byte(&outputs[n]), LOW);
      #ifdef ANODE
        for(int c = 0; c < 3; c++){analogWrite(pgm_read_byte(&pwm[c]), 255-pgm_read_byte(&HORI_COLORS[n][c]));}
      #else
        for(int c = 0; c < 3; c++){analogWrite(pgm_read_byte(&pwm[c]), pgm_read_byte(&HORI_COLORS[n][c]));}
      #endif        
      if(pgm_read_byte(&HORI[n]) == 0)
      {
        digitalWrite(pgm_read_byte(&outputs[n]), HIGH);
        delayMicroseconds(500);
        digitalWrite(pgm_read_byte(&outputs[n]), LOW);
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
      if(pgm_read_byte(&HORI[n]) == 0){neo.setPixelColor(n, pgm_read_byte(&HORI_COLORS[n][0]), pgm_read_byte(&HORI_COLORS[n][2]), pgm_read_byte(&HORI_COLORS[n][1]));}
    }
    neo.show();
    delayMicroseconds(2500);
  #endif
}
