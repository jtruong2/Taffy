class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  protect_from_forgery unless:-> {request.format.json?}

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
