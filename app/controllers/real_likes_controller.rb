class RealLikesController < ApplicationController
  def create
    @real_like = RealLike.new(user_id: current_user.id, real_id: params[:id])
    @real_like.save
    redirect_to(real_path)
  end

  def destroy
    RealLike.find_by(user_id: current_user.id, real_id: params[:id]).destroy
    redirect_to (real_path)
  end
end
