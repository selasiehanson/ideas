app =  angular.module("app")

app.controller "TasksController", [ "$scope", "Task", "MSG", "Data", ($scope,Task, MSG, Data)->
	$scope.data = Data
	$scope.tasks = 0

	$scope.$watch "data.project_id", (val)->
		if val
			getTasks(val)
		return

	$scope.$watch "tasks.length", (val)->
		if val
			getTasks()
		return

	# $scope.$watch "data.tasksChanged",  (val)->
	# 	console.log("changing as" + val) 
	# 	if val
	# 		console.log "updated"
	# 	return	

	$scope.updateTask = (task, newStatus)->
		task = new Task(task)
		$scope.current_task_id = task.id
		task.status =  newStatus
		task.$update (res)-> 
			$scope.current_task_id = null
			if res.success			
				task = res.data
				newTask = _.find($scope.data.project.tasks, (_task)->
					_task.id == task.id
				)
				newTask.status = task.status
				getTasks()
			else
				msg = res.message || "Something went wrong please try again"
				MSG.error msg
				
		return

	getTasks = (project_id)->
		$scope.tasks = window.tasks = $scope.data.project.tasks
		$scope.completedTasks = _.filter($scope.tasks, (task)-> task.status == "completed" )
		$scope.pendingTasks 	= _.filter($scope.tasks, (task)-> task.status == "pending" )
		$scope.startedTasks 	= _.filter($scope.tasks, (task)-> task.status == "started" )
			
		return
	return]