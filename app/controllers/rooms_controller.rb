class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @chat_posts = @room.chat_posts

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
