angular.module("date_component",["helpers"]).directive("axDate", [ "$filter","DateHelper",function ($filter,DateHelper){
	window.dd  = $filter;
	var defaultFormat = "dd-mm-yyyy";
	
	var timestamp;
	var linkFn = function (scope,element,attrs,ngModel){
		var val = "";
		var format = attrs["format"] || defaultFormat ;
		var dtp = $(element).datepicker({
			//format : format
		});
		window.el = dtp;
		//listen on the datepicker's change event
		dtp.on('changeDate', function(ev){
			val = dtp.data().datepicker.date;
			timestamp = (+ new Date(val));
			dtp.datepicker('hide');
			updateModel();
		});

		scope.$watch(attrs.ngModel , function (val){
			if(val){
				dtp.datepicker("update",new Date(val));
			}
			
		});
		
		//bind any changes on the input to the model
		element.bind("change",updateModel);

		// Write data to the model
		// Please note that model's cannot deal with javascript objects but must rather be broken down into  string
        var updateModel = function(){
        	scope.$apply(function () {
        		window.yy = val;
        		var viewValue = $filter('date')(timestamp, DateHelper.formats[format]);
        		
        		ngModel.$setViewValue((new Date(val)).toISOString());
				dtp.val(viewValue);
	        });
        }
	}

	return { 
		require: '?ngModel',
		restrict : "C",
		link : linkFn 
	}	
}]);