/*
** @author Eugene Andruszczenko
** @version 0.2
** @date January 30th, 2014
** @desc interface for Arduino based Sparky
*/

/*
** @desc all import files for controller
*/
import java.util.*;
import procontroll.*;
import net.java.games.input.*;
import java.io.*;

ControllIO HIDs;
String HID = "";
String activeHID = "";

/*
** @desc all import files and definitions for serial and arduino
*/
import processing.serial.*; 
Serial port;
String portstring = "";
String activeportstring = "";
int activeport;
String ports[];
int serial;
String command = "";
String action = "";
Boolean exec = false;
int baudrate = 115200;
boolean open = false;

/*
** @desc set mouse type
** 0 = ARROW, 1 = HAND, 2 = pin
*/
int mouseType = 0;

/*
** @desc fonts
*/
PFont fontOS10;
PFont fontOSL10;
PFont fontOS14;
PFont fontOSL14;
PFont fontOS18;
PFont fontOSL18;
PFont fontOS26;
PFont fontOSL26;
PFont fontSparky18;

/*
** @desc frame rate per second
*/
int fps = 120;

/*
** @desc width and height of full screen
*/
int dw, dh, dx, dy;

/*
** @desc 
*/

/*
** @desc madcatz buttons and colors
*/
boolean MADCATZ_LAYOUT = false;
int[] MADCATZ = {1,1,0,0,1,1,0,0};
int[][] MADCATZ_COLORS =  {{0,0,204}, {204,204,0}, {0,0,0}, {0,0,0}, {0,204,0}, {204,0,0}, {0,0,0}, {0,0,0}};

/*
** @desc hori buttons and colors
*/
boolean HORI_LAYOUT = false;
int[] HORI = {1,1,1,0,1,0,0,0};
int[][] HORI_COLORS =  {{204,0,0}, {0,0,204}, {204,204,0}, {0,0,0}, {0,204,0}, {0,0,0}, {0,0,0}, {0,0,0}};

/*
** @desc Intro Class
*/
Intro intro;
int duration = 30000;
float now = millis() + duration;

/*
** @desc Menu Class
*/
Menu menu;

/*
** @desc Stick class
*/
Stick stick;

/*
** @desc Connections class
*/
Connections connections;
boolean connection = false;

/*
** @desc Devices class
*/
Devices devices;
boolean device = false;

/*
** @desc Devices class
*/
Options options;
boolean option = false;

/*
** @desc Devices class
*/
Picker picker;
boolean selector = false;

/*
** @desc Devices class
*/
Com com;

/*
** @desc Devices class
*/
Quit quit;
boolean tryquit = false;

/*
** @desc width and height of full screen
*/
boolean activemodal = false;

/*
** @desc width and height of full screen
*/
boolean full = false;

/*
** @desc set to true to skip intro animation
*/
boolean loaded = false;

/*
** THIS
*/
SparkyOfficial SparkyOfficial = this;

/*
** @method setup
** @desc main processing setup
*/
void setup()
{
  ports = Serial.list();
  
  smooth();
  /*
    @desc fonts
  */
  fontOS10 = createFont("OpenSans-Regular", 10, true);
  fontOSL10 = createFont("OpenSans-Light", 10, true);   
  fontOS14 = createFont("OpenSans-Regular", 14, true);
  fontOSL14 = createFont("OpenSans-Light", 14, true); 
  fontOS18 = createFont("OpenSans-Regular", 18, true);
  fontOSL18 = createFont("OpenSans-Light", 18, true);
  fontOS26 = createFont("OpenSans-Regular", 26, true);
  fontOSL26 = createFont("OpenSans-Light", 26, true);
  
  fontSparky18 = createFont("sparky", 18, true);
  
  textAlign(LEFT, TOP);
  
  
  frame.setTitle("Sparky Jr. Configurator");
  
  dw = full ? displayWidth : 1024;
  dh = full ? displayHeight : 800; 
  dx = dw/2 - 640;
  dy = dh/2 - 512;
  
  
  size(dw, dh);

  frameRate(fps);
  background(255);
  
  noStroke();

  // set HID
  HIDs = ControllIO.getInstance(this);

  // intro
  intro = new Intro();
  intro.setup(); 
  
  // menu
  menu = new Menu();
  menu.setup();  
  
  // stick
  stick = new Stick();
  stick.setup();  
 
  // connection
  connections = new Connections();
  connections.setup();
  
  // device
  devices = new Devices();
  devices.setup();  
  
  // picker
  picker = new Picker();
  picker.setup();

  // picker
  options = new Options();
  options.setup(); 
 
  // com
  com = new Com(); 
  
  // quit
  quit = new Quit();
  quit.setup();   
}

