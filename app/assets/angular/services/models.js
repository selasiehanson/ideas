'use strict';
var app = angular.module("models",['ngResource'])

app.factory("Project", function ($resource){
	return $resource('api/projects/:id', {id : '@id'}, {	    
		query: { method: 'GET', isArray: false},
	    update : { method : 'PUT'}
	});
});

app.factory("Note", function ($resource){
	return $resource('../api/projects/:project_id/notes/:id', {project_id : "@project_id", id : '@id'}, {	    
		query: { method: 'GET', isArray: false},
	    update : { method : 'PUT'}
	});
});

app.factory("ProjectCategory", function ($resource){
	return $resource('api/project_categories/:id', {id : '@id'}, {	    
		query: { method: 'GET', isArray: false},
	  update : { method : 'PUT'}
	});
});

app.factory("Task", function ($resource){
	return $resource('api/tasks/:id', {id : '@id'}, {	    
		query: { method: 'GET', isArray: false},
	    update : { method : 'PUT'}
	});
});

// app.factory("RolesUser", function ($resource){
// 	return $resource("api/user_roles", { id: '@id'},{
// 		query : { method : "GET",isArray : false},
// 		update : { method: "PUT"}
// 	});
// });

// app.factory("Permission", function ($resource){
// 	return $resource('api/permissions/:id', {id : '@id'}, {	    
// 		query: { method: 'GET', isArray: false},
// 	    update : { method : 'PUT'}

// 	});
// });

// app.factory("RolePermission", function ($resource){
// 	return $resource('api/roles/:role_id/permissions_roles/:id', {id : '@id', role_id: "@role_id"}, {	    
// 		query: { method: 'GET', isArray: false},
// 	    update : { method : 'PUT'}

// 	});
// });

// app.factory("Product", function ($resource){
// 	return $resource('api/products/:id', {id : '@id'}, {	    
// 		query: { method: 'GET', isArray: false},
// 	    update : { method : 'PUT'}

// 	});
// });

// app.factory("ProductCategory", function ($resource){
// 	return $resource('api/product_categories/:id', {id : '@id'}, {	    
// 		query: { method: 'GET', isArray: false},
// 	  update : { method : 'PUT'}
// 	});
// });

// app.factory("PurchaseOrder",function ($resource){
// 	return $resource('api/purchase_orders/:id', {id : '@id'}, {	    
// 		query: { method: 'GET', isArray: false},
// 	    update : { method : 'PUT'}
// 	});
// });

// app.factory("Purchase",function ($resource){
// 	return $resource('api/purchases/:id', {id : '@id'}, {	    
// 		query: { method: 'GET', isArray: false},
// 	    update : { method : 'PUT'}
// 	});
// });

// app.factory("Sale",function ($resource){
// 	return $resource('api/sales/:id', {id : '@id'}, {	    
// 		query: { method: 'GET', isArray: false},
// 	    update : { method : 'PUT'}
// 	});
// });