class ApplicationController < ActionController::Base
  	protect_from_forgery
  	include SessionsHelper

  	protected
	    def fetch_project
	      @project = Project.find(params[:id])
	    end
	  	def err_msg(obj)
	      "Error. #{obj.errors.full_messages.to_sentence}"
	    end
end