/*
** @method draw
** @desc main processing loop
*/
void draw()
{
  background(255);
  mouseType = 0;
  textAlign(LEFT, TOP);

  if(!activemodal && loaded)
  {
    stick.draw();
    menu.draw();
  }
  if(loaded)
  {
    if(!connection || !device)
    {
      activemodal = true;
      if(!connection)
      {
        connections.draw();
      }  
      if(connection && !device)
      {
        devices.draw();
      }
    }
    if(selector)
    {
      stick.draw();
      menu.draw();
      picker.draw();
    }    
    if(option)
    {
      stick.draw();
      menu.draw();
      options.draw();
    }    
    if(tryquit)
    {
      quit.draw();
    }
    
  }
  if(now > millis() && !loaded)
  {
    intro.draw();
  }  
  
  mouse();
}








/*
** @method sketchFullScreen
** @desc this is processing fullscreen mode based
*/
boolean sketchFullScreen() {
  return full;
}

/*
*/
void mouse()
{
  switch(mouseType)
  {
    case 0:
      cursor(ARROW);
    break;
    case 1:
      cursor(HAND);
    break;
    case 2:
      noCursor();
      //cursor(pencil, 0, 30);
    break;
  }    
}

void mouseReleased() {
  if(exec && action != "")
  {
    if(action == "set")
    {
      println("set " + stick.address + " " + stick.COLOR);
      com.set(stick.address, stick.COLOR);
    }
    exec = false;
    action = "";
    command = "";
  }
}

/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @desc interface for Arduino based SparkyFive
*/

class Com
{  
  /*
  ** @method setup
  ** @param command {String} (erase|print|reset|help)
  ** @desc used to call and recieve serial commands to arduino
  */  
  void send(String command)
  {
    if(port.available() > 0)
    {
      port.write(command);
      recieve();
    }
  }

  /*
  ** @method set
  ** @desc set a specific EEPROM address block value
  ** @param address {int} clr {long}
  ** @example set 127 12345
  */  
  void set(int address, long clr)
  {    
    if(open)
    {
      println("set " + address + " " + clr);
      port.write("set " + address + " " + clr);
      port.write("display " + address);
      delay(2500);
    }
  }

  /*
  ** @method get
  ** @desc get a specific EEPROM address block value
  ** @param address {int}
  ** @example get 127
  */  
  void get(int address)
  {
    if(port.available() > 0)
    {
      port.write("get " + address);
      recieve();
    }
  }  

  /*
  ** @method press
  ** @desc press a specific EEPROM address block value
  ** @param address {int}
  ** @example press 127
  */  
  void press(int address)
  {
    if(port.available() > 0)
    {
      port.write("set " + address);
      recieve();
    }
  }

  /*
  ** @method display
  ** @desc display a specific EEPROM address block value
  ** @param address {int}
  ** @example display 127
  */  
  void display(int address)
  {
    if(port.available() > 0)
    {
      port.write("display " + address);
      recieve();
    }
  }    

  /*
  ** @method setup
  ** @param command {String} (erase|print|reset|help)
  ** @desc used to recieve serial commands to arduino
  */  
  void recieve()
  {
    if(port.available() > 0)
    {
      println(port.read());     
    }
    
    while (port.available() > 0) {
      String inBuffer = port.readString();   
      if (inBuffer != null) {
        println(inBuffer);
      }
    }     
  }  
}
/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 30th, 2014
** @desc interface for Arduino based SparkyFive
*/

