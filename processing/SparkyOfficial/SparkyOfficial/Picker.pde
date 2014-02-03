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
class Picker
{  
  PImage[] pages = new PImage[3];
  PImage state;
  
  PShape pin = loadShape("pin.svg");
  PShape sample;
  
  int[] button = {(dw/2)-(740/2),700,(dw/2)+(740/2),800};
  int[] close = {(dw/2)+310,453,(dw/2)+370,513};
  int[] colormap = {(dw/2)-(740/2),518,(dw/2)+(740/2),700};
  int fx = (dw/2)-(740/2)+20;
  int fy = 285;
  
  boolean upload = false;
  int inc = 0;
  /*
  ** @method setup
  ** @desc set initial state
  */  
  void setup()
  {
    pages[0] = loadImage("color-picker.png");
    pages[1] = loadImage("color-picker-hover.png");
    pages[2] = loadImage("color-picker-upload.png");
    
    state = pages[0];
  }
  
  void draw()
  {
    image(state, dx, 0);
    state = pages[0];
    if(upload)
    {
      if(inc < 740)
      {
        inc+=10;
        image(pages[1], dx, 0);
        fill(0,102,102);
        rect(button[0], button[1], inc, 100);
        image(pages[2], dx, 0);
      }
      else
      {
        upload = false;
        inc = 0;
      }
    }
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
        selector = false;
        upload = false;
        state = pages[0];
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
        inc = 0;
        upload = true;
        state = pages[2];
        /*
        exec = true;
        command = "set " + stick.address + " " + stick.COLOR;
        action = "set";
        */       
      }
    }
    
    /*
      colors
    */
    if(mx > colormap[0] && mx < colormap[2] && my > colormap[1] && my < colormap[3])
    {
      if(mousePressed)
      {
        color c = get(mouseX, mouseY);
        int r = (c>>16 & 0xff);
        int g = ((c>>8) & 0xff);
        int b = (c & 0xff);
      
        stick.HEX = hex(c, 6);
        stick.COLOR = Integer.parseInt(stick.HEX, 16);
        
        mouseType = 2;
        fill(r,g,b);
        shape(pin, mx-28, my-80);
        sample = pin.getChild("sample");
        sample.disableStyle();
        shape(sample, mx-28, my-80);
        
        preview(r,g,b);
      }
    }    
  }
  
  void preview(int r, int g, int b)
  {
    /*
    int[] box = {cX+223, 466, 55, 25};
    noStroke();
    fill(r,g,b);
    rect(box[0], box[1], box[2], box[3]);
    */
  }
  
  void preview()
  {
    int r = Integer.valueOf( stick.HEX.substring( 0, 2 ), 16 );
    int g = Integer.valueOf( stick.HEX.substring( 2, 4 ), 16 );
    int b = Integer.valueOf( stick.HEX.substring( 4, 6 ), 16 );
    preview(r, g, b);
  }   
}
