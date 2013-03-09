class UsersController < ApplicationController
  def new
  	@user  =  User.new
  end

  def create
  	@user = User.create(params[:user])
  	if @user.save
  		sign_in @user
  		flash.now[:success] = "Welcome to Me Tots. Quickly start keeping track of your Ideas"
  		redirect_to projects_url
  	else
  		flash.now[:error] = "Sorry something went wrong please try again"
  		render 'new'
  	end
  end

  def edit
  	
  end


  def update
  	
  end

end
