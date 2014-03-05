/*
** @controller colorController
** @desc 
*/
SparkyJr.controller("colorController", ["$scope", function($scope){
	/*
	** @param parent {object} reference to serial serialProps
	*/
	var parent = $scope;
	$scope.color = parent.colorProps;


	//$("[data-modal='color']").trigger("click");
	//
	

	$scope.set = function()
	{
		$$scope = angular.element(document.getElementById("serial")).scope();
		$$scope.set();
	}		
}]);