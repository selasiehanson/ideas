app = angular.module "app"

app.controller "ProjectsController", ["$scope", "Project", "ProjectCategory" ,"MSG" , "$location", "Data", "View" ,($scope, Project, ProjectCategory, MSG, $location, Data, View)->
	
	$scope.project = {}
	$scope.projects = []
	$scope.data = Data
	$scope.view = View

	$scope.submit = ()->
		$scope.isSaving = true
		project = new Project($scope.project)
		if $scope.project.id
			project.$update (res)->
				$scope.isSaving =  false
				afterSave(res)				
				if res.success
					_project = _.find $scope.projects, (item)->
						item.id ==  $scope.project.id
					idx = $scope.projects.indexOf(_project)
					$scope.projects[idx] = res.data[0]
					defaults()
		else
			project.$save (res)->
				$scope.isSaving =  false
				afterSave(res)
				if res.success
					$scope.projects.unshift res.data[0]
		return
	
	$scope.editProject = (project)->
		$scope.project = project
		$scope.buttonText = "Update"
		$scope.formTitle = "Edit"
		setCurrentProject(project)
		return

	$scope.viewNotes = (project)->
		setCurrentProject(project)
		$scope.view.showNotes = true
		console.log "logged"
		return

	$scope.viewTasks = (project)->
		$scope.view.showTasks = true
		setCurrentProject(project)
		console.log "logged"
		return

	setCurrentProject = (project)->
		$scope.data.project = project
		$scope.data.project_id = project.id;
		return

	$scope.clear = ()->
		defaults()

	afterSave = (res)->
		notify(res.success, res.message)
		$scope.project.content = ""
		return

	notify = (status, message) ->
		if status
			MSG.success(message)
		else
			MSG.error(message)

	defaults = ()->
		$scope.buttonText = "Create"
		$scope.formTitle = "New"

	getProjects = ()->
		Project.query (res)->
			$scope.projects = res.data
			return
		return
		
	getUsersProjectsCategories = ()->
		ProjectCategory.query (res)->
			$scope.userProjectsCategories = res.data
			return
		return

	setTimeout(getProjects, 100)
	defaults()
	getUsersProjectsCategories()
	return
]