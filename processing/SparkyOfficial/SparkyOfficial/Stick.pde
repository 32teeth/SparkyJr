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
    display();    
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
      if(r == 254 && g == 254 && b == 254 && selected[n] == 1){fill(238);};
      
      Cap = buttons.getChild("Cap"+n);
      Cap.disableStyle();
      shape(Cap, dx, 0);      
      
      fill(0);      
    }
  }
}
