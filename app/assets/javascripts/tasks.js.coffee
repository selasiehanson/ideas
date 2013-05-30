# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	submit_form = ->
		if($(this).is(':checked'))
			id = $(this).parent().attr("id")
			$("#" + id).submit()
			console.log(id)
		else
		 console.log("somthing is wrong")

	$(".pending input[type='checkbox']").click(submit_form)
	$(".started input[type='checkbox']").click(submit_form)