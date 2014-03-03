/*
** @controller serialController
** @desc get available serial ports, list them, connect to selected
*/
SparkyJr.controller("screenController", ["$scope", function($scope){
	
	/*
	** @param serial {serial} abstraction of chromes serial object
	*/
	$scope.screens = {
		serial_intro:{
			complete:false
		},
		serial:{
			complete:false
		},
		device_intro:{
			complete:false
		},
		device:{
			complete:false
		},
		color:{
			complete:false
		},		
		options:{
			complete:false
		},
		exit:{
			complete:false
		}
	};
}]);