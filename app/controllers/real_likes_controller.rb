class RealLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :real_find, only: [:create, :destroy]
  before_action :real_like_find, only: [:destroy]
  before_action :user_check, only: [:destroy]
  def create
    if current_user.id == @real.user_id
      redirect_to root_path and return
    end
    @real.real_likes.create(user_id: current_user.id)
    redirect_to real_path(@real)
  end

  def destroy
    real = @real_like.real_id
    @real_like.destroy
    redirect_to real_path(real)
  end

  private

  def user_check
    if @real_like.user_id != current_user.id
      redirect_to root_path and return
    end
  end
  def real_like_find
    @real_like = RealLike.find params[:id]
  end
  def real_find
    @real = Real.find params[:real_id]
  end
end
