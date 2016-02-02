/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 30th, 2014
** @desc interface for Arduino based SparkyFive
*/

/*
** @class Devices
** @desc draw modal and list connections for selectsion
*/
class Devices
{  
  int page = 0;
  PImage[] pages = new PImage[5];
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
    pages[0] = loadImage("device.png");
    pages[1] = loadImage("device-hover.png");
    pages[2] = loadImage("device-connection.png");
    pages[3] = loadImage("device-connection-hover.png");
    pages[4] = loadImage("device-connection-inactive.png");
    
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
    state = page == 0 ? pages[0] : pages[4];
    if(page == 1)
    {
      devices();
    }  
    mouse();
  }
  
  void devices()
  {
    fill(102);
    for(int n = 2; n < HIDs.getNumberOfDevices(); n++)
    {
      fill(204);
      if(HIDs.getDevice(n).getName().equals(HID)){fill(102);}else{fill(204);}
      if(HIDs.getDevice(n).getName().equals(activeHID)){fill(0,153,153);}

      textFont(fontSparky18);
      text("f", fx, fy + ((n-2)*30) + 5);
      
      textFont(fontOSL18);
      text(HIDs.getDevice(n).getName(), fx + 25, fy + ((n-2)*30));    
    }    
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
        page = 0;
        activemodal = false;
        device = true;
        tint(255, 255);
      }
    } 
    
    /*
      button
    */
    if(mx > button[0] && mx < button[2] && my > button[1] && my < button[3])
    {
      mouseType = 1;
      if(page == 0)
      {
        state = pages[1];
        if(mousePressed)
        {
          page = 1;
        }
      }
      if(page == 1)
      {
        state = activeHID == "" ? pages[4] : pages[3];
        if(mousePressed && activeHID != "")
        {
          device = true;
          activemodal = false;
          inc = 0;
        }          
      }      
    }
    else
    {
      if(page == 0)
      {
        state = pages[0];
      }
      if(page == 1)
      {
        state = activeHID == "" ? pages[4] : pages[2];        
      }       
    }
    
    /*
      list
    */
    if(page == 1)
    {
      int lx[] = {fx, (fx + 700)};
      int ly[] = {fy, (fy + (ports.length * 30))};

      HID = "";
      if(mx > lx[0] && mx < lx[1] && my > ly[0] && my < ly[1])
      {
        mouseType = 1;
        int p = ((my-ly[0])/30)+2;
        if(p < HIDs.getNumberOfDevices())
        {
          if(HID != HIDs.getDevice(p).getName())
          {
            HID = HIDs.getDevice(p).getName();
            if(mousePressed)
            {
              activeHID = HID;
            }            
          }   
        }        
      }      
    }
  }
}
