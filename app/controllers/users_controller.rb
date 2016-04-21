class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:first_name,:last_name,:email,:password,:password_confirmation])
    @user = User.new user_params
    if @user.save
      # we log the user in by setting the session :user_id to the user's id
      # in our database so we can identify the user who is logged in by their id
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created!"
    else
      render :new
    end
  end
end
