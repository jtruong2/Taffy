class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: safe_params[:email])
    if user && user.authenticate(safe_params[:password])
      log_in(user)
      render json: {status: "logged in", user: user}
    else
      render json: {status: "login failed", code: 403, message: "Email or password is incorrect"}
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {status: "logged out"}
  end

  def show
    render json: current_user
  end

  private

  def safe_params
    params.permit(:email, :password)
  end
end
