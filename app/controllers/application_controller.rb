class ApplicationController < ActionController::Base
  	protect_from_forgery
  	include SessionsHelper

  	protected
	    def fetch_project
	    	id = params[:id] || params[:project_id]
	      @project = Project.find(id)
	    end
	  	def err_msg(obj)
	      "Error. #{obj.errors.full_messages.to_sentence}"
	    end
end
