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
