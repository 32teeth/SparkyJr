/*
** @desc this file is used to set modes for gameplay styles
*/


/*
** @desc madcatz buttons and colors
*/
int MADCATZ[8] = {0,0,1,1,0,0,1,1};
int MADCATZ_COLORS[8][3] =  {{255,255,0}, {0,0,255}, {255,255,255}, {255,255,255}, {255,0,255}, {0,255,255}, {255,255,255}, {255,255,255}};

/*
** @method madcatz
** @desc set lights according to madcatz layout
** @desc top row (blue, yellow)
** @desc bottom row (green, red)
*/
void madcatz()
{
  for(int n = 0; n < count; n++)
  {
    for(int c = 0; c < 3; c++){analogWrite(pwm[c], (int)MADCATZ_COLORS[n][c]);}
    if(MADCATZ[n] == 0)
    {
      digitalWrite(outputs[n], HIGH);
      delayMicroseconds(500);
      digitalWrite(outputs[n], LOW);
    }
  }   
}


/*
** @desc hori buttons and colors
*/
int HORI[8] = {0,0,0,1,0,1,1,1};
int HORI_COLORS[8][3] =  {{0,255,255}, {255,255,0}, {0,0,255}, {255,255,255}, {255,0,255}, {255,255,255}, {255,255,255}, {255,255,255}};

/*
** @method hori
** @desc set lights according to hori layout
** @desc top row (red, blue, yellow)
** @desc bottom row (green)
*/
void hori()
{
  for(int n = 0; n < 8; n++)
  {
    for(int c = 0; c < 3; c++){analogWrite(pwm[c], HORI_COLORS[n][c]);}
    if(HORI[n] == 0)
    {
      digitalWrite(outputs[n], HIGH);
      delayMicroseconds(500);
      digitalWrite(outputs[n], LOW);
    }
  }     
}
