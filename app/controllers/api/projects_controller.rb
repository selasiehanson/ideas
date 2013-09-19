class Api::ProjectsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :show, :destroy]
  before_filter :fetch_project, only: [:show, :update, :destroy]

  def index
    projects = current_user.projects
    render :json => { data: projects, message: "", success: true, total: projects.length }
  end

  def show
  end

  def create
    success = false
    @project = current_user.projects.build(params[:project])
    if @project.save
      msg = "Project '#{@project.title}' successfully created!"    
      success = true
    else
      msg = err_msg(@project)
    end

    render :json => { data: [@project ], message: msg, success: success}
  end

  def update
    success = false
    if @project
      
      if @project.update_attributes(params[:project])
        msg  = "Project '#{@project.title}' updated succesffuly"
        success = true
        data = [@project]
      else
        msg = err_msg(@project)
      end  
    else
      data = nil
    end

    render :json => { data: data, success: success, message: msg }
  end

  def destroy
  end
end
