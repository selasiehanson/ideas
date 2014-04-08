angular.module("messenger",[]).directive("axMsg", ["$rootScope", function ($rootScope){
	var linkFn = function (scope, element, attrs){

		var timer;
		
		$rootScope.$on('incomingMessage', function (event, args){
				process(args)
		});

		function process(args){
			args = args || {}
			switch(args.status){
				case "success":
					scope.type = "alert-success";
				break;
				case "info":
					scope.type = "alert-info";
				break;
				case "warn":
					scope.type = "";
				break;
				default:
					scope.type  = "alert-error"
				break;
			}
			scope.display = ( args.show === true ) ? true : false
			scope.message = args.message || "";
			if(args.status == "success"){
        if(timer){
          clearTimeout(timer);
        }

        timer = setTimeout(function (){
          scope.display = false;
          scope.$apply();

        }, 5000);
      }
		}
	}

	return {
		restrict: "E",
		link : linkFn,
		template: '<div class="alert {{ type }} notification-box" ng-show="display"> <button type="button" class="close" ng-click="display=false">&times;</button> {{ message }} </div>',
		scope: {
			message: "@",
			display: "@",
			type: "@"
		}
	}
}]);
