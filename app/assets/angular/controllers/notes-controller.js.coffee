app = angular.module "app"

NotesController = ($scope, Note, Task, MSG)->
	$scope.hasNotes = false;
	$scope.note = {}
	$scope.notes = []
	$scope.len = 1
	$scope.personCount = 1


	$scope.submit = ()->
		$scope.isSaving = true
		note = new Note($scope.note)
		if $scope.note.id
			note.$update (res)=>
				$scope.isSaving =  false
				afterSave(res)				
				if res.success
					_note = _.find $scope.notes, (item)=>
						item.id ==  $scope.note.id
					idx = $scope.notes.indexOf(_note)
					$scope.notes[idx] = res.data[0]
					defaults()

		else
			note.$save (res)=>
				$scope.isSaving =  false
				afterSave(res)
				if res.success
					$scope.notes.unshift res.data[0]
		return
	
	$scope.createTask = (note)->

		return
	
	$scope.editNote =  (note) ->
		$scope.note = note
		$scope.buttonText = "Update"
		$scope.formTitle = "Edit"
		return

	$scope.deleteNote = (_note , index) ->
		note = new Note(_note)
		note.$delete (res)=>
			afterDelete(res, index)
		return

	afterSave = (res)->
		notify(res.success, res.message)
		$scope.note.content = ""
		return

	notify = (status, message) ->
		if status
			MSG.success(message)
		else
			MSG.error(message)

	afterDelete = (res, index)->
		notify(res.success, res.message)
		if res.success
			$scope.notes.splice index, 1
		return
	defaults = ()->
		$scope.buttonText = "Create"
		$scope.formTitle = "New"

	getNotes = () ->
		Note.query { project_id: $scope.note.project_id },(res)=>
			$scope.notes = res.data
			if $scope.notes.length > 0
				$scope.hasNotes = true
			return
		return
	setTimeout(getNotes, 100)
	defaults()
	
	return
		
app.controller "NotesController", NotesController