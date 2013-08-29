angular.module("widgetbox_component",[]).directive("axWbox", function (){
		var compileFn;
		
		compileFn =  function (element,attrs){
			var params = attrs["params"];
			if(params){
				
			}

			var maxamizedIcon = "icon-chevron-down"; 
			var minimizedIcon = "icon-chevron-up";

			var widgetHTML = "<div class='widget-box'> "+
				"<div class='widgetbox_header clearfix'> "+
					"<i class='icon-signal'></i> "+
					"<span class='break'></span> "+
					"<span class='title'>  </span> "+
					"<div class='icon_box pull-right'> "+
						"<a href='' class='btn-minimize'><i class='"+ minimizedIcon +"'></i></a>" +
						//"<a href='#' class='btn-close'><i class='icon-remove'></i></a> "+
					"</div> "+
				"</div> "+
				"<div class='widgetbox_body'> "+
				"</div> "+
			"</div>";

			
		 	var childElement = element.children()[0];
			element.html(widgetHTML);
			$(element).find(".widgetbox_body").append(childElement);

			return {
				pre : function (scope, linkElement,attrs) {
					var isOpened = true;
					var widgetTitle = attrs["title"];
					var el = $(linkElement);
					
					el.find(".widgetbox_header .title").text(widgetTitle);
					var minimizeBtn = el.find(".widgetbox_header .btn-minimize");
					var closeBtn = el.find(".widgetbox_header .btn-close");
					var body = el.find(".widgetbox_body");
					var openedIcon = minimizeBtn.find("i");
					minimizeBtn.bind("click", function (){
						isOpened = !isOpened;

						if(isOpened){
							body.show(200);
							openedIcon.removeClass();
							openedIcon.addClass(minimizedIcon)
						}else {
							body.hide(200);
							openedIcon.removeClass();
							openedIcon.addClass(maxamizedIcon)
						} 
					});

					//closeBtn.bind("click", function (){
						//el.remove()
					//})
				},
				post : function (scope, iElement, iAttrs, controller) {
					
			    }
			}
		}
		
		return { 
			restrict : "E",
			compile : compileFn
		}

	})