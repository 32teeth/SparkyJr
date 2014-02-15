/*
** @author Eugene Andruszczenko
** @version 0.2
** @date January 30th, 2014
** @desc interface for Arduino based Sparky
*/

PShape pin = loadShape("images/pin.svg");
PImage colors = loadShape("images/colors.png");

/*
** @method setup
** @desc main processing setup
*/
void setup()
{
	smooth();
	size(740, 182);
	frameRate(120);
  	background(255);
  	noStroke();	
}

/*
** @method draw
** @desc main processing loop
*/
void draw()
{
  background(255);
  image(colors, 0, 0);
}