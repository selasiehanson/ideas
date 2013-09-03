app = angular.module("services", [] )
app.factory("Data", ()->
	project : {},
	project_id: null,
	title : ""
).factory("View", ()->
	showProjects : true,
	showsNotes: false,
	showTasks: false
)