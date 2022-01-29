class PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)

  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @posts_id = params[:posts_id]
    @comment = Comment.new
    @comments = @post.comments.all.order(created_at: :desc)
    @comments = Comment.where(post_id: @post.id)
    @comments_count = Comment.where(post_id: @post.id).count

    gon.stripe_public_key = Rails.configuration.stripe[:public_key]
  end

  def new
  end

  def create
    @post = Post.new(user_id: current_user.id,content: params[:content], amount: params[:amount])
    @post.save
    redirect_to(posts_path)
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.save
    redirect_to(posts_path)
  end


  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to(posts_path)
  end
end
