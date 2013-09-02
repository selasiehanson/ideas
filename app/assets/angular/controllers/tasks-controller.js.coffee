app =  angular.module("app")

app.controller "TasksController", [ "$scope", "Task", "MSG", "Data", ($scope,Task, MSG, Data)->
	$scope.data = Data

	$scope.$watch "data.project_id", (val)->
		if val
			getTasks(val)
		return

	$scope.updateTask = (state)->
		console.log state
		return

	getTasks = (project_id)->
		Task.query { project_id: project_id },(res)=>
			$scope.completedTasks = res.data.completed
			$scope.pendingTasks = res.data.pending
			$scope.startedTasks = res.data.started
			return
		return
	return]