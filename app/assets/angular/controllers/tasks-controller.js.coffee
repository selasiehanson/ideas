app =  angular.module("app")

app.controller "TasksController", [ "$scope", "Task", "MSG", "Data", ($scope,Task, MSG, Data)->
	$scope.data = Data

	$scope.$watch "data.project_id", (val)->
		if val
			getTasks(val)
		return

	$scope.$watch "data.tasksChanged",  (val)->
		if val
			getTasks()
		return	

	$scope.updateTask = (task, newStatus)->
		task = new Task(task)
		task.status =  newStatus
		task.$update (res)->
			task = res.data
			newTask = _.find($scope.data.project.tasks, (_task)->
				_task.id == task.id
			)
			newTask.status = task.status
			getTasks()
		return

	getTasks = (project_id)->
		tasks = window.tasks = $scope.data.project.tasks
		$scope.completedTasks = _.filter(tasks, (task)-> task.status == "completed" )
		$scope.pendingTasks 	= _.filter(tasks, (task)-> task.status == "pending" )
		$scope.startedTasks 	= _.filter(tasks, (task)-> task.status == "started" )
			
		return
	return]