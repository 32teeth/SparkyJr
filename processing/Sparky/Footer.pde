/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @description interface for Arduino based SparkyFive
*/

/*
** @class Footer
** @description draw footer bar
*/
class Footer
{
  int cX;
  int x;  
  color colors[] = {
    #000000,
    #000000
  };
  
  /*
  ** @method setup
  ** @description set initial centering based on screen size and invoke draw()
  */  
  void setup()
  { 
    draw();
  }
  
  /*
  ** @method draw
  ** @description redraw the footer graphic to extend to screen width
  */    
  void draw()
  { 
    fill(colors[0],50);
    rect(0,dH-50,dW,50);
    
    fill(colors[0],100);
    rect(0,dH-50,dW,1);    
  }
};
