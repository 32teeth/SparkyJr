/*
** @description this file is used to set modes for gameplay styles
*/


/*
** @description madcatz buttons and colors
*/
PROGMEM int MADCATZ[8] = {0,0,1,1,0,0,1,1};
int* MADCATZ_COLORS[8][3] =  {getRGB(BLUE), getRGB(YELLOW), getRGB(BLACK), getRGB(BLACK), getRGB(GREEN), getRGB(RED), getRGB(BLACK), getRGB(BLACK)};

/*
** @method madcatz
** @description set lights according to madcatz layout
** @description top row (blue, yellow)
** @description bottom row (green, red)
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
** @description hori buttons and colors
*/
PROGMEM int HORI[8] = {0,0,0,1,0,1,1,1};
int* HORI_COLORS[8][3] =  {getRGB(RED), getRGB(BLUE), getRGB(YELLOW), getRGB(BLACK), getRGB(GREEN), getRGB(BLACK), getRGB(BLACK), getRGB(BLACK)};

/*
** @method hori
** @description set lights according to hori layout
** @description top row (red, blue, yellow)
** @description bottom row (green)
*/
void hori()
{
  for(int n = 0; n < 8; n++)
  {
    for(int c = 0; c < 3; c++){analogWrite(pwm[c], (int)HORI_COLORS[n][c]);}
    if(HORI[n] == 0)
    {
      digitalWrite(outputs[n], HIGH);
      delayMicroseconds(500);
      digitalWrite(outputs[n], LOW);
    }
  }     
}
