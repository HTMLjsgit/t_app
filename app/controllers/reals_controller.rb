class RealsController < ApplicationController
  impressionist :actions=> [:index]
  before_action :authenticate_user!, only: [:show, :create, :update, :edit, :new, :destroy]
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
    @real_like_current = RealLike.like_attach(current_user, @real.id)

    @user = @real.user

    @real_comments = @real.real_comments.all.order(created_at: :desc)
    @real_comment = RealComment.new
    if current_user.present? then
      if (current_user.id != @real.user_id) then
        impressionist(@real)
      end
    end
  end

  def new
    @real = Real.new
    @images_real = @real.image_reals.build()
  end

  def create

    @real = Real.new(real_params)
    @real.save!

    redirect_to(reals_path)
  end

  def edit
    @real = Real.find_by(id: params[:id])
  end

  def update
    @real = Real.find_by(id: params[:id])
    @real.content = params[:content]
    @real.save
    redirect_to(reals_path)
  end

  def destroy
    @real = Real.find_by(id: params[:id])
    @real.destroy
    redirect_to(reals_path)
  end

  private
  def real_params
    params.require(:real).permit(:content, image_reals_attributes: [:id, :_destroy, :picture]).merge(user_id: current_user.id)
  end
end
