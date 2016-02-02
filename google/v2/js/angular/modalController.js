/*
** @controller modalController
** @desc view state of modals
*/
SparkyJr.controller("modalController", ["$scope", function($scope){
	/*
	** @param open {boolean} 
	*/
	$scope.open = false;

	/*
	** @param modal {DOM Obj} 
	*/
	$scope.modal;

	/*
	** @method init
	** @desc 
	*/
	$scope.init = function()
	{
		$(".main").removeClass("blur");
		$(".modal, .screen").hide();

		$("[data-modal]").on("click", function(){
			$scope.modal = $(this).attr("data-modal");
				if($scope.modal != "close")
				{
					if(!$(this).hasClass("disabled"))
					{
						$scope.show($scope.modal);
					}
				}
				else
				{
					$scope.hide();
				}
		});
	}

	/*
	** @method show
	** @desc show requested modal, fade out old one
	*/
	$scope.show = function(modal)
	{
		if(!$scope.opened)
		{
			if(modal != "color")
			{
				$(".main").addClass("blur");
				$(".screen").fadeIn();
			}
			else
			{
				$("header").addClass("blur");
			}
			$(".modal#" + modal).fadeIn();
			$scope.opened = true;
		}
		else
		{
			$(".modal:visible").hide();
			$(".modal#" + modal + " .body, .modal#" + modal + " .button").hide().fadeIn();
			$(".modal#" + modal).show();
		}
	}

	/*
	** @method hide
	** @desc hide current modal
	*/
	$scope.hide = function()
	{
		$(".modal").fadeOut();	
		$(".main, header").removeClass("blur");
		$(".screen").fadeOut();							

		$scope.opened = false;						
	}

	$scope.init();		
}]);