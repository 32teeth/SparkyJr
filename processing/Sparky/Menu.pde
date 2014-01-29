/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @desc interface for Arduino based SparkyFive
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
    "",
    "connection",
    "controller",
    "picker",
    "print",
    "erase",
    "random",
    "shutdown"
  };
  
  int cX;
  int x;
  int state;
  int w = 346;

  int[][] mapY = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}};  
  
  PImage menu = loadImage("menu.png");
  PImage[] off = new PImage[8];
  PImage[] hover = new PImage[8];
  PImage[] on = new PImage[8];
  PImage[] disabled = new PImage[8];
  
  PImage icon = loadImage("icon.png");
  PImage[] states = new PImage[2];

  boolean[] devices = {false,false};
  
  /*
  ** @method setup
  ** @desc set initial centering based on screen size and invoke draw()
  **              create image sprites for active states (icon)
  **              create image sprites from menu image (menu)
  **              populate mapY array with approrpiate values for vertical location of sprites
  */
  void setup()
  {
    cX = dW/2;
    x = cX - 423;
    
    int d = 22;
    for(int i = 0; i < 2; i++)
    {
      states[i] = createImage(d, d, ARGB);
      states[i].copy(icon, d*i, 0, d, d, 0, 0, d, d);
    }
    
    int y = 0;
    for(int i = 0; i < 8; i++)
    {
      mapY[i][0] = y;
      int h = i == 0 || i == 7 ? i == 0 ? 174 : 84 : 60;
      off[i] = createImage(w, h, ARGB);
      off[i].copy(menu, 0, y, w, h, 0, 0, w, h);
      hover[i] = createImage(w, h, ARGB);
      hover[i].copy(menu, w, y, w, h, 0, 0, w, h);
      on[i] = createImage(w, h, ARGB);
      on[i].copy(menu, w*2, y, w, h, 0, 0, w, h);
      disabled[i] = createImage(w, h, ARGB);
      disabled[i].copy(menu, w*3, y, w, h, 0, 0, w, h);      
      y += h;
      mapY[i][1] = y;      
    }    
    
    draw();
  }
  
  /*
  ** @method draw
  ** @desc set device states icons based on set parameters for icon display
  **              call mouse()
  */      
  void draw()
  {
    devices[0] = portstring != "" ? true : false;
    devices[1] = HID != "" ? true : false;
    
    mouse();
  }
  
  /*
  ** @method mouse
  ** @desc read x and y coordinates of the mouse and set static, hover and clicked states
  */   
  void mouse()
  {
    int mX = mouseX;
    int mY = mouseY;
    PImage item;
    
    for(int i = 0; i < 8; i++)
    {
      item = off[i];
      if(!open && (i == 3 || i == 4 || i == 5 || i == 6)){item = disabled[i];}
      if(mX > (x+23) && mX < (x+346-23))
      {
        if(mY > mapY[i][0] && mY < mapY[i][1])
        {
          if(!activemodal)
          {
            item = hover[i];
            mouseType = 1;
            if(mousePressed)
            {
              mouseType = 0;
              state = i;
              item = on[i];
              delay(500);
              switch(state)
              {
                case 1:
                  this.connection();
                break;
                case 2:
                  this.controller();
                break;
                case 3:
                  this.picker();
                break;
                case 7:
                  if(open)
                  {
                    port.clear();
                    port.stop();
                  }
                  exit();
                break;
                default:
                break;
              }
            }

            if(!open && (i == 3 || i == 4 || i == 5 || i == 6)){mouseType = 0;item = disabled[i];}            
          }
        }  
      }
      if(state == i)
      {
        item = on[i];
      }
      image(item, x, mapY[i][0]);
    }
    
    /*
       add state icons
    */
    for(int i = 0; i < 2; i++)
    {
      item = devices[i] ? states[0] : states[1];
      image(item, x+w-60, mapY[i+1][0]+20);
    }    
  }
  
  /*
  ** @method connection
  ** @desc set activemodal to true, set screen
  */
  void connection()
  {
    activemodal = true;
    screen = state;
  }
  
  /*
  ** @method controller
  ** @desc set activemodal to true, set screen
  */  
  void controller()
  {
    activemodal = true;
    screen = state;
  }  
  
  /*
  ** @method picker
  ** @desc set activemodal to true, set screen
  */  
  void picker()
  {
    activemodal = true;
    screen = state;
  }  
};
