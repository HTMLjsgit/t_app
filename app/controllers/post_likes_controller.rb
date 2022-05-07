class PostLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :post_find
  before_action :already_liked?, only: [:create]
  before_action :post_like_find, only: [:destroy]
  before_action :user_check, only: [:destroy]
  def create
    @post.post_likes.create!(user_id: current_user.id)
    redirect_back(fallback_location: root_path)
  end
  def destroy
    @post_like.destroy!
    redirect_back(fallback_location: root_path)
  end
  private
  def post_find
    @post = Post.find params[:post_id]
  end
  def already_liked?
    post_like = PostLike.like_attach(current_user, @post.id)
    if post_like.present?
      redirect_to root_path and return
    end
  end
  def post_like_find
    @post_like = PostLike.find params[:id]
  end
  def user_check
    if current_user.id != @post_like.user_id
      redirect_to root_path and return
    end
  end
end
