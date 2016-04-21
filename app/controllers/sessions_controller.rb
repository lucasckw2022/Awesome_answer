class SessionsController < ApplicationController
  #check if the user has signed in first
  before_action :redirect_if_loggedin, only: [:new, :create]

def new

end

def create
  #find the user by email
  user = User.find_by_email params[:email]
  if user && user.authenticate(params[:password])
    #assign the session to user.id
    session[:user_id] = user.id
    redirect_to root_path
  else
    flash[:alert] = "Wrong Credentials"
    render :new
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_path,notice: "Signed Out"
end

private

 def redirect_if_loggedin
   redirect_to root_path, notice: "Already logged in" if user_signed_in?
 end

end
