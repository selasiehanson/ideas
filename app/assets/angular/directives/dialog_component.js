var app = angular.module("dialog", []);

app.directive("axDialog", [function (){

	var linkFn = function (scope, element, attrs){
		var klass = attrs.type 
		
		switch(attrs.type)
		{
			case "ax-alert":
				klass = "ax-alert"
			break;
			case "ax-form":
			break;
			default:
				klass = "";
		}
		$(element).addClass(klass)
	}
	var template = [
		'<div ng-show="visible" class="ax-dialog">',
			'<div class="modal {{visible}}">',
			  '<div class="modal-header">',
			    '<button type="button" class="close" data-dismiss="modal" ng-click="onCancel()" aria-hidden="true">&times;</button>',
			    '<h3> {{ title }}</h3>',
			  '</div>',
			  '<div class="modal-body" ng-transclude>',
			  '</div>',
			  '<div class="modal-footer form-actions">',
			  	'<span class="ax-loader pull-left" text="{{ processingText }}" visible="showLoader"></span>',
			    '<a href="" class="btn btn-primary" ng-click="onOk()">{{ okLabel }}</a>',
			    '<a href="" class="btn" ng-click="onCancel()">Cancel</a>',
			  '</div>',
			'</div>',
		'</div>'
	]
	return {
		restrict: "E",
		link : linkFn,
		scope: {
			okLabel: "@",
			title: "@",
			visible: "=",
			onOk : "&",
			onCancel: "&",
			processingText: "@",
			showLoader: "="
		},
		replace: true,
		transclude: true,
		template: template.join("")
	}
}]);