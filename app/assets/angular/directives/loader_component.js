var app  = angular.module("loader_component", []);

app.directive("axLoader", [function (){

	var loader = {
		restrict: "C",
		template: "<span ng-show='visible' class='ax-loading clearfix'> <span class='img pull-left'> </span>	<span class='pull-left'> {{ text }} </span>  </span>",
		scope: {
			visible: "=",
			text: "@"
		},
		replace: false
	}
	return loader;
}]);