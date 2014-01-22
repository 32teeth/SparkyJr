/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @description interface for Arduino based SparkyFive
*/

/*
** @description all import files for controller
*/
import java.util.*;
import procontroll.*;
import net.java.games.input.*;
import java.io.*;

ControllIO HIDs;
String HID = "";

/*
** @description all import files and definitions for serial and arduino
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
** @description set mouse type
** 0 = ARROW, 1 = HAND, 2 = pencil
*/
int mouseType = 0;
PImage pencil;

/*
** @description fonts
*/
PFont AR24;
PFont A14;

/*
** @description frame rate per second
*/
int fps = 120;

/*
** @description width and height of full screen
*/
int dW, dH;

/*
** @description Stick class
*/
Stick stick;

/*
** @description Menu Class and Screen class
*/
Menu menu;
Screens screens;
int screen;

/*
** @description Header Class
*/
Header header;

/*
** @description Header Class
*/
Footer footer;

/*
** @description Loading Class
*/
Loading loading;
float now = millis()+5000;

/*
** @description Com Class
*/
Com com;

/*
** @description width and height of full screen
*/
boolean activemodal = false;

/*
** @description width and height of full screen
*/
boolean full = true;


Sparky Sparky = this;

/*
** @method setup
** @description main processing setup
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
** @description main processing loop
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
** @description this is processing fullscreen mode based
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



