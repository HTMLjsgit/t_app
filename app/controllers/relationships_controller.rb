class RelationshipsController < ApplicationController
  def follow
    current_user.follow(params[:id])
    redirect_to user_path
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to user_path
  end
end
