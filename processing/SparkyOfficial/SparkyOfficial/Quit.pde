/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 30th, 2014
** @desc interface for Arduino based SparkyFive
*/

/*
** @class Quit
** @desc draw modal and list connections for selectsion
*/
class Quit
{  
  PImage[] pages = new PImage[2];
  PImage blur = loadImage("blur.png");
  PImage state;
  
  int[] button = {(dw/2)-(740/2),512,(dw/2)+(740/2),612};
  int[] close = {(dw/2)+310,155,(dw/2)+370,215};
  int fx = (dw/2)-(740/2)+20;
  int fy = 285;
  
  int inc = 0;
  /*
  ** @method setup
  ** @desc set initial state
  */  
  void setup()
  {
    pages[0] = loadImage("quit.png");
    pages[1] = loadImage("quit-hover.png");
    
    state = pages[0];
  }
  
  void draw()
  {
    tint(255, 255);
    image(blur, dx, 0);
    if(inc < 255)
    {
      tint(255, inc);
      inc+=15;
    }    
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
        tryquit = false;
        inc = 0;
        tint(255, 255);
      }
    }
    
    /*
      button
    */
    if(mx > button[0] && mx < button[2] && my > button[1] && my < button[3])
    {
      mouseType = 1;
      state = pages[1];
      if(mousePressed)
      {
        if(open)
        {
          port.clear();
          port.stop();
        }
        exit();        
      }
    }    
  }
}
