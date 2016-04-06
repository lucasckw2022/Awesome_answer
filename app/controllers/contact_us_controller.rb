class ContactUsController < ApplicationController
  def new
  end
  def create
    @name = params[:full_name]
  end
end