/*
** @class Connections
** @desc draw modal and list connections for selectsion
*/
class Connections
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
    pages[0] = loadImage("serial.png");
    pages[1] = loadImage("serial-hover.png");
    pages[2] = loadImage("serial-connection.png");
    pages[3] = loadImage("serial-connection-hover.png");
    pages[4] = loadImage("serial-connection-inactive.png");
    
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
      connections();
    }  
    mouse();
  }
  
  void connections()
  {
    fill(102);
    for(int n = 0; n < ports.length; n++)
    {
      fill(204);
      if(ports[n].equals(portstring)){fill(102);}else{fill(204);}
      if(ports[n].equals(activeportstring)){fill(0,153,153);}

      textFont(fontSparky18);
      text("f", fx, fy + (n*30) + 5);
      
      textFont(fontOSL18);
      text(ports[n], fx + 25, fy + (n*30));    
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
        connection = true;
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
        state = activeportstring == "" ? pages[4] : pages[3];
        if(mousePressed && activeportstring != "")
        {
          connection = true;
          port = new Serial(SparkyOfficial, Serial.list()[activeport], baudrate);
          activemodal = false;
          open = true;
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
        state = activeportstring == "" ? pages[4] : pages[2];
      }       
    }
    
    /*
      list
    */
    if(page == 1)
    {
      int lx[] = {fx, (fx + 700)};
      int ly[] = {fy, (fy + (ports.length * 30))};

      portstring = "";
      if(mx > lx[0] && mx < lx[1] && my > ly[0] && my < ly[1])
      {
        mouseType = 1;
        int p = ((my-ly[0])/30);
        if(p < ports.length)
        {
          if(portstring != Serial.list()[p])
          {
            portstring = Serial.list()[p];
            if(mousePressed)
            {
               activeport = p;
               activeportstring = portstring;
            }            
          }   
        }        
      }      
    }
    
  }
}
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
/*
** @author Eugene Andruszczenko
** @version 0.2
** @date January 30th, 2014
** @desc interface for Arduino based Sparky
*/

/*
** @class Intro
** @desc draw intro screen
*/
class Intro
{
  /*
  ** @desc images required for this clip
  */
  PImage imgText = loadImage("intro-title.png");
  PImage imgRainbow = loadImage("intro-rainbow.png");
  PImage imgStick = loadImage("intro-stick.png");
  PImage imgBase = loadImage("base.png");
  PShape buttons = loadShape("buttons.svg");
  PImage menu = loadImage("menu.png");
  PImage base;
  
  int percent;
  int[] inc = {0,0,0,0,0,0,0};
  
  /*
  ** @method setup
  ** @desc set initial centering based on screen size and invoke draw()
  */
  void setup()
  {
    base = createImage(1280, 100, ARGB);
    base.copy(menu, 0, 0, 1280, 100, 0, 0, 1280, 100);
  }
  
  /*
  ** @method draw
  ** @desc stub
  */
  void draw()
  {
    float time = millis();
    if(time < 4000)
    {
      splash();
    }
    if(time > 4000 && time < 10000)
    {
      logo();
    }
    if(time > 10000 && time < 12000)
    {
      out();
    }
    if(time > 12000)
    {
      back();
    }
    if(time > 15000)
    {
      loaded = true;
    }
  }

  /*
  ** @method splash
  ** @desc draw splash text
  */
  void splash()
  {
    int p = inc[0] < 255 ? 255-inc[0] : inc[0]-255;
    
    fill(p);
    textAlign(CENTER, CENTER);
    textFont(fontOSL14);
    text("32teeth", dw/2, dh/2);

    fill(127, 255-p);
    textFont(fontOSL10);
    text("presents", dw/2, dh/2+28);
    
    inc[0]+=2;
  }

  /*
  ** @method logo
  ** @desc fade logo and rainbow
  */
  void logo()
  {
    int p = inc[1];
    if(p < 255){tint(255,p);}
    image(imgText, dx, dy);
    
    if(inc[1] > 255)
    {
      if(inc[2] < dh/2-50)
      {
        image(imgRainbow, dx, dh-inc[2]);
        inc[2]+=2;
      }
      else
      {
        tint(255,255-inc[3]);
        image(imgRainbow, dx, dh/2+50);
        tint(255,255);
        image(imgStick, dx, dh/2+50);
        inc[3]+=2;
      }
    }
    
    inc[1]+=2;
  } 
  
