/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 22nd, 2014
** @desc hero video player
*/

/*
** @desc import video files
*/
import processing.video.*;

/*
** @desc declare Video object
*/
Video video = document.querySelector("video");
String ext;
PImage img;
PImage poster;
var canvas = document.querySelector('canvas');
var ctx;

/*
** @desc video dimensions
*/
int vw = 1280, vh = 720;
int ratio = vh/vw;

/*
** @desc width and height of full screen
*/
int dw = window.innerWidth, dh = window.innerHeight;

/*
** @method setup
** @desc main processing setup
*/
void setup()
{
	dh = dw*ratio;
	size(dw, dh, P2D);
	smooth();
	noStroke();
	background(255);

	ext = source();
	ctx = canvas.getContext('2d');

	poster = loadImage("video/sparkydark.jpg");
	$("#content").css({top:$("canvas").height()-50});	
}

/*
** @method draw
** @desc main processing loop
*/
void draw()
{
	dw = window.innerWidth;
	dh = dw*ratio;
	size(dw, dh, P2D);
	ratio = vh/vw;
	image(poster, 0, 0, dw, dh);
	//ctx.drawImage(video, 0, 0, dw, dh);

	fill(255);
	text("hello", 100, 10);
}

/*
** @method source
** @desc get the type of video that the browser can play
** @return returns video playable type {String}
*/
String source()
{
	return video.canPlayType && video.canPlayType("video/ogg") ? "ogv" : "mp4";
}

void content()
{
	document.getElementById("content").style.top = dh + "px";	
}