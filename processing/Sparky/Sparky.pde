/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @desc interface for Arduino based SparkyFive
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

/*
** @desc all import files and definitions for serial and arduino
*/
import processing.serial.*; 
Serial port;
String portstring = "";
String ports[];
int serial;
String command = "";
String action = "";
Boolean exec = false;
int baudrate = 115200;
boolean open = false;

/*
** @desc set mouse type
** 0 = ARROW, 1 = HAND, 2 = pencil
*/
int mouseType = 0;
PImage pencil;

/*
** @desc fonts
*/
PFont AR24;
PFont A14;

/*
** @desc frame rate per second
*/
int fps = 120;

/*
** @desc width and height of full screen
*/
int dW, dH;

/*
** @desc Stick class
*/
Stick stick;

/*
** @desc Menu Class and Screen class
*/
Menu menu;
Screens screens;
int screen;

/*
** @desc Header Class
*/
Header header;

/*
** @desc Header Class
*/
Footer footer;

/*
** @desc Loading Class
*/
Loading loading;
float now = millis()+5000;

/*
** @desc Com Class
*/
Com com;

/*
** @desc width and height of full screen
*/
boolean activemodal = false;

/*
** @desc width and height of full screen
*/
boolean full = true;


Sparky Sparky = this;

/*
** @method setup
** @desc main processing setup
*/
void setup()
{
  smooth();
  
  AR24 = loadFont("ArialRoundedMTBold-24.vlw");
  A14 = loadFont("ArialMT-14.vlw");
  
  pencil = loadImage("pencil.png");
  
  frame.setTitle("Sparky Jr. Configurator");
  
  dW = full ? displayWidth : 800;
  dH = full ? displayHeight : 700;  
  
  size(dW, dH);
  
  frameRate(fps);
  background(221);
  
  noStroke();
  
  // set HID
  HIDs = ControllIO.getInstance(this);
  
  // loading
  loading = new Loading();
  loading.setup();  
  
  // screens
  screens = new Screens();
  screens.setup();  
  
  // stick
  stick = new Stick();
  stick.setup();  
  
  // menu
  menu = new Menu();
  menu.setup();
  
  // header
  header = new Header();
  header.setup();

  // footer
  footer = new Footer();
  footer.setup();   

  // com
  com = new Com();  
}


/*
** @method draw
** @desc main processing loop
*/
void draw()
{
  background(221);
  mouseType = 0;
  tint(255,255);
  if(!activemodal)
  {
    stick.draw();
    menu.draw();
    header.draw();
    footer.draw();
  }
  else
  {
    if(screen != 1 && screen != 2)
    {
      stick.draw();
      menu.draw();
      header.draw();
      footer.draw();      
    } 
    screens.show(screen);
  }    
  if(now > millis())
  {
    int percent = 255;
    if(millis() > (now/2)){percent = (int)((100-(millis()/now)*100)*2.55)*5;}
    loading.draw(percent);
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
      cursor(pencil, 0, 30);
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



