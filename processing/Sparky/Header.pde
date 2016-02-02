/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @desc interface for Arduino based SparkyFive
*/

/*
** @class Header
** @desc display header image
*/
class Header
{
  int cX;
  int x;  
  color colors[] = {
    #eeeeee,
    #ff9900
  };
  PImage header = loadImage("header.png");
  
  /*
  ** @method setup
  ** @desc set initial centering based on screen size and invoke draw()
  */
  void setup()
  { 
    cX = dW/2;
    x = cX - 400;
    
    draw();
  }
  
  /*
  ** @method draw
  ** @desc redraw the header image and graphic to extend to screen width
  */  
  void draw()
  { 
    fill(colors[0]);
    rect(0,0,dW,100);
    fill(colors[1]);
    rect(0,100,dW,3); 
    image(header, x, 0);
  }
};
