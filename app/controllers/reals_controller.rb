class RealsController < ApplicationController
  impressionist :actions=> [:index]
  before_action :authenticate_user!, only: [:show, :create, :update, :edit, :new, :destroy]
  def index
    reals_id = ImageReal.pluck(:real_id)
    if params[:mode] == "camera"
      @reals = Real.all.where(id: reals_id).includes(:image_reals).distinct
      @mode = "camera"
    elsif params[:mode] == "char"
      @reals = Real.all.where.not(id: reals_id).includes(:image_reals).distinct
      @mode = "char"
    else
      @reals = Real.all.where(id: reals_id).includes(:image_reals).distinct
      @mode = "camera"
    end
  end

  def show
    @real = Real.find_by(id: params[:id])
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
