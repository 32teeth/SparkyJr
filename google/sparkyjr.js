chrome.app.runtime.onLaunched.addListener(function() {
	chrome.app.window.create('sparkyjr.html', 
	{
		///*
		'bounds': 
		{
			'width': 800,
			'height': 450
		}
		//*/
		//state:"fullscreen"
	});
});