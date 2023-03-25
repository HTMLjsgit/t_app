class RealsController < ApplicationController
  impressionist :actions=> [:index]
  before_action :authenticate_user!, only: [ :create, :update, :edit, :new, :destroy]
  before_action :real_get, only: [:edit, :update, :destroy]
  before_action :admin_and_user_check, only: [:edit, :update, :destroy]
  def index
    @type = "others"
    if user_signed_in?
      if params[:type].present?
        @type = params[:type]
      end
    end

    if @type == "others"
      @reals = Real.all.includes(:image_reals).distinct
    elsif @type == "follows"
      following_users = current_user.following_user
      user_ids = following_users.ids
      @reals = Real.all.where(user_id: user_ids).includes(:image_reals).distinct
    else
      @reals = Real.all.includes(:image_reals).distinct
    end

  end

  def show
    @real = Real.find_by(id: params[:id])
    @real_like_current = nil
    if user_signed_in?
      @real_like_current = RealLike.like_attach(current_user, @real.id)
    end
    @user = @real.user

    @real_comments = @real.real_comments.all.order(created_at: :desc)
    @real_comment = @real.real_comments.new
    if current_user.present? then
      if (current_user.id != @real.user_id) then
        impressionist(@real)
      end
    end
  end

  def new
    @real = Real.new
    @real_tag = @real.real_tags.build
    @images_real = @real.image_reals.build()
  end

  def create

    @real = Real.new(real_params)
    @real.real_images_params = real_params[:image_reals_attributes]
    @real.save!
    redirect_to real_path(@real)
  end

  def edit
  end

  def update
    @real.content = params[:content]
    @real.save
    redirect_to(reals_path)
  end

  def destroy
    @real.destroy
    redirect_to(reals_path)
  end

  private
  def real_params
    params.require(:real).permit(:content, image_reals_attributes: [:id, :_destroy, :picture], real_tags_attributes: [:id,:_destroy, :tag]).merge(user_id: current_user.id)
  end
  def real_get
    @real = Real.find params[:id]
  end
  def admin_and_user_check
    if current_user.id != @real.user_id && !current_user.admin
      redirect_to root_path and return
    end
  end
end
