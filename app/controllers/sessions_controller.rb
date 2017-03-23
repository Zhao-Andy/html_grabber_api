class SessionsController < ApplicationController
  SIGNUP = "Sign up"
  LOGIN = "Login"

  def new
  end

  def login
    user = User.find_by(email: params[:user][:email])
    if user
      session[:user_id] = user.id
      flash[:alert] = "You've logged in!"
    else
      flash[:alert] = "Email not found."
    end
    redirect_to '/'
  end

  def signup
    user = User.create(email: params[:user][:email], api_key: SecureRandom.base64(16))
    if user.valid?
      session[:user_id] = user.id
    else
      flash[:alert] = "Email invalid or email is taken."
    end
    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "You've logged out!"
    redirect_to '/'
  end
end
