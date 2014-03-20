/*
** @controller serialController
** @desc get available serial ports, list them, connect to selected
*/
SparkyJr.controller("serialController", ["$scope", function($scope){
	/*
	** @param parent {object} reference to serial serialProps
	*/
	var parent = $scope;
	var serial = parent.serialProps


	/*
	** @method get
	** @desc collect all available ports and push to ports array
	*/
	$scope.get = function()
	{
		serial.serial.getDevices(function(ports){
			for(var n = 0; n < ports.length; n++)
			{
				var port = ports[n].path.toString();
				serial.ports.push(
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

		if(serial.portstring == "")
		{
			$("[data-modal='serial_intro']").trigger("click");
		}
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
		serial.portstring = serial.ports[serial.port].long;
		serial.serial.connect(serial.portstring, {bitrate:serial.baudrate}, $scope.info);

		if(!parent.wizard)
		{
			$("[data-modal='device_intro']").trigger("click");
			parent.wizard = true;
		}
	}

	/*
	** @method open
	** @desc collect all available ports and push to ports array
	*/	
	$scope.disconnect = function()
	{
		$scope.send("exit");
		serial.portid = -1;
		serial.connected = false;
		serial.serial.disconnect(serial.portid, function(){});
	}	

	$scope.info = function(info)
	{
		serial.portid = info.connectionId;
		serial.connected = true;
		$scope.$apply();
	}

	/*
	** @method send
	** @desc send data to port
	*/	
	$scope.send = function(command)
	{
		var buffer = $scope.buffer(command);
		serial.serial.send(serial.portid, buffer, function(){});
	}

	/*
	** @method display
	** @desc create command and send
	*/	
	$scope.display = function()
	{
		var command = "display " + serial.address;
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
	** @@desc invoke
	*/
	$scope.get();
}]);