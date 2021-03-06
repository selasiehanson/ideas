class UsersController < ApplicationController
  
  before_filter :signed_in_user, only: [:index] 

  def index
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(params[:user])
  	if @user.save
      
      UserEmail.signup_notify(@user).deliver

  		sign_in @user
  		flash[:success] = "Welcome to My Tots. Quickly start keeping track of your Ideas"
  		redirect_to projects_url
  	else
  		flash[:error] = err_msg(@user)
  		redirect_to new_signup_url
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end


  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated successfully"
      redirect_to @user
    else
      flash.now[:error] = err_msg(user)
      render 'edit'
    end
  end

end
