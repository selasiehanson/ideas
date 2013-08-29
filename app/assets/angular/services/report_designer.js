var app  = angular.module("app");
app.service("ReportDesigner", function ($http){
	return {
		get : function (type){
			var url = "";
			var prefix = "report_designer";
			
			switch(type){
				case "models":
					url =  prefix + "/models";
				break;
			}
			
			if(url) {
				return $http.get(url);
			}
		},
		post: function (url, data){
			
			var prefix = "report_designer";
			if (url) {
					url =  prefix + "/" + url;
				return $http.post(url, data)
			}
		},
		models : function (){
			return this.get("models");
		}, 
		runQuery : function (query){
			return this.post("run", query);
		},
		saveReport: function (){

		} 
	}
});
