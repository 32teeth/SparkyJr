/*
** @desc this file includes everything to do with joystick and pixels
*/

/*
** @method pins
** @desc order is up right left down (NESW)
*/
PROGMEM const int directions[] = {13,5,A0,A1};
PROGMEM const int ringStart = 7;
PROGMEM const int ringEnd = 24;
PROGMEM const int cardinals[] = {23,19,15,11};
PROGMEM const int diagonals[] = {21,17,13,9};

/*
**
**
*/
void setJoystickIO()
{
  for(int n = 0; n < 4; n++)
  {   
    /*Oupute pins*/       
    pinMode(pgm_read_byte(&directions[n]), OUTPUT);digitalWrite(pgm_read_byte(&directions[n]), HIGH);  
  } 
}
/*
** @method joystick
** @description watch and delegate all IO
*/
void dislpayJoystickIO()
{ 
  int states[4] = {0,0,0,0};
  int r = in[0];
  int g = in[1];
  int b = in[2];
  for(int n = 0; n < 4; n++)
  {   
    /*Oupute pins*/       
    states[n] = digitalRead(pgm_read_byte(&directions[n]));
  }

  for(int n = ringStart; n < ringEnd; n++)
  {
    neo.setPixelColor(n, 0, 0, 0);
  }

  // north
  if(states[0] == 0 && states[1] != 0 && states[2] != 0  && states[3] != 0)
  {
    neo.setPixelColor(9, g/8, r/8, b/8);    
    neo.setPixelColor(8, g/4, r/4, b/4);
    neo.setPixelColor(23, g, r, b);
    neo.setPixelColor(22, g/4, r/4, b/4); 
    neo.setPixelColor(21, g/8, r/8, b/8);     
  }
  // north east  
  if(states[0] == 0 && states[1] == 0 && states[2] != 0  && states[3] != 0)
  {
    neo.setPixelColor(23, g/8, r/8, b/8);    
    neo.setPixelColor(22, g/4, r/4, b/4);
    neo.setPixelColor(21, g, r, b);
    neo.setPixelColor(20, g/4, r/4, b/4); 
    neo.setPixelColor(19, g/8, r/8, b/8);     
  }  
  // east  
  if(states[0] != 0 && states[1] == 0 && states[2] != 0  && states[3] != 0)
  {
    neo.setPixelColor(21, g/8, r/8, b/8);    
    neo.setPixelColor(20, g/4, r/4, b/4);
    neo.setPixelColor(19, g, r, b);
    neo.setPixelColor(18, g/4, r/4, b/4); 
    neo.setPixelColor(17, g/8, r/8, b/8);     
  } 
  // south east  
  if(states[0] != 0 && states[1] == 0 && states[2] == 0  && states[3] != 0)
  {
    neo.setPixelColor(19, g/8, r/8, b/8);    
    neo.setPixelColor(18, g/4, r/4, b/4);
    neo.setPixelColor(17, g, r, b);
    neo.setPixelColor(16, g/4, r/4, b/4); 
    neo.setPixelColor(15, g/8, r/8, b/8);     
  }   
  // south  
  if(states[0] != 0 && states[1] != 0 && states[2] == 0  && states[3] != 0)
  {
    neo.setPixelColor(17, g/8, r/8, b/8);    
    neo.setPixelColor(16, g/4, r/4, b/4);
    neo.setPixelColor(15, g, r, b);
    neo.setPixelColor(14, g/4, r/4, b/4); 
    neo.setPixelColor(13, g/8, r/8, b/8);     
  }      
  // south  west
  if(states[0] != 0 && states[1] != 0 && states[2] == 0  && states[3] == 0)
  {
    neo.setPixelColor(15, g/8, r/8, b/8);    
    neo.setPixelColor(14, g/4, r/4, b/4);
    neo.setPixelColor(13, g, r, b);
    neo.setPixelColor(12, g/4, r/4, b/4); 
    neo.setPixelColor(11, g/8, r/8, b/8);     
  }        
  //  west
  if(states[0] != 0 && states[1] != 0 && states[2] != 0  && states[3] == 0)
  {
    neo.setPixelColor(13, g/8, r/8, b/8);    
    neo.setPixelColor(12, g/4, r/4, b/4);
    neo.setPixelColor(11, g, r, b);
    neo.setPixelColor(10, g/4, r/4, b/4); 
    neo.setPixelColor(9, g/8, r/8, b/8);     
  }          
  // north west    
  if(states[0] == 0 && states[1] != 0 && states[2] != 0  && states[3] == 0)
  {
    neo.setPixelColor(11, g/8, r/8, b/8);    
    neo.setPixelColor(10, g/4, r/4, b/4);
    neo.setPixelColor(9, g, r, b);
    neo.setPixelColor(8, g/4, r/4, b/4); 
    neo.setPixelColor(23, g/8, r/8, b/8);     
  }
  neo.show();
}



