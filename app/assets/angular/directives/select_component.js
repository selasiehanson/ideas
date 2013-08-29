angular.module("select2_component",[]).directive("axSelect", ["$compile", "$rootScope",function ($compile, $rootScope){
	var linkFn;
	linkFn = function (scope,element,attrs, ngModel){
		var sel = $(element).find("select");
		var list = attrs["watch"];
		var prop = attrs["prop"];
		var allowCreate = window.pp = eval(attrs["create"]) || false
		var createModel = attrs["model"]
		var _selectEl = element.children()[0];

		//check to see if we are using a multi select
		var isMultiple = $(_selectEl).attr("multiple");

		var noMatchString = "";
		var createId = "create_lookup_" + Math.floor(Math.random() * 100000000);
		if (allowCreate) {
			noMatchString = "<a id='"+createId+"' href='' class='pull-right' data-toggle='modal'>Create? </a>"
		}
		
		//initialize the select2 component
		sel.select2({
			// No matches found
			formatNoMatches: function () { 
				
				return  "No matches found." + noMatchString; 
			}
		});
		var values = [];

		if(isMultiple){
			//console.log("multiple");
			sel.on("change", function (e){
				var vals = e.val;
				var indexes = [];
				var values = [];
				var idx;
				if(vals){
					vals.forEach(function (index){
						idx = parseInt(index)
						indexes.push(idx);
						if(prop){
							values.push(scope[list][idx][prop])
						} else {
							values.push(scope[list][idx])
						}
					});

					scope.$apply(function (){
						ngModel.$setViewValue(values);	
					});
				}				
			});

			scope.$watch(attrs.ngModel , function(val){
				if(!val){
					sel.trigger("change");
				}else {
					sel.val(val).trigger('change');
				}
			});
			
		}else {
			sel.on("change",function (e){
				var selectedIdx = parseInt(e.val);

				if(selectedIdx || selectedIdx === 0){
					if(prop){
						ngModel.$setViewValue(scope[list][selectedIdx][prop]);
					}else {
						ngModel.$setViewValue(scope[list][selectedIdx]);	
					}
					scope.$digest();			
				}else {
					//the val has not been set we can set it if want
				}	
			});

			scope.$watch(attrs.ngModel , function (val){
				if(val){
					var selectedIdx = parseInt(val);
					setTimeout(function (){
						sel.trigger("change");				
					},100)
						
				}else {
					// sel.val("").trigger("change");
				}	
			});			
		}
		
		if (allowCreate) {
			$(".select2-drop").on("click", "#"+createId,function (ev){
				$rootScope.$broadcast("dynamic_look_up_creation", { model: createModel} );
				return false;
			});
		}
		
	}
 
	return { 
		require: '?ngModel',
		restrict : "E",
		link : linkFn
	}	
}]);