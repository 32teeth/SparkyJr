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
	$scope.bitrates = [115200, 57600, 38400, 28800, 19200, 14400, 9600, 4800, 2400, 1200, 600, 300];
	$scope.bitrate = $scope.bitrates[0];


	/*
	** @method get
	** description collect all available ports and push to ports array
	*/
	$scope.get = function(){
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
	** @method open
	** description collect all available ports and push to ports array
	*/	
	$scope.open = function(id)
	{
		
	}


	/*
	** @description invoke
	*/
	$scope.get();
}]);