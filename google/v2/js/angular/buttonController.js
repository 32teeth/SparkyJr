/*
** @controller buttonController
** @desc get available serial ports, list them, connect to selected
*/
SparkyJr.controller("buttonController", ["$scope", function($scope){
	/*
	** @param parent {object} reference to serial serialProps
	*/
	var parent = $scope;
	$scope.address = parent.serialProps.address;
	$scope.values = [1,2,4,8,16,32,64,128]
	
	$scope.buttons = function()
	{
		$("path[id^='Check']").click(function(n){
			var i = $(this).attr("id").slice(-1);
			var selected = $(this).attr('selected') ? false : true;
			switch(selected)
			{
				// unchecked
				case true:
					$("path[id='Check" + i + "'], path[id='Base" + i + "'], path[id='Color" + i + "'], path[id='Cap" + i + "']").attr({"selected":true});
				break;
				// checked
				case false:
					$("path[id='Check" + i + "'], path[id='Base" + i + "'], path[id='Color" + i + "'], path[id='Cap" + i + "']").attr({"selected":false});
				break;
			}
			$scope.update();
		});
	}
	/*
	
	*/

	$scope.update = function()
	{
		parent.serialProps.address = 0;
		$("path[id^='Check']").each(function(n)
		{
			if($(this).attr('selected'))
			{
				var i = parseInt($(this).attr("id").slice(-1));
				parent.serialProps.address += $scope.values[i];
			}
		});
		parent.$apply();
	}

	$scope.buttons();
}]);