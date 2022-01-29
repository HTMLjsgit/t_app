class RealsController < ApplicationController

  def index
    @reals = Real.all.order(created_at: :desc)
  end

  def show
    @real = Real.find_by(id: params[:id])
    @user = @real.user
    @real_comments = @real.real_comments.all.order(created_at: :desc)
    @real_comment = RealComment.new
  end

  def new
    @real = Real.new
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
    @real.image = params[:image]
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
    params.require(:real).permit(:content, :user_id, images: [])
  end
end
