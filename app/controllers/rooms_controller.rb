class RoomsController < ApplicationController
  def show
    if @room = Room.find(params[:id])
      @posts = @room.chat_posts
      @room_userid = UserRoom.where(:room_id => params[:id]).to_a
      ChatPost.where.not(:user_id => @room_userid[0].user_id).where(:room_id => params[:id]).update_all("see = 1")
      @this_user = User.find(@room_userid[0].user_id)
      print @posts.to_a
      print @room_userid
      print @this_user
      print " yeaea"
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
