class Api::ProjectCategoriesController < ApplicationController
   before_filter :signed_in_user, only: [:index, :edit, :update, :show, :destroy]
  def index
    project_categories = current_user.project_categories 
    render :json => { data: project_categories, message: "", success: true ,total: project_categories.length}
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
