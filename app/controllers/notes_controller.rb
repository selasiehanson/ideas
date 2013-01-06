class NotesController < ApplicationController
	
	def create
		@note = Project.find(params[:project_id]).notes.build(params[:note])
		if @note.save
			flash[:succes] = "Note successfully created"
		else
			flash[:error] = "There was a problem creating the note. Please try again."
		end
		redirect_to project_path(params[:project_id])
	end

	
end
