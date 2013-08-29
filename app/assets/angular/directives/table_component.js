var app = angular.module("table_component", [])
app.directive("axTable", function ($compile){
	// var options = scope.$eval(iAttrs.config);

	var linkFn = function (scope,element, attrs, ctrl) {
		var tableDefinition = scope.$eval(attrs.config);
		// console.log(ctrl)
		var headers = tableDefinition["headers"] || [];
		var data = tableDefinition["data"] || [];
		scope.headers = headers;
		scope.items = data;

		window.kk = headers
		var headerNames  = [];

		var html = "";
		html += "<table class='table ax-table table-bordered table-striped'  >";
		html += "<thead>";
		
		var head = "<th class='ax-grid-action-1'>#</th>";
		var body = "<td> {{ $index + 1}}. </td>";
		
		for(var i=0; i < headers.length; i++){
			// head += "<th> {{ header." + headers[0]["key"] + "}}</th>";
			body += "<td> {{ item."+ headers[i]["key"] +"}}</td>";
		}

		html += "<tr>";
		if (headers.length > 0) {
			html += "<th class='ax-grid-action-1'>#</th>";	
		};
		
		html += "<th ng-repeat='header in headers'> {{ header.value }} </th>"
		html += "</tr>";
		html += "</thead>";
		html += "<tr ng-repeat='item in items'>"+ body +"</tr>"
		
		html += "</table></div>"
		html += "</div>"
		element.html(html);

		window.ll = scope;

		scope.$watch("items",function (val){
			// console.log("val is")
			// console.log(val)
		});

		$compile(element.contents())(scope);
		
		setTimeout(function (){
			scope.$digest();
		}, 700);

		
		attrs.$observe(attrs.ngModel,function (val){
			// console.log(val)
		})
	}


	return {
		require: '?ngModel',
		transclude : false,
		restrict: "E",
		link : linkFn,
		controller : function ($scope){
			$scope.err = {name : "ERR"}
			// console.log($scope)
			$scope.$watch("items", function (){
				// console.log("changed")
			});

		}
	}
});