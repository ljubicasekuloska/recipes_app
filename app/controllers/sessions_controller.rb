class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      #add code for log in
    else
      #add error message here
      render :new
    end
  end

  def destroy
  end
end