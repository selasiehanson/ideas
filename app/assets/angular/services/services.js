'use strict';
var app  =  angular.module('app');

app.factory('Printer', function (){
	return {
		print : function (options){
			options = options || {}
			var model = options.model 
			var id = options.id || null
			var callback = options.callback || null
			var url = "/print/record/#/";
			if(id) {
				 url +=  model +"/"+ id +"/show"
			}else {
				url += model
			}

			var win = window.open(url, null,'height=720,width=960', false);	
				win.onload = function (){
					// win.document.getElementById("report_title").innerHTML = title ;
					// win.document.getElementById('report_label').innerHTML = filterLabel;
					// win.document.getElementById("report_body").innerHTML = body;	
					if(callback)
						callback()
					
				}

		}
	}
});
