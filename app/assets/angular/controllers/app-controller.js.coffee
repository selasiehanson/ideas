app = angular.module "app"

app.controller "AppController", ["$scope", "Data", "View", ($scope, Data, View)->
	$scope.data = Data
	$scope.view = View
	return]