/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @desc interface for Arduino based SparkyFive
*/

/*
** @class Screens
** @desc draw current screen and manage application states
*/
class Screens
{
  int cX;
  int x; 
  int[] p = {511, 508, 480, 155};
  int[] s = {165, 455};
  int[] close = {326, 115, 301, 455};
  
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
  
  PImage blur = loadImage("blur.png");
  PImage colorwheel = loadImage("colorwheel.png");
  PImage upload = loadImage("upload.png");
  PImage modal = loadImage("modal.png");
  PImage colorstate;
  
  /*
  ** @method setup
  ** @desc set initial centering based on screen size and invoke draw()
  */
  void setup()
  {
    cX = dW/2;
    x = cX - 640;
    
    colorstate = colorwheel;
    draw();
  }
  
  /*
  ** @method draw
  ** @desc stub
  */
  void draw()
  {
    
  }
  
  /*
  ** @method show
  ** @param screen {int} index of items array
  ** @desc call appropriate screen controller based on string value of items index
  **              invoke mouse listener
  */  
  void show(int screen)
  {
    if(items[screen] != "picker")
    {
      image(blur, x, 0);
      image(modal, x, 0);
    }
    if(items[screen] == "connection"){connection(false);}
    if(items[screen] == "controller"){controller(false);}
    if(items[screen] == "picker"){picker();}
    mouse();
  } 
 
