class ApplicationController < ActionController::Base
  	protect_from_forgery
  	include SessionsHelper

  	def err_msg(obj)
      "Error. #{obj.errors.full_messages.to_sentence}"
    end
end
