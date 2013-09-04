app = angular.module "app"

app.controller "NotesController",["$scope", "Note", "Task", "MSG", "$location", "Data", ($scope, Note, Task, MSG, location, Data)->
	$scope.hasNotes = false
	$scope.note = {}
	$scope.notes = []
	$scope.location = location
	
	$scope.data = Data
	$scope.clear = ()->
		$scope.note = {}
		defaults()

	$scope.submit = ()->
		$scope.isSaving = true
		note = new Note($scope.note)
		note.project_id = $scope.data.project_id
		id = note.id
		if $scope.note.id
			note.$update (res)=>
				$scope.isSaving = false
				afterSave(res)
				if res.success
					updateNoteAfterSave(id, res.data[0])
					defaults()

		else
			note.$save (res)->
				$scope.isSaving = false
				afterSave(res)
				if res.success
					if $scope.notes.length == 0 then $scope.notes.push(res.data[0]) else  $scope.notes.unshift(res.data[0])
					
						
		return
	
	$scope.createTask = (note)->
		_newTask = angular.copy(note)
		_newTask.note_id = _newTask.id
		delete _newTask.id 
		
		task =  new Task(_newTask)
		task.$save (res)->
			if res.success
				idx = $scope.notes.indexOf(note)
				$scope.notes.splice(idx, 1)
				MSG.success(res.message)

				updateTaskAfterCreate(res.data)

				$scope.view.showTasks = true
			return
		return
	
	$scope.editNote =  (note)->
		$scope.note = angular.copy(note)
		$scope.buttonText = "Update"
		$scope.formTitle = "Edit"
		return

	$scope.deleteNote = (_note, index)->
		note = new Note(_note)
		note.$delete (res)->
			afterDelete(res, index)
		return

	$scope.$watch "data.project_id", (val)->
		if val
			getNotes(val)
		return

	afterSave = (res)->
		notify(res.success, res.message)
		$scope.note = {}
		return

	notify = (status, message)->
		if status
			MSG.success(message)
		else
			MSG.error(message)

	updateNoteAfterSave = (id, newObject)->
		_note = _.find $scope.notes, (item)->
			item.id == id
		idx = $scope.notes.indexOf(_note)
		$scope.notes[idx] = newObject

	updateTaskAfterCreate = (rec)->
		$scope.data.project.tasks.push(rec)
		$scope.data.tasksChanged = true
		return

	afterDelete = (res, index)->
		notify(res.success, res.message)
		if res.success
			$scope.notes.splice index, 1
		return
	
	defaults = ()->
		$scope.buttonText = "Create"
		$scope.formTitle = "New"
		# $scope.note.content = ""

	getNotes = (project_id)->
		# Note.query { project_id: project_id },(res)->
		$scope.notes = $scope.data.project.notes
		if $scope.notes.length > 0
			$scope.hasNotes = true
		
		return
	
	defaults()
	return]