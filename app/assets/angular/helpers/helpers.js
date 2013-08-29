'use-strict';

var app = angular.module('app')

app.factory("MSG", function ($rootScope){
	return {
		show : function (message, status){
			var scope = $rootScope.$new();
			scope.$emit("incomingMessage", { message: message, status: status, show: true })
		},
		success: function (message){
			this.show(message, "success");
		},
		error: function (message){
			this.show(message, "error");
		},
		warn: function (message){
			this.show(message, "warn");
		},
		info: function (message){
			this.show(message, "info");
		},
		hide : function (){
			//hides this widget if it is displayed
			var scope = $rootScope.$new();
			scope.$emit("incomingMessage", { message: "", status: null, show: false })
		}
	}
});

app.factory("Aggregate", function (){
	return {
		SUM : function (items,field ,type){
			type = type || ""
			var  parseFxn  = null;
			switch (type.toLowerCase()){
				case "float":
					parseFxn = parseFloat;
				break;
				default :
					parseFxn = parseInt;
				break;
			}
			var total = 0;
			items.forEach(function (item){
				total += parseFxn(item[field]);
			});

			return total;
		}
	}
})


