class Api::ProjectsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :show, :destroy]
  
  def index
    projects = current_user.projects
    render :json => { data: projects, message: "", success: true, total: projects.length }
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
