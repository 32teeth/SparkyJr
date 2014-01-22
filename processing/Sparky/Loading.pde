/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @description interface for Arduino based SparkyFive
*/

/*
** @class Loading
** @description this is a loading stub simply to show a splash screen for the app
*/
class Loading
{
  int cX;
  int x; 
  
  int cY;
  int y;   
  
  PImage blur = loadImage("blur.png");
  PImage loading = loadImage("loading.png");
  
  /*
  ** @method setup
  ** @description set initial centering based on screen size and invoke draw()
  */
  void setup()
  {
    cX = dW/2;
    x = cX - 640;
    
    cY = dH/2;
    y = cY - (1024/2);    
    
    draw(255);
  }
  
  /*
  ** @method draw
  ** @param percent {int}
  ** @description change the opacity and blur of the splash screen based on percent paramerter
  */
  void draw(int percent)
  {
    tint(255,percent);
    image(blur, x, 0);
    image(loading, x, y);  
  }
};
