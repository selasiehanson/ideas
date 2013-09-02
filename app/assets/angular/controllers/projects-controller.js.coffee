app = angular.module "app"

app.controller "ProjectsController", ["$scope", "Project", "ProjectCategory" ,"MSG" , "$location", "Data" ,($scope, Project, ProjectCategory, MSG, $location, Data)->
	
	$scope.projects = []
	$scope.data = Data

	$scope.editProject = (project)->
		$scope.project = project
		setCurrentProject(project.id)
		return

	$scope.viewNotes = (project)->
		setCurrentProject(project.id)
		return

	$scope.viewTasks = (project)->
		setCurrentProject(project.id)
		return

	setCurrentProject = (project_id) ->
		$scope.data.project_id = project_id;
		return

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
	getUsersProjectsCategories()
	return
]