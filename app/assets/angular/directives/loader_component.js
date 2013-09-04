var app  = angular.module("loader_component", []);

app.directive("axLoader", [function (){

	var loader = {
		restrict: "C",
		template: "<span ng-show='visible' class='ax-loading'> <img src='/assets/icons/gif-load.gif' /> {{ text }} </span>",
		scope: {
			visible: "=",
			text: "@"
		},
		replace: false
	}
	return loader;
}]);