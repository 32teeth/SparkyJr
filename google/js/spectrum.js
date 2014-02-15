function spectrum()
{
	var DOMURL = self.URL || self.webkitURL || self;	

	var colors = document.getElementById("colors");
	var wheel = document.getElementById("spectrum");
	var context = colors.getContext("2d");
	context.drawImage(wheel, 0, 50);

	var data = '<svg version="1.1" id="pin" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="56.068px" height="80px" viewBox="0 0 56.068 80" enable-background="new 0 0 56.068 80" xml:space="preserve"><path id="pointer" d="M28.034,0C12.552,0,0,12.552,0,28.034C0,43.516,28.034,80,28.034,80s28.034-36.483,28.034-51.966 C56.068,12.551,43.517,0,28.034,0z"/><path id="sample" fill="#CCCCCC" stroke="#FFFFFF" stroke-width="3" stroke-miterlimit="10" d="M28.034,48.035 c-11.045,0-20-8.957-20-20c0-11.046,8.956-20,20-20c11.047,0,20,8.954,20,20C48.037,39.079,39.081,48.035,28.034,48.035z"/></svg>';

	var pin = new Image();
	var svg = new Blob([data], {type: "image/svg+xml;charset=utf-8"});
	var url = DOMURL.createObjectURL(svg);
	pin.onload = function()
	{
	    context.drawImage(pin, 100, 0);
	    DOMURL.revokeObjectURL(url);
	};
	pin.src = url;

	colors.addEventListener('mousemove', function(evt){
    	var m = getMousePos(colors, evt);
    	var rgb = context.getImageData(m.x, m.y, 1, 1).data;

    	context.drawImage(wheel, 0, 50);
    	var data = '<svg version="1.1" id="pin" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="56.068px" height="80px" viewBox="0 0 56.068 80" enable-background="new 0 0 56.068 80" xml:space="preserve"><path id="pointer" d="M28.034,0C12.552,0,0,12.552,0,28.034C0,43.516,28.034,80,28.034,80s28.034-36.483,28.034-51.966 C56.068,12.551,43.517,0,28.034,0z"/><path id="sample" fill="rgb('+rgb[0]+','+rgb[1]+','+rgb[2]+')" stroke="#FFFFFF" stroke-width="3" stroke-miterlimit="10" d="M28.034,48.035 c-11.045,0-20-8.957-20-20c0-11.046,8.956-20,20-20c11.047,0,20,8.954,20,20C48.037,39.079,39.081,48.035,28.034,48.035z"/></svg>';
		var pin = new Image();
		var svg = new Blob([data], {type: "image/svg+xml;charset=utf-8"});
		var url = DOMURL.createObjectURL(svg);    	
		pin.onload = function()
		{
		    context.drawImage(pin, m.x-28, m.y-80);
		    DOMURL.revokeObjectURL(url);
		};
		pin.src = url;		

  	}, false);	
}

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
      x: evt.clientX - rect.left,
      y: evt.clientY - rect.top
    };
  }

document.addEventListener('DOMContentLoaded', spectrum, false);