  /*
  ** @method out
  ** @desc fade out logo
  */  
  void out()
  {
    int p = inc[4];
    if(p < 255){tint(255,255-p);}
    else{tint(255,0);}
    image(imgText, dx, dy);
    image(imgStick, dx, dh/2+50);
    inc[4]+=5;    
  }
  
  /*
  ** @method back
  ** @desc fade in background and drop in menu
  */   
  void back()
  {
    int p = inc[5];
    if(p < 255){tint(255,p);}
    image(imgBase, dx, 0);
    shape(buttons, dx, 0);
    inc[5]+=5;
   
    if(inc[5] > 255 && inc[6] < 100)
    {
      image(base, dx, -100+inc[6]);
      inc[6]+=2;
    } 
    if(inc[6] == 100)
    {
      image(base, dx, 0);
    }
  }
}
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
        MADCATZ_LAYOUT = true;
        HORI_LAYOUT = false;
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
        MADCATZ_LAYOUT = false;
        HORI_LAYOUT = true;
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
        inc+=25;
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

        exec = true;
        command = "set " + stick.address + " " + stick.COLOR;
        action = "set";  
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
/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 30th, 2014
** @desc interface for Arduino based SparkyFive
*/

/*
** @class Stick
** @desc draw arcade stick and manage button states and colors
*/
class Stick
{  
  
  PImage stick = loadImage("base.png");
  PShape buttons = loadShape("buttons.svg");
  PShape Cap;
  PShape Button;
  PShape Color;
  PShape Base;
  PGraphics buffer;
  
  int[] colors = new int[256];
  int[] states = {0,0,0,0,0,0,0,0};
  int[] selected = {0,0,0,0,0,0,0,0};
  int address;  
  int[] hovers = {16711680,65280,255,16776960,65535,16711935,16777215,0};
  
  int COLOR;
  String HEX = "000000";
  int INDEX;
  
  color hover;
  
  /*
  ** @method setup
  ** @desc set initial centering based on screen size and invoke draw()
  **              create buffer of offscreen mouse rollovers
  */
  void setup()
  { 
    for(int n = 0; n < 256; n++){colors[n] = 0;}
    
    buffer = createGraphics(dw, dh);
  }
  
  /*
  ** @method draw
  ** @desc manage stage, draw stick image, invoke mapper() and display() and set address (for port writing)
  */
  void draw()
  {
    image(stick, dx, 0);
    if(selector)
    {
      mapper();    
      address = 0;
      for(int n = 0; n < 8; n++){address |= selected[n] == 1 ? 1 << n : 0 << n;}
      fill(0);
      //text("address:" + address + " hex:" + HEX + " color:" + COLOR, 10, 680);      
    }    

    if(!MADCATZ_LAYOUT && !HORI_LAYOUT)
    {
      display();
    }
    else
    {
      if(MADCATZ_LAYOUT){madcatz();}
      if(HORI_LAYOUT){hori();}
    } 
  }

  /*
  ** @method mapper
  ** @desc used strickly for drawing offscreen buffer for roll over detection
  **              if color matches current underlying map defined color and mouse clicked, set selected state for button
  */  
  void mapper()
  {
    buffer.beginDraw();    
    buffer.background(124,124,124);
    buffer.noStroke();    
    for(int n = 0; n < 8; n++)
    {
      int r = ((hovers[n]>>16) & 0xff);
      int g = ((hovers[n]>>8) & 0xff);
      int b = (hovers[n] & 0xff);      
      
      buffer.fill(r,g,b);
      buffer.noStroke();
      
      Base = buttons.getChild("Base"+n);
      Base.disableStyle();
      
      buffer.shape(Base, dx, 0);
      hover = buffer.get(mouseX, mouseY);
    }
    
    buffer.endDraw();
    image(buffer, -1280, 0);
    
    int r = (hover>>16 & 0xff);
    int g = ((hover>>8) & 0xff);
    int b = (hover & 0xff);

    mouseType = 0;
    for(int n = 0; n < 8; n++)
    {
      states[n] = 0;
      if((hover+16777216) == hovers[n])
      {
        mouseType = 1;
        states[n] = 1;
        if(mousePressed)
        {
          selected[n] = selected[n] == 0 ? 1 : 0;
          delay(250);
        }
      }
    }
  }
  
