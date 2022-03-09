class RealsController < ApplicationController
  impressionist :actions=> [:index]

  def index
    @reals = Real.all.order(created_at: :desc)
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
  end

  def create

    @real = Real.new(real_params)
    params[:image_posts].each do |image_post|
     @real.image_reals.build(number: params[:image_posts].length,
                                             picture: image_post["picture"])
    end

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
    params.require(:real).permit(:content).merge(user_id: current_user.id)
  end
end
