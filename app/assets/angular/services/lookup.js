var app = angular.module("app");

app.service("LookUp", function ($http, apiPrefix){
	return {
		els : {},
		register: function (model,route){
			this.els[model] = { route: route}
		},
		query : function(){

		},
		get : function (){

		},
		create : function (model, data, callback){
			// 
			// var injector =  angular.injector(["models"])
			// var Model = injector.get(model)
			// var newModel = new Model(data)
			// newModel.$save().$then(function (){
			// 	if (callback) {
			// 		callback();
			// 	};
			// })

			var url = this.els[model]	 
			console.log(url)
			var path = apiPrefix + "/"+ url.route;
			$http.post(path, data).then(function (res){
				if (callback) {
					callback(res);
				}
			})
		},
		update : function (){

		},
		destroy : function(){

		}
		
	}
});