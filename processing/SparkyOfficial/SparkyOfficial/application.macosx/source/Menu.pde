/*
** @author Eugene Andruszczenko
** @version 0.2
** @date January 30th, 2014
** @desc interface for Arduino based Sparky
*/

/*
** @class Manu
** @desc draw menu and manage states
*/
class Menu
{
  /*
  ** @desc list of menu items and their string names
  */
  String items[] = {
    "serials",
    "devices",
    "colors",
    "options",
    "exit"
  };
  
  int mw = 120;
  int mh = 100;
  int offset = 440;
  
  int[][] mapX = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}};
  
  PImage menu = loadImage("menu.png");
  PImage base;
  PImage[] off = new PImage[5];
  PImage[] hover = new PImage[5];
  PImage[] on = new PImage[5];
  PImage[] disabled = new PImage[5];
  int state;  
  
  /*
  ** @method setup
  ** @desc set initial centering based on screen size and invoke draw()
  **              create image sprites for active states (icon)
  **              create image sprites from menu image (menu)
  **              populate mapX array with approrpiate values for vertical location of sprites
  */  
  void setup()
  {
    int x = offset;
    for(int i = 0; i < 5; i++)
    {
      mapX[i][0] = (x-offset)+(dw/2)-200;
      /*
      ** off states
      */
      off[i] = createImage(mw, mh, ARGB);
      off[i].copy(menu, x, 0, mw, mh, 0, 0, mw, mh);
      /*
      ** hover states
      */      
      hover[i] = createImage(mw, mh, ARGB);
      hover[i].copy(menu, x, mh, mw, mh, 0, 0, mw, mh);
      /*
      ** on states
      */
      on[i] = createImage(mw, mh, ARGB);
      on[i].copy(menu, x, mh*2, mw, mh, 0, 0, mw, mh);
      /*
      ** disabled states
      */      
      disabled[i] = createImage(mw, mh, ARGB);
      disabled[i].copy(menu, x, mh*3, mw, mh, 0, 0, mw, mh);
      
      x += mw;
      mapX[i][1] = (x-offset)+(dw/2)-200;
    }
    
    base = createImage(1280, mh, ARGB);
    base.copy(menu, 0, 0, 1280, mh, 0, 0, 1280, mh);
  }
  
  /*
  ** @method draw
  ** @desc set device states icons based on set parameters for icon display
  **              call mouse()
  */
  void draw()
  {  
    // base
    image(base, dx, 0);
    mouse();
  }
  
  void drop()
  {
    for(int n = 0; n < 100; n++)
    {
      image(base, dx, -100-n);
    }
  }

  /*
  ** @method mouse
  ** @desc read x and y coordinates of the mouse and set static, hover and clicked states
  */     
  void mouse()
  {
    int mx = mouseX;
    int my = mouseY;
    PImage item; 
   
    for(int i = 0; i < 5; i++)
    {
      item = off[i];
      if(my > 0 && my < 100)
      {
        if(mx > mapX[i][0] && mx < mapX[i][1])
        {
          if(!activemodal)
          {
            item = hover[i];
            mouseType = 1;
            if(mousePressed)
            {
              //mouseType = 0;
              state = i;
              item = on[i];
              //delay(500);
              switch(state)
              {
                // connection
                case 0:
                  activemodal = true;
                  connection = false;
                  connections.inc = 0;
                  connections.page = 1;
                  if(open)
                  {
                    port.clear();
                    port.stop();
                  }
                break;
                // device
                case 1:
                  activemodal = true;
                  device = false;
                  devices.inc = 0;
                  devices.page = 1;
                break;
                case 2:
                  activemodal = true;
                  selector = true;    
                  MADCATZ_LAYOUT = false;
                  HORI_LAYOUT = false;            
                break;
                case 3:
                  activemodal = true;
                  option = true;
                break;
                case 4:
                  activemodal = true;
                  tryquit = true;
                break;
                default:
                break;
              }
            }
          }
        }
      }
      image(item, mapX[i][0], 0);
    } 
  }
}
