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
      msg = "Project Idea successfully created!"    
      success = true
    else
      msg = @project.errors.full_messages.to_sentence
    end

    render :json => { data: [@project ], message: msg, success: success}
  end

  def update
    success = false
    if @project
      @project.title = params[:project][:title]
      @project.description = params[:project][:description]
      @project.project_category = ProjectCategory.find(params[:project][:project_category_id])
      
      if @project.save
        msg  = "Project '#{@project.title}' Updated succesffuly"
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

  private
    def fetch_project
      @project = Project.find(params[:id])
    end
end
