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

	$scope.connected = false;


	/*
	** @method get
	** @desc collect all available ports and push to ports array
	*/
	$scope.get = function()
	{
		$scope.serial.getDevices(function(ports){
			for(var n = 0; n < ports.length; n++)
			{
				var port = ports[n].path.toString();
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
		$scope.send(command);

		setTimeout(function(){
			$scope.display();
		},250);
	}	

	/*
	** @method connect
	** @desc collect all available ports and push to ports array
	*/	
	$scope.connect = function()
	{
		$scope.portstring = $scope.ports[$scope.port].long;
		$scope.serial.connect($scope.portstring, {bitrate:$scope.baudrate}, $scope.info);
	}

	/*
	** @method open
	** @desc collect all available ports and push to ports array
	*/	
	$scope.disconnect = function()
	{
		$scope.send("exit");
		$scope.portid = -1;
		$scope.connected = false;
		$scope.serial.disconnect($scope.portid, function(){});
	}	

	$scope.info = function(info)
	{
		$scope.portid = info.connectionId;
		$scope.connected = true;
		$scope.$apply();
	}

	/*
	** @method send
	** @desc send data to port
	*/	
	$scope.send = function(command)
	{
		var buffer = $scope.buffer(command);
		$scope.serial.send($scope.portid, buffer, function(){});
	}

	/*
	** @method display
	** @desc create command and send
	*/	
	$scope.display = function()
	{
		var command = "display " + $scope.address;
		$scope.send(command);
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
			document.querySelectorAll("input[type='checkbox'] + label")[n].style.background = "#FFFFFF";
			if(button.checked)
			{
				$scope.address += parseInt(button.value);
				document.querySelectorAll("input[type='checkbox'] + label")[n].style.background = $scope.hex;
			}
		}

	}	

	/*
	** @@desc invoke
	*/
	$scope.get();
}]);