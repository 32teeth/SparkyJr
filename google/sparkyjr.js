chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('sparkyjr.html', {
    'bounds': {
      'width': 1024,
      'height': 800
    }
  });
});