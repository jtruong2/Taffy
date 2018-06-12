class Api::V1::PostsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    render json: user.posts, serializer: nil
  end

  def show
    post = Post.find(params[:post_id])
    render json: post, serializer: PostSerializer
  end

  def create
    post = Post.create!(user_id: params[:user_id], text_content: safe_params['text_content'])
    if post.save
      render json: post
    else
      render json: {"message" => "Failed"}
    end
  end

  def update
    post = Post.find(params[:post_id])
    if post.update(safe_params)
      render json: post
    else
      render json: {"message" => "Failed"}
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    if post.delete
      render json: {"message" => "Post Deleted"}
    else
      render json: {"message" => "Failed"}
    end
  end

  private

  def safe_params
    params.require(:post).permit(:text_content)
  end
end
