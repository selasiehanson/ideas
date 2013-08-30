var app = angular.module("rep_table_component", [])
app.directive("repTable", [function ($compile){
	var linkFn = function (scope,element, attrs, ctrl) {
		scope.$on("repDataChanged", function (ev, args){
			updateView();
		});

		function updateView(){
			var html = "";
			if (scope.tableData) {
				html += "<table class='table ax-table table-bordered table-striped'  >";
				html += "<thead>";
					
				var head = "<th class='ax-grid-action-1'>#</th>";
				var body = "<td> {{ $index + 1}}. </td>";
				
				for(var i=0; i < scope.tableData.headers.length; i++){
					// head += "<th> {{ header." + headers[0]["key"] + "}}</th>";
					body += "<td> {{ item."+ scope.tableData.headers[i]["key"] +"}}</td>";
				}

				// console.log(scope.tableData.results)
				html += "<tr>";
				if (scope.tableData.headers.length > 0) {
					html += "<th class='ax-grid-action-1'>#</th>";	
				};
				
				html += "<th ng-repeat='header in tableData.headers'> {{ header.value }} </th>"
				html += "</tr>";
				html += "</thead>";
				html += "<tr ng-repeat='item in tableData.results'>"+ body +"</tr>"
				
				html += "</table></div>"
				html += "</div>"
				element.html(html)
				$compile(element.contents())(scope);
			}
		
		}
		updateView();
		
	}

	return {
		require: '?ngModel',
		transclude : true,
		scope : {
			tableData : "="
		},
		restrict: "E",
		replace: true,
		link : linkFn
	}
}]);