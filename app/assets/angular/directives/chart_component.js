var chartModule = angular.module("charts",[]);
chartModule.directive("axPieChart", function ($q, $rootScope){
	var linkFn =  function (scope, element, attrs, ngModel){
		var pieChart;
		
		//generate a unique id based on time
		
		// var width = attrs["width"] || "270" ;
		var height = attrs["height"] || "300";
		var time = (new Date).getTime();
		
		var id = (attrs["cid"] || time) ;
		var _attrs ={ 
			id : id,
			width : "100%",
			height: height
		}
		var div = $("<div>").attr(_attrs);
		var wrapper = element.append(div);
		var promise = scope.loadFn();

		function getPieData (config){
			var self = pieChart;
			if(!window.pc)
				window.pc = []
			window.pc.push(pieChart) 
			var title = config.title ;

			var newSeries = {
				type : 'pie',
				name : config.series,
				data : config.data			
			}
			
			//remove other series first
			self.series.forEach(function (_series){
				_series.remove(true);
			});

			//add the new series
			self.addSeries(newSeries, true);

			//set the new title
			pieChart.setTitle({ text: title });
		}

		$rootScope.$on('chartDataReceived', function (ev, data){
			if(data.id === id){
				getPieData(data);	
			}
		});

		function initializeGraph(){
			var self = this;
			pieChart =  new Highcharts.Chart({
				chart : {
					renderTo: id,
	                plotBackgroundColor: null,
	                plotBorderWidth: null,
	                plotShadow: false,
	                width : width,
	                height : height
				},
				title : {
					text : ""
				},
				tooltip: {
	                pointFormat: '{series.name}: <b>{point.percentage}%</b>',
	                percentageDecimals: 2
	            },
	            plotOptions: {
	                // pie: {
	                //     allowPointSelect: true,
	                //     cursor: 'pointer',
	                //     dataLabels: {
	                //         enabled: true,
	                //         color: '#000000',
	                //         connectorColor: '#000000',
	                //         formatter: function() {
	                //         	var percentage = Math.round(this.percentage *100)/100;
	                //             return '<b>'+ this.point.name +'</b>: '+ percentage +' %';
	                //         }
	                //     }
	                // }
	                pie : {
	                	allowPointSelect: true,
	                    cursor: 'pointer',
	                    dataLabels: {
	                        enabled: false
	                    },
	                    showInLegend: true
	                }
	            }
			});
		}
		
		initializeGraph();
	}

	return {
		template : "<div></div>",
		restrict : "E",
		scope : {
			series :"@",
			title : "@",
			loadFn : "&loadFunction"
		},
		require: '?ngModel',
		link : linkFn
	}
});

chartModule.directive("axBasicChart", function ($q, $rootScope){
	var gAttrs;
	var linkFn =  function (scope, element, attrs, ngModel){
		gAttrs = attrs;
		var columnChart;
		var type  = attrs.type || "line";
		var yAxisTitle = attrs.yAxisTitle || "";
		// var width = attrs["width"] || "" ;
		var height = attrs["height"] || "300";

		//generate a unique id based on time
		var time = (new Date).getTime();
		var id = (attrs["cid"] || time) ;
		var _attrs ={ 
			id : id,
			width : "100%",
			height: height
		}
		var div = $("<div>").attr(_attrs);
		var wrapper = element.append(div);
		

		function getColumnData (config){
			config = config || {}
			var title = config.title || "";

			var inSeries = config.series || []

			//set the categories
			columnChart.xAxis[0].setCategories(config.categories);

			//remove other series first
			columnChart.series.forEach(function (_series){
				_series.remove(true);
			});

			//add the new series
			inSeries.forEach(function (_series){
				columnChart.addSeries(_series, true);	
			});
			
			//set the new title
			columnChart.setTitle({ text: title });
		}

		
		scope.$watch("model", function (val) {
      getColumnData(val)
    })

		$rootScope.$on('chartDataReceived', function (ev, data){
			if(data.id === id){
				getColumnData(data);	
			}
		});

		function initializeGraph(){
			var self = this;
			columnChart =  new Highcharts.Chart({
				chart : {
					renderTo: id,
					type : type,
					height: height
				},
				title : {
					text : ""
				},
				yAxis: {
          title: {
            text: yAxisTitle
          }
	      },
				legend: {
          layout: 'vertical',
          backgroundColor: '#FFFFFF',
          align: 'left',
          verticalAlign: 'top',
          x: 100,
          y: 70,
          floating: true,
          shadow: true
	      },
	      tooltip: {
          formatter: function() {
            return ''+
                this.x +': '+ this.y;
                this.x +': '+ this.y ;

          }
      	},
     	 	plotOptions: {
          column: {
            pointPadding: 0.2,
            borderWidth: 0
	        }
	      }     
			});
		}

		window.scope = scope
		if(scope.loadFn){
			//we call this function to load in the data 
			scope.loadFn();	
		}
		
		
		initializeGraph();
	}
	
	return {
		// template : "<div></div>",
		restrict : "E",
		// transclude: false,
		scope : {
			series :"@",
			title : "@",
			model: "=ngModel",
			loadFn : "&loadFunction",
		},
		require: '?ngModel',
		link : linkFn
	}
});