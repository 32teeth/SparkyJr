/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 22nd, 2014
** @description hero video player
*/

/*
** @description import video files
*/
import processing.video.*;

/*
** @description declare Video object
*/
Video video = document.getElementById("hero");
String ext;
PImage img;
var ctx;

/*
** @description video dimensions
*/
int vw = 1280, vh = 720;
int ratio = vh/vw;

/*
** @description width and height of full screen
*/
int dw = window.innerWidth, dh = window.innerHeight;

/*
** @method setup
** @description main processing setup
*/
void setup()
{
	size(dw, dh, P2D);
	smooth();
	noStroke();
	background(221);

	ext = source();
	ctx = externals.context;
}

/*
** @method draw
** @description main processing loop
*/
void draw()
{
	dw = window.innerWidth;
	dh = window.innerHeight;
	size(dw, dh, P2D);
	ratio = vh/vw;
	ctx.drawImage(video, 0, 0, dw, dw*ratio);
}

/*
** @method source
** @description get the type of video that the browser can play
** @return returns video playable type {String}
*/
String source()
{
	return video.canPlayType && video.canPlayType("video/ogg") ? "ogv" : "mp4";
}