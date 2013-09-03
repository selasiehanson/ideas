app = angular.module "app"

app.controller "AppController", ["$scope", "Data", ($scope, Data, View)->
	$scope.data = Data
	$scope.view = View

	$scope.$watch "view.showTasks", (val)->
		console.log val
	
	$scope.$watch "view.showNotes", (val)->
		console.log val


	return]