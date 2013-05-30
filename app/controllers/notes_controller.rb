class NotesController < ApplicationController
	def create
		@note = Project.find(params[:project_id]).notes.build(params[:note])
		if @note.save
			flash[:success] = "Note successfully created."
		else
			flash[:error] = "There was a problem creating the note. Please try again."
		end
		redirect_to project_path(params[:project_id])
	end

	def edit
		@project = Project.find(params[:project_id])
		@note = Note.find(params[:id])
	end

	def update
		@note = Note.find(params[:id])
		@project = Project.find(params[:project_id])
		if @note.update_attributes(params[:note])
			flash[:success] = "Note updated successfully"
			redirect_to project_path(@project)
		else
			flash[:error] = "Error. #{@note.errors.full_messages.to_sentence}"
			render :edit
		end
	end

	def destroy
		note = Note.find(params[:id])
		if note.destroy
			flash[:success] = "Note removed."
		end
		redirect_to(Project.find(params[:project_id]))
	end
	
end
