class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :new, :edit, :update, :destroy]
  before_action :post_find, only: [:show, :edit, :update, :destroy, :post_explanation]
  before_action :already_payment_check, only: [:show]
  before_action :payment_check_for_view, only: [:post_explanation]
  impressionist :actions=> [:show]
  before_action :authenticate_user!, only: [:show, :create, :update, :edit, :new, :destroy]
  include CommonPaymentSettings
  before_action :payment_setting_get, only: [:edit, :new, :index, :post_explanation]
  def index
    @type = "others"
    if user_signed_in?
      if params[:type].present?
        @type = params[:type]
      end
    end
    gon.stripe_public_key = Rails.configuration.stripe[:public_key]
    if @type == "others"
      @posts = Post.all.order(created_at: :desc).includes(:post_likes)
    elsif @type == "follows"
      user_ids = current_user.following_user.ids
      @posts = Post.where(user_id: user_ids).order(created_at: :desc).includes(:post_likes)
    elsif @type == "buy"
      @posts = Post.all.order(payments_count: :desc).includes(:post_likes)
    else
      @posts = Post.all.order(created_at: :desc).includes(:post_likes)
    end
  end

  def show
    # @post = Post.find_by(id: params[:id])　のコードは private以下に記述していてbefore_action で渡しています。
    @user = @post.user
    @comment = @post.comments.build
    @comments = @post.comments.all.order(created_at: :desc)
    @comments_count = @comments.count
  end

  def new
    @post = Post.new
    @image_post = @post.image_posts.build
    @post_thumbnail = @post.post_thumbnails.build
    @post_tag = @post.post_tags.build

  end

  def create
    @post = Post.new(post_params)
    post_tags = @post.post_tags
    @post.save

    redirect_to(posts_path)
  end

  def post_explanation
    @posts = Post.all
    gon.stripe_public_key = Rails.configuration.stripe[:public_key]
    if user_signed_in?
      if current_user.id != @post.user_id
        impressionist(@post)
      end
    end

  end

  def edit
  end

  def update
    @post.update!(post_params)
    redirect_to(posts_path)
  end


  def destroy
    @post.destroy
    redirect_to(posts_path)
  end

  private

  def already_payment_check
    # 支払いができていないのであれば
    if user_signed_in?
      #支払いを終えているまたは投稿したのが自分であるまたは管理者である場合はスルーする。
      unless current_user.payments.find_by(post_id: @post.id, user_id: current_user.id).present? || current_user.id == @post.user.id || current_user.admin
        # 強制的に説明ページに戻す。
        redirect_to post_explanation_post_path(@post) and return
      end
    end
  end

  def payment_check_for_view
    if current_user.present?
      #支払いを終えているまたは投稿したのが自分であるまたは管理者である場合はpayment_checkがtrueとなる
      if current_user.payments.find_by(post_id: @post.id, user_id: current_user.id).present? || current_user.admin || current_user.id == @post.user_id
        @payment_check = true
      else
        @payment_check = false
      end
    end
  end

  def post_params
    params.require(:post).permit(:content, :amount, :description, :title, :poster, image_posts_attributes: [:picture, :id, :_destroy], post_thumbnails_attributes: [:picture, :id, :_destroy], post_tags_attributes: [:tag, :id, :_destroy]).merge(user_id: current_user.id)
  end

  def post_find
    @post = Post.find_by(id: params[:id])
  end

end
