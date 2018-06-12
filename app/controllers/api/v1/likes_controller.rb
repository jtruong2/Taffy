class Api::V1::LikesController < ApplicationController

  def show
    render json: Like.is_liked(safe_params[:reader_id], params[:post_id])
  end

  def create
    like = Like.create!(user_id: safe_params[:reader_id], post_id: params[:post_id])
    if like.save
      render json: {"message" => "Successful"}
    else
      render json: {"message" => "Failed"}
    end
  end

  def destroy
    like = Like.find_by(user_id: safe_params[:reader_id])
    if like.destroy
      render json: {"message" => "Successful"}
    else
      render json: {"message" => "Failed"}
    end
  end

  private

  def safe_params
    params.require(:like).permit(:reader_id)
  end
end
