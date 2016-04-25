class PasswordResetsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email params[:email]
    if user
      user.generate_password_reset_data
      # binding.pry
      PasswordResetsMailer.send_instructions(user).deliver_now

    end
  end

  def edit
    # ! will redirect to 404 page if record not found
    @user = User.find_by_password_reset_token! params[:id]
  end

  def update
    @user = User.find_by_password_reset_token! params[:id]
    user_params = params.require(:user).permit([:password,:password_confirmation])
    if @user.password_reset_expired?
      redirect_to new_password_reset_path, alert: "Password reset expired,try again"
    elsif @user.update user_params
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Password was reset successfully!"
    else
      render :edit
    end
  end

end
