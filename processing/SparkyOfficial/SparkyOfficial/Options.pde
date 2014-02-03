/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 30th, 2014
** @desc interface for Arduino based SparkyFive
*/

/*
** @class Options
** @desc draw modal and handle rollovers for options
*/
class Options
{  
  PImage[] pages = new PImage[5];
  PImage state;
  
  int[] close = {(dw/2)+355,453,(dw/2)+435,513};
  int[] madcatz = {(dw/2)-420,518,(dw/2),700};
  int[] hori = {(dw/2),518,(dw/2)+420,700};
  int[] rand = {(dw/2)-420,700,(dw/2),800};
  int[] erase = {(dw/2),700,(dw/2)+420,800};
  int fx = (dw/2)-(840/2)+20;
  int fy = 285;
  
  boolean upload = false;
  int inc = 0;
  /*
  ** @method setup
  ** @desc set initial state
  */  
  void setup()
  {
    pages[0] = loadImage("options.png");
    pages[1] = loadImage("options-madcatz-hover.png");
    pages[2] = loadImage("options-hori-hover.png");
    pages[3] = loadImage("options-random-hover.png");
    pages[4] = loadImage("options-erase-hover.png");
    
    state = pages[0];
  }
  
  void draw()
  {
    image(state, dx, 0);
    state = pages[0];
    mouse();
  }
  
  /*
  ** @method mouse
  ** @desc read x and y coordinates of the mouse and set hover states
  */     
  void mouse()
  {
    int mx = mouseX;
    int my = mouseY;
    
    /*
      close
    */
    if(mx > close[0] && mx < close[2] && my > close[1] && my < close[3])
    {
      mouseType = 1;
      if(mousePressed)
      {
        activemodal = false;
        option = false;
        state = pages[0];
        inc = 0;
        tint(255, 255);
      }
    }
    
    /*
      madcatz
    */
    if(mx > madcatz[0] && mx < madcatz[2] && my > madcatz[1] && my < madcatz[3])
    {
      mouseType = 1;
      state = pages[1];
      if(mousePressed)
      {

      }
    }
   
    /*
      hori
    */
    if(mx > hori[0] && mx < hori[2] && my > hori[1] && my < hori[3])
    {
      mouseType = 1;
      state = pages[2];
      if(mousePressed)
      {

      }
    }

    /*
      random
    */
    if(mx > rand[0] && mx < rand[2] && my > rand[1] && my < rand[3])
    {
      mouseType = 1;
      state = pages[3];
      if(mousePressed)
      {

      }
    }  

    /*
      erase
    */
    if(mx > erase[0] && mx < erase[2] && my > erase[1] && my < erase[3])
    {
      mouseType = 1;
      state = pages[4];
      if(mousePressed)
      {

      }
    }    
    
    /*
      button
    */
    /*
    if(mx > button[0] && mx < button[2] && my > button[1] && my < button[3])
    {
      mouseType = 1;
      state = pages[1];
      if(mousePressed)
      {
        inc = 0;
        upload = true;
        state = pages[2];
      }
    } 
    */
 
    
  }
}
