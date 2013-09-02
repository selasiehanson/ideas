'use strict';
var app = angular.module("models",['ngResource'])

app.factory("Project", ["$resource", function ($resource){
	return $resource('/api/projects/:id', {id : '@id'}, {	    
		query: { method: 'GET', isArray: false},
	    update : { method : 'PUT'}
	});
}]);

app.factory("Note", ["$resource", function ($resource){
	return $resource('/api/projects/:project_id/notes/:id', {project_id : "@project_id", id : '@id'}, {	    
		query: { method: 'GET', isArray: false},
	    update : { method : 'PUT'}
	});
}]);

app.factory("ProjectCategory", ["$resource", function ($resource){
	return $resource('/api/project_categories/:id', {id : '@id'}, {	    
		query: { method: 'GET', isArray: false},
	  update : { method : 'PUT'}
	});
}]);

app.factory("Task", ["$resource", function ($resource){
	return $resource('/api/projects/:project_id/tasks/:id', {project_id : "@project_id",id : '@id'}, {	    
		query: { method: 'GET', isArray: false},
	    update : { method : 'PUT'}
	});
}]);