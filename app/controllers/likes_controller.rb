class LikesController < ApplicationController

  def create
    @like = Like.new(user_id: current_user.id, post_id: params[:id])
    @like.save
    redirect_to(post_path(@like.post_id))
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:id]).destroy
    redirect_to (post_path(@link.post_id))
  end
end