  /*
  ** @method connection
  ** @param setup {boolean} 
  ** @desc load and show modal with list of ports available to select
  */  
  void connection(boolean setup)
  {
    int oX = x + 285;
    int oY = 200;
    
    fill(#000000);
    textFont(AR24, 18);
    text("COM ports found on your computer:", oX, oY);
    
    oY += 30;
    
    textFont(A14, 14);
    ports = Serial.list();
    for(int n = 0; n < ports.length; n++)
    {
      fill(#000000);
      if(ports[n].equals(portstring)){fill(#000000);}else{fill(#999999);}
      text(ports[n], oX, oY);    
      oY+=25;
    }
  }
  
  /*
  ** @method controller
  ** @param setup {boolean} 
  ** @desc load and show modal with list of devices available to select
  */
  void controller(boolean setup)
  {
    int oX = x + 285;
    int oY = 200;
    
    fill(#000000);
    textFont(AR24, 18);
    text("HID found on your computer:", oX, oY);
    
    oY += 30;
    
    textFont(A14, 14);
    for(int n = 2; n < HIDs.getNumberOfDevices(); n++)
    {
      fill(#000000);
      if(HIDs.getDevice(n).getName().equals(HID)){fill(#000000);}else{fill(#999999);}
      text(HIDs.getDevice(n).getName(), oX, oY);    
      oY+=25;
    }
  }  
  
  /*
  ** @method picer
  ** @desc load and show modal with colorwheel
  */
  void picker()
  {    
    image(colorstate, x, 0);
    int cw = 24;
    int ch = 16;
    int cx = 0;
    int cy = 0;
    int ci = 0;
    int cols = 20;
    int rows = 10;
    color[] MAP = {#000000,#0D0D0D,#1A1A1A,#282828,#353535,#434343,#505050,#5D5D5D,#6B6B6B,#787878,#868686,#939393,#A2A2A2,#AFAFAF,#BCBCBC,#CACACA,#D7D7D7,#E5E5E5,#F1F1F1,#FFFFFF,#000000,#0D0000,#1A0000,#280000,#350000,#430000,#500000,#5D0000,#6B0000,#780000,#860000,#930000,#A20000,#AF0000,#BC0000,#CA0000,#D70000,#E50000,#F10000,#FF0000,#000000,#0D0600,#1A0D00,#281400,#351A00,#432100,#502800,#5D2F00,#6B3500,#783C00,#864300,#934A00,#A25000,#AF5700,#BC5E00,#CA6500,#D76B00,#E57200,#F17900,#FF8000,#000000,#0D0D00,#1A1A00,#282800,#353500,#434300,#505000,#5D5D00,#6B6B00,#787800,#868600,#939300,#A2A200,#AFAF00,#BCBC00,#CACA00,#D7D700,#E5E500,#F1F100,#FFFF00,#000000,#000D00,#001A00,#002800,#003500,#004300,#005000,#005D00,#006B00,#007800,#008600,#009300,#00A200,#00AF00,#00BC00,#00CA00,#00D700,#00E500,#00F100,#00FF00,#000000,#000D0D,#001A1A,#002828,#003535,#004343,#005050,#005D5D,#006B6B,#007878,#008686,#009393,#00A2A2,#00AFAF,#00BCBC,#00CACA,#00D7D7,#00E5E5,#00F1F1,#00FFFF,#000000,#00060D,#000D1A,#001428,#001A35,#002143,#002850,#002F5D,#00356B,#003C78,#004386,#004A93,#0050A2,#0057AF,#005EBC,#0065CA,#006BD7,#0072E5,#0079F1,#0080FF,#000000,#00000D,#00001A,#000028,#000035,#000043,#000050,#00005D,#00006B,#000078,#000086,#000093,#0000A2,#0000AF,#0000BC,#0000CA,#0000D7,#0000E5,#0000F1,#0000FF,#000000,#0D000D,#1A001A,#280028,#350035,#430043,#500050,#5D005D,#6B006B,#780078,#860086,#930093,#A200A2,#AF00AF,#BC00BC,#CA00CA,#D700D7,#E500E5,#F100F1,#FF00FF,#000000,#0D0006,#1A000D,#280014,#35001A,#430021,#500028,#5D002F,#6B0035,#78003C,#860043,#93004A,#A20050,#AF0057,#BC005E,#CA0065,#D7006B,#E50072,#F10079,#FF0080};
    
    for(int row = 0; row < rows; row++)
    {
      cy = p[1] +(ch * row);
      for(int col = 0; col < cols; col++)
      {
        cx = x + p[0] + (cw * col) - 10;  
        fill(MAP[ci]);
        rect(cx,cy,cw,ch);
        ci++;      
      }    
    }     
  }
  
  /*
  ** @method mouse
  ** @desc read x and y coordinates of the mouse and set static, hover and clicked states
  */  
  void mouse()
  {
    int mX = mouseX;
    int mY = mouseY;

    /*
    ** @desc close button for connection and controller modals
    */    
    if(mX > (cX+close[0]) && mX < (cX+close[0]+45) && screen != 3)
    {
      if(mY > close[1] && mY < (close[1]+50))
      {
        mouseType = 1;
        if(mousePressed)
        {
          activemodal = false;
          screen = 0;
          menu.state = 0;
        }
      }
    }

    /*
    ** @desc close button for colorwheel color picker modal
    */
    if(mX > (cX+close[2]) && mX < (cX+close[2]+45) && screen == 3)
    {
      if(mY > close[3] && mY < (close[3]+50))
      {
        mouseType = 1;
        if(mousePressed)
        {
          activemodal = false;
          screen = 0;
          menu.state = 0;          
        }
      }
    }    
    
    /*
    ** @desc mouse states for listed serial connections
    */
    if(items[screen] == "connection")
    {
      int dX[] = {(x + 285), (x + 285 + 500)};
      int dY[] = {230, (230 + (ports.length * 25))};
      
      portstring = "";
      if(mX > dX[0] && mX < dX[1] && mY > dY[0] && mY < dY[1])
      {
        mouseType = 1;
        int p = ((mY-dY[0])/20);
        if(p < ports.length)
        {
          if(portstring != Serial.list()[p])
          {
            portstring = Serial.list()[p];
            if(mousePressed)
            {
              port = new Serial(Sparky, Serial.list()[p], baudrate);
              open = true;
              mouseType = 0;
              delay(500);
              activemodal = false;
              screen = 0;
              menu.state = 0;
            }            
          }   
        }      
      }
    }

    /*
    ** @desc mouse states for listed controllers
    */    
    if(items[screen] == "controller")
    {
      int dX[] = {(x + 285), (x + 285 + 500)};
      int dY[] = {230, (230 + (HIDs.getNumberOfDevices() * 25))};
      
      HID = "";
      if(mX > dX[0] && mX < dX[1] && mY > dY[0] && mY < dY[1])
      {
        mouseType = 1;
        int p = ((mY-dY[0])/20)+2;
        if(p < HIDs.getNumberOfDevices())
        {
          if(HID != HIDs.getDevice(p).getName())
          {
            HID = HIDs.getDevice(p).getName();
            if(mousePressed)
            {
              mouseType = 0;
              delay(500);
              activemodal = false;
              screen = 0;
              menu.state = 0;
            }            
          }   
        }      
      }
    }
   
    /*
    ** @desc mouse states for color picker
    */    
    if(items[screen] == "picker")
    {
      colorstate = colorwheel;
      /*
      ** @desc colors
      */
      if(mX > (x+p[0]) && mX < (x+p[0]+p[2]))
      {
        if(mY > (p[1]) && mY < (p[1]+p[3]))
        {
          mouseType = 2;
          if(mousePressed)
          {
            color c = get(mouseX, mouseY);
            int r = (c>>16 & 0xff);
            int g = ((c>>8) & 0xff);
            int b = (c & 0xff);
        
            stick.HEX = hex(c, 6);
            stick.COLOR = Integer.parseInt(stick.HEX, 16);
            
            preview(r,g,b);
          }
        }
      }
      
      /*
      ** @desc send button for colorwheel color picker modal
      */
      if(mX > (cX+s[0]) && mX < (cX+s[0]+45))
      {
        if(mY > s[1] && mY < (s[1]+50))
        {
          mouseType = 1;
          colorstate = upload;
          if(mousePressed)
          {
            exec = true;
            command = "set " + stick.address + " " + stick.COLOR;
            action = "set";      
          }
        }
      }      
      
      preview();

      /*
      ** @desc send
      */      
    }
  }
  
  
  void preview(int r, int g, int b)
  {
    int[] box = {cX+223, 466, 55, 25};
    noStroke();
    fill(r,g,b);
    rect(box[0], box[1], box[2], box[3]);
  }
  
  void preview()
  {
    int r = Integer.valueOf( stick.HEX.substring( 0, 2 ), 16 );
    int g = Integer.valueOf( stick.HEX.substring( 2, 4 ), 16 );
    int b = Integer.valueOf( stick.HEX.substring( 4, 6 ), 16 );
    preview(r, g, b);
  }   
};
