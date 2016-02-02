/*
** @controller serialController
** @desc get available serial ports, list them, connect to selected
*/
SparkyJr.controller("usbController", ["$scope", function($scope){
	/*
	** @param serial {object} reference to parent serialProps
	*/
	var parent = $scope.usbProps;


	/*
	** @method get
	** @desc collect all available ports and push to ports array
	*/
	$scope.get = function()
	{
		parent.devices.push(
			{
				id:0,
				long:"No Device Found",
				short:"No Device Found",
				selected:false
			}
		);	
	}

	/*
	** @@desc invoke
	*/
	$scope.get();
}]);