/*
** @controller serialController
** @desc get available serial ports, list them, connect to selected
*/
SparkyJr.controller("serialController", ["$scope", function($scope){
	
	/*
	** @param serial {serial} abstraction of chromes serial object
	*/
	$scope.serial = chrome.serial;

	/*
	** @param ports {array} list of available ports
	*/
	$scope.port = -1;
	$scope.ports = [];
	$scope.portid = -1;
	$scope.portstring;
	$scope.baudrates = [115200, 57600, 38400, 28800, 19200, 14400, 9600, 4800, 2400, 1200, 600, 300];
	$scope.baudrate;

	$scope.address = 0;
	$scope.setter;
	$scope.command;


	$scope.hex;
	$scope.long;
	$scope.rgb;


	/*
	** @method get
	** @desc collect all available ports and push to ports array
	*/
	$scope.get = function()
	{
		$scope.serial.getPorts(function(ports){
			for(var n = 0; n < ports.length; n++)
			{
				var port = ports[n].toString();
				$scope.ports.push(
					{
						id:n,
						long:port,
						short:port.slice(port.lastIndexOf("/")+1, port.length),
						selected:false
					}
				);
			}
			$scope.$apply();
		});
	}

	/*
	** @method get
	** @desc collect all available ports and push to ports array
	*/
	$scope.set = function()
	{
		var command = document.getElementById("set").value;
		$scope.write(command);

		setTimeout(function(){
			$scope.display();
		},250);
	}	

	/*
	** @method open
	** @desc collect all available ports and push to ports array
	*/	
	$scope.open = function()
	{
		$scope.portstring = $scope.ports[$scope.port].long;
		$scope.serial.open($scope.portstring, {bitrate:$scope.baudrate}, $scope.info)
	}

	$scope.info = function(info)
	{
		$scope.portid = info.connectionId;
		$scope.$apply();
	}

	/*
	** @method send
	** @desc send data to port
	*/	
	$scope.write = function(command)
	{
		var buffer = $scope.buffer(command);
		$scope.serial.write($scope.portid, buffer, function(){console.log("turn on the lights");});
		//$scope.serial.flush($scope.port, function(){console.log("wooooooosh!");});
	}

	/*
	** @method display
	** @desc create command and send
	*/	
	$scope.display = function()
	{
		var command = "display " + $scope.address;
		$scope.write(command);
	}

	/*
	** @method buffer
	** @desc simple buffer utility
	*/	
	$scope.buffer = function(command)
	{
		var buffer = new ArrayBuffer(command.length);
		var view = new Uint8Array(buffer);
		for(var n = 0; n < command.length; n++)
		{
			view[n]=command.charCodeAt(n);
		}
		return buffer;
	}	


	/*
	** @method buttons
	** @desc this is the address manager for all the buttons
	*/	
	$scope.buttons = function()
	{
		$scope.address = 0;
		var buttons = document.getElementsByClassName("btn");
		for(var n = 0; n < buttons.length; n++)
		{
			var button = buttons[n];
			if(button.checked)
			{
				$scope.address += parseInt(button.value);
			}
		}

	}	

	/*
	** @method color conversion
	*/	
	$scope.colors = function()
	{
		$scope.hex = document.querySelector('input[type="color"]').value.slice(1,7);

		/*
		** @desc to long
		*/		
		$scope.long = parseInt($scope.hex, 16);
		/*
		** @desc to RGB
		*/
		$scope.rgb = [
		    $scope.long >> 16,
		    $scope.long >> 8 & 0xFF,
		    $scope.long & 0xFF
		];

		console.log($scope.hex + ":" + $scope.rgb + ":" + $scope.long)
	}

	/*
	** @@desc invoke
	*/
	$scope.get();
}]);