/**
*this is the tab component on the angularjs page
*/
angular.module('tab_component', []).
  directive('tabs', [function() {
      return {
        restrict: 'E',
        transclude: true,
        scope: {},
        controller: function($scope, $element) {
          var panes = $scope.panes = [];
          var self = this;
          $scope.select = function(pane) {
            self.select(pane)
          }
    
          this.select = function(pane) {
            angular.forEach(panes, function(pane) {
              pane.selected = false;
              //disable other tabs visible property
              pane.visible = false;
            });
            pane.selected = true;
          }
  
          this.addPane = function(pane) {
            if (panes.length == 0) $scope.select(pane);
            panes.push(pane);
            window.pp = pane
          }
        },
        template:
          '<div class="tabbable">' +
            '<ul class="nav nav-tabs tab_headers">' +
              '<li ng-repeat="pane in panes" ng-class="{active:pane.selected}">'+
                '<a href="" ng-click="select(pane)">{{pane.title}}</a>' +
              '</li>' +
            '</ul>' +
            '<div class="tab-content" ng-transclude></div>' +
          '</div>',
        replace: true
      };
    }]).
  directive('pane', [function() {
      return {
        require: '^tabs',
        restrict: 'E',
        transclude: true,
        scope: { title: '@', visible: '='},
        link: function(scope, element, attrs, tabsCtrl) {
          tabsCtrl.addPane(scope);
          scope.$watch("visible", function (val){
            
            if(val){
              tabsCtrl.select(scope);
            }
          })
        },
        template:
          '<div class="tab-pane" ng-class="{active: selected}" ng-transclude>' +
          '</div>',
        replace: true
      };
  }]);