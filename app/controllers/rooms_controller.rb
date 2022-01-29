class RoomsController < ApplicationController
  def show
    if @room = Room.find(params[:id])
      @posts = @room.chat_posts
      ChatPost.where.not(:user_id => current_user.id).where(:room_id => params[:id]).update_all("see = 1")
    end
  end

  def create
    @room = Room.new
    @room.save
    current_user.user_rooms.create(room_id: @room.id, to_user_id: params[:to_user_id])
    redirect_to @room
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end

end