  void display()
  {
    noStroke();
    fill(211);
    buttons.disableStyle();
    shape(buttons, dx, 0);
    
    for(int n = 7; n >= 0; n--)
    {
      fill(#777777);
      if(states[n] == 0){fill(#666666);};
      if(selected[n] == 1){fill(#999999);};    
      Base = buttons.getChild("Base"+n);
      Base.disableStyle();
      shape(Base, dx, 0);

      int r = ((COLOR>>16) & 0xff);
      int g = ((COLOR>>8) & 0xff);
      int b = (COLOR & 0xff);   
      
      fill(r,g,b);
      if(selected[n] == 0){fill(102);}
      
      Color = buttons.getChild("Color"+n);
      Color.disableStyle();
      shape(Color, dx, 0);      
      
      fill(255,90);
      Button = buttons.getChild("Button"+n);
      Button.disableStyle();
      shape(Button, dx, 0);
      
      fill(r,g,b);
      if(selected[n] == 0){fill(102);}
      if(r == 255 && g == 255 && b == 255 && selected[n] == 1){fill(238);};
      
      Cap = buttons.getChild("Cap"+n);
      Cap.disableStyle();
      shape(Cap, dx, 0);      
      
      fill(0);      
    }
  }
  
  void madcatz()
  {
    noStroke();
    fill(211);
    buttons.disableStyle();
    shape(buttons, dx, 0);
    
    for(int n = 7; n >= 0; n--)
    {
      fill(#777777);
      if(MADCATZ[n] == 1){fill(#999999);}; 
     
      Base = buttons.getChild("Base"+n);
      Base.disableStyle();
      shape(Base, dx, 0);
      
      int r = MADCATZ_COLORS[n][0];
      int g = MADCATZ_COLORS[n][1];
      int b = MADCATZ_COLORS[n][2];  
      
      fill(r,g,b);
      if(MADCATZ[n] == 0){fill(102);}
      
      Color = buttons.getChild("Color"+n);
      Color.disableStyle();
      shape(Color, dx, 0);      
      
      fill(255,90);
      Button = buttons.getChild("Button"+n);
      Button.disableStyle();
      shape(Button, dx, 0);
      
      fill(r,g,b);
      if(MADCATZ[n] == 0){fill(102);}
      
      Cap = buttons.getChild("Cap"+n);
      Cap.disableStyle();
      shape(Cap, dx, 0);      
      
      fill(0);      
    }
  } 
 
  void hori()
  {
    noStroke();
    fill(211);
    buttons.disableStyle();
    shape(buttons, dx, 0);
    
    for(int n = 7; n >= 0; n--)
    {
      fill(#777777);
      if(HORI[n] == 1){fill(#999999);}; 
     
      Base = buttons.getChild("Base"+n);
      Base.disableStyle();
      shape(Base, dx, 0);
      
      int r = HORI_COLORS[n][0];
      int g = HORI_COLORS[n][1];
      int b = HORI_COLORS[n][2];  
      
      fill(r,g,b);
      if(HORI[n] == 0){fill(102);}
      
      Color = buttons.getChild("Color"+n);
      Color.disableStyle();
      shape(Color, dx, 0);      
      
      fill(255,90);
      Button = buttons.getChild("Button"+n);
      Button.disableStyle();
      shape(Button, dx, 0);
      
      fill(r,g,b);
      if(HORI[n] == 0){fill(102);}
      
      Cap = buttons.getChild("Cap"+n);
      Cap.disableStyle();
      shape(Cap, dx, 0);      
      
      fill(0);      
    }
  }   
}

