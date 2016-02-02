/*
** @controller sparkyController
** @desc parent controller class to all controllers
*/
SparkyJr.controller("sparkyController", ["$scope", function($scope){

	$scope.wizard = false;

	/*
	** @desc serialController parameters
	** ----------------------------------------------------------------
	*/
	$scope.serialProps = {
		/*
		** @param serial {serial} abstraction of chromes serial object
		*/
		serial:chrome.serial,

		/*
		** @param ports {array} list of available ports
		*/
		port:-1,
		ports:[],
		portid:-1,
		portstring:"",
		baudrates:[115200, 57600, 38400, 28800, 19200, 14400, 9600, 4800, 2400, 1200, 600, 300],
		baudrate:115200,
		address:0,
		setter:"",
		command:"",
		connected:false
	}

	/*
	** @desc usbController parameters
	** ----------------------------------------------------------------
	*/
	$scope.usbProps = {
		/*
		** @param serial {serial} abstraction of chromes serial object
		*/
		usb:chrome.usb,

		/*
		** @param ports {array} list of available ports
		*/
		device:-1,
		devices:[]
	}	

	/*
	** @desc colorController parameters
	** ----------------------------------------------------------------
	*/	
	$scope.colorProps = {
		rgb:"#777777",
		hex:"",
		long:"",
	}
}]);