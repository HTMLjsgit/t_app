class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :new, :edit, :update, :destroy]
  before_action :post_find, only: [:show, :edit, :update, :destroy]
  before_action :already_payment_check, only: [:show]
  def index
    @posts = Post.all.order(created_at: :desc)
    gon.stripe_public_key = Rails.configuration.stripe[:public_key]

  end

  def show
    # @post = Post.find_by(id: params[:id])　のコードは private以下に記述していてbefore_action で渡しています。
    @user = @post.user
    @posts_id = params[:posts_id]
    @comment = Comment.new
    @comments = @post.comments.all.order(created_at: :desc)
    @comments = Comment.where(post_id: @post.id)
    @comments_count = Comment.where(post_id: @post.id).count
  end

  def new
  end

  def create
    @post = Post.new(user_id: current_user.id,content: params[:content], amount: params[:amount])

    commission = @post.amount * 0.15 #手数料15%

    @post.commission = commission

    @post.save
    redirect_to(posts_path)
  end

  def edit
    # @post = Post.find_by(id: params[:id])　のコードは private以下に記述していてbefore_action で渡しています。
  end

  def update
    # @post = Post.find_by(id: params[:id])　のコードは private以下に記述していてbefore_action で渡しています。
    @post.content = params[:content]
    @post.save
    redirect_to(posts_path)
  end


  def destroy
    # @post = Post.find_by(id: params[:id])　のコードは private以下に記述していてbefore_action で渡しています。
    @post.destroy
    redirect_to(posts_path)
  end

  private 

  def already_payment_check
    # 支払いができていないのであれば
    unless current_user.payments.find_by(post_id: @post.id, user_id: current_user.id).present?
      # 強制的にトップに戻す。
      redirect_to root_path and return
    end
  end

  def post_find
    @post = Post.find_by(id: params[:id])
  end
end
