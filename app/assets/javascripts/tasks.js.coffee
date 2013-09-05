$ ->
	submit_form = ->
		if($(this).is(':checked'))
			id = $(this).parent().attr("id")
			$("#" + id).submit()
			console.log(id)
		else
		 console.log("somthing is wrong")

		return
	
	resize_task_list = ->
		listArea = $(".task_list .list_area")
		newHeight = parseInt($(window).height()) - 160
		listArea.css("max-height", newHeight + "px")
		console.log newHeight
		return

	enter = ->
		$(this).find(".actions").show()

	leave = ->
		$(this).find(".actions").hide()

	
	$(".list_area").on("mouseenter",".task_row", enter).on("mouseleave", ".task_row", leave)	
	
	$(".pending input[type='checkbox']").click(submit_form)
	$(".started input[type='checkbox']").click(submit_form)
	
	$(window).resize(resize_task_list)
	resize_task_list

	return