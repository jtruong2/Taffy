class Api::V1::UsersController < ApplicationController
  def show
    render json: User.find(params[:user_id])
  end

  def create
    user = User.new(safe_params)
    if user.save
      render json: user
    else
      render json: { "message" => "Could not perform action" }
    end
  end

  def update
    user = User.find(params[:user_id])
    if user.update(safe_params)
      render json: user
    else
      render json: { "message" => "Could not perform action" }
    end
  end

  private

  def safe_params
    params.require(:user).permit(:email, :alias_name, :password)
  end
end
