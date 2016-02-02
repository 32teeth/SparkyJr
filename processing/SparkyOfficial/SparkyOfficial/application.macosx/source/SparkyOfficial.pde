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
boolean full = true;

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
  
  dw = full ? displayWidth : 800;
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
      com.set(stick.address, stick.COLOR);
    }
    exec = false;
    action = "";
    command = "";
  }
}